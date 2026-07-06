import 'package:isar_community/isar.dart';
import '../models/item_history.dart';
import '../../core/constants.dart';
import '../../core/services/suggestion_scoring.dart';
import '../../core/services/history_merge.dart';

/// Read-only suggestion queries and favorite management on ItemHistory.
class ItemHistoryRepository {
  final Isar _isar;
  const ItemHistoryRepository(this._isar);

  // ---------------------------------------------------------------------------
  // Suggestion queries
  // ---------------------------------------------------------------------------

  /// Frequent items ranked by a frequency + recency score, so items the
  /// user buys *these days* outrank items bought often long ago.
  Future<List<ItemHistory>> getFrequent({
    required Set<String> excludedNames,
    int limit = kSuggestionLimit,
  }) async {
    final all = await _isar.itemHistorys
        .filter()
        .timesAddedGreaterThan(0)
        .or()
        .timesCheckedGreaterThan(0)
        .findAll();

    final now = DateTime.now();
    DateTime? lastUsed(ItemHistory h) {
      if (h.lastAddedAt == null) return h.lastCheckedAt;
      if (h.lastCheckedAt == null) return h.lastAddedAt;
      return h.lastAddedAt!.isAfter(h.lastCheckedAt!)
          ? h.lastAddedAt
          : h.lastCheckedAt;
    }

    final scored = all
        .where((h) => !excludedNames.contains(h.normalizedName))
        .map((h) => (
              history: h,
              score: suggestionScore(
                timesAdded: h.timesAdded,
                timesChecked: h.timesChecked,
                lastUsedAt: lastUsed(h),
                now: now,
              ),
            ))
        .where((e) => e.score > 0)
        .toList()
      ..sort((a, b) => b.score.compareTo(a.score));

    return scored.take(limit).map((e) => e.history).toList();
  }

  /// Pattern-based: items due based on purchase interval.
  /// Requires timesChecked >= kPatternMinChecks and a computable average.
  Future<List<ItemHistory>> getPatternBased({
    required Set<String> excludedNames,
    int limit = kSuggestionLimit,
  }) async {
    final all = await _isar.itemHistorys
        .filter()
        .timesCheckedGreaterThan(kPatternMinChecks - 1)
        .averageIntervalDaysIsNotNull()
        .lastCheckedAtIsNotNull()
        .findAll();

    final now = DateTime.now();
    return all.where((h) {
      if (excludedNames.contains(h.normalizedName)) return false;
      final daysSinceLast = now.difference(h.lastCheckedAt!).inDays;
      return daysSinceLast >= (h.averageIntervalDays! - kPatternWindowDays);
    }).take(limit).toList();
  }

  /// Reactive set of favorited normalized names (for star state in the UI).
  Stream<Set<String>> watchFavoriteNames() {
    return _isar.itemHistorys
        .filter()
        .isFavoriteEqualTo(true)
        .watch(fireImmediately: true)
        .map((list) => list.map((h) => h.normalizedName).toSet());
  }

  /// User-pinned favorites.
  Future<List<ItemHistory>> getFavorites({
    required Set<String> excludedNames,
  }) async {
    final all = await _isar.itemHistorys
        .filter()
        .isFavoriteEqualTo(true)
        .sortByDisplayName()
        .findAll();

    return all
        .where((h) => !excludedNames.contains(h.normalizedName))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Favorite toggle
  // ---------------------------------------------------------------------------

  /// Toggle pinned/favorite state by normalizedName.
  /// Returns the NEW state (true = now pinned), or null if the item has
  /// no history record.
  Future<bool?> toggleFavoriteByName(String normalizedName) async {
    final h = await _isar.itemHistorys
        .filter()
        .normalizedNameEqualTo(normalizedName)
        .findFirst();
    if (h == null) return null;
    await _isar.writeTxn(() async {
      h.isFavorite = !h.isFavorite;
      await _isar.itemHistorys.put(h);
    });
    return h.isFavorite;
  }

  // ---------------------------------------------------------------------------
  // Lookup
  // ---------------------------------------------------------------------------

  Future<ItemHistory?> getByNormalizedName(String normalizedName) {
    return _isar.itemHistorys
        .filter()
        .normalizedNameEqualTo(normalizedName)
        .findFirst();
  }

  /// Autocomplete search: items whose normalizedName starts with [prefix].
  /// Returns results ranked by usage: most-checked first, then most-recent.
  Future<List<ItemHistory>> searchByPrefix(
    String prefix, {
    int limit = 8,
  }) async {
    final q = prefix.toLowerCase().trim();
    if (q.isEmpty) return [];

    final all = await _isar.itemHistorys
        .filter()
        .normalizedNameStartsWith(q)
        .findAll();

    // Rank: frequent first, then recent
    all.sort((a, b) {
      final c = b.timesChecked.compareTo(a.timesChecked);
      if (c != 0) return c;
      final ad = a.lastAddedAt ?? DateTime(1970);
      final bd = b.lastAddedAt ?? DateTime(1970);
      return bd.compareTo(ad);
    });
    return all.take(limit).toList();
  }

  // ---------------------------------------------------------------------------
  // Manage history (rename / remove suggestions)
  // ---------------------------------------------------------------------------

  /// Fires whenever any history record changes (drives suggestion refresh).
  Stream<void> watchHistoryChanges() {
    return _isar.itemHistorys.watchLazy();
  }

  /// Permanently remove an item from suggestion history.
  /// Items already on shopping lists are not touched.
  Future<void> deleteByNormalizedName(String normalizedName) async {
    final h = await getByNormalizedName(normalizedName);
    if (h == null) return;
    await _isar.writeTxn(() async {
      await _isar.itemHistorys.delete(h.id);
    });
  }

  /// Rename a history entry. If the new name collides with an existing
  /// entry, the two are merged (counts summed, latest dates win).
  Future<void> renameHistory(
      String oldNormalizedName, String newDisplayName) async {
    final trimmed = newDisplayName.trim();
    final newNormalized = trimmed.toLowerCase();
    if (trimmed.isEmpty) return;

    final source = await getByNormalizedName(oldNormalizedName);
    if (source == null) return;

    // Same normalized name: just refresh the display name.
    if (newNormalized == oldNormalizedName) {
      await _isar.writeTxn(() async {
        source.displayName = trimmed;
        await _isar.itemHistorys.put(source);
      });
      return;
    }

    final existing = await getByNormalizedName(newNormalized);
    await _isar.writeTxn(() async {
      if (existing != null) {
        mergeHistoryInto(existing, source);
        existing.displayName = trimmed;
        await _isar.itemHistorys.put(existing);
        await _isar.itemHistorys.delete(source.id);
      } else {
        source.normalizedName = newNormalized;
        source.displayName = trimmed;
        await _isar.itemHistorys.put(source);
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Clear
  // ---------------------------------------------------------------------------

  Future<void> clearAll() async {
    await _isar.writeTxn(() async {
      await _isar.itemHistorys.clear();
    });
  }
}
