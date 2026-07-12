// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetItemHistoryCollection on Isar {
  IsarCollection<ItemHistory> get itemHistorys => this.collection();
}

const ItemHistorySchema = CollectionSchema(
  name: r'ItemHistory',
  id: -6084591789056520139,
  properties: {
    r'averageIntervalDays': PropertySchema(
      id: 0,
      name: r'averageIntervalDays',
      type: IsarType.double,
    ),
    r'categoryId': PropertySchema(
      id: 1,
      name: r'categoryId',
      type: IsarType.long,
    ),
    r'displayName': PropertySchema(
      id: 2,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'isFavorite': PropertySchema(
      id: 3,
      name: r'isFavorite',
      type: IsarType.bool,
    ),
    r'lastAddedAt': PropertySchema(
      id: 4,
      name: r'lastAddedAt',
      type: IsarType.dateTime,
    ),
    r'lastCheckedAt': PropertySchema(
      id: 5,
      name: r'lastCheckedAt',
      type: IsarType.dateTime,
    ),
    r'lastLocation': PropertySchema(
      id: 6,
      name: r'lastLocation',
      type: IsarType.string,
    ),
    r'lastPrice': PropertySchema(
      id: 7,
      name: r'lastPrice',
      type: IsarType.double,
    ),
    r'lastUnit': PropertySchema(
      id: 8,
      name: r'lastUnit',
      type: IsarType.string,
    ),
    r'normalizedName': PropertySchema(
      id: 9,
      name: r'normalizedName',
      type: IsarType.string,
    ),
    r'timesAdded': PropertySchema(
      id: 10,
      name: r'timesAdded',
      type: IsarType.long,
    ),
    r'timesChecked': PropertySchema(
      id: 11,
      name: r'timesChecked',
      type: IsarType.long,
    )
  },
  estimateSize: _itemHistoryEstimateSize,
  serialize: _itemHistorySerialize,
  deserialize: _itemHistoryDeserialize,
  deserializeProp: _itemHistoryDeserializeProp,
  idName: r'id',
  indexes: {
    r'normalizedName': IndexSchema(
      id: -9115371092206571671,
      name: r'normalizedName',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'normalizedName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _itemHistoryGetId,
  getLinks: _itemHistoryGetLinks,
  attach: _itemHistoryAttach,
  version: '3.3.2',
);

int _itemHistoryEstimateSize(
  ItemHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.displayName.length * 3;
  {
    final value = object.lastLocation;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lastUnit;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.normalizedName.length * 3;
  return bytesCount;
}

void _itemHistorySerialize(
  ItemHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.averageIntervalDays);
  writer.writeLong(offsets[1], object.categoryId);
  writer.writeString(offsets[2], object.displayName);
  writer.writeBool(offsets[3], object.isFavorite);
  writer.writeDateTime(offsets[4], object.lastAddedAt);
  writer.writeDateTime(offsets[5], object.lastCheckedAt);
  writer.writeString(offsets[6], object.lastLocation);
  writer.writeDouble(offsets[7], object.lastPrice);
  writer.writeString(offsets[8], object.lastUnit);
  writer.writeString(offsets[9], object.normalizedName);
  writer.writeLong(offsets[10], object.timesAdded);
  writer.writeLong(offsets[11], object.timesChecked);
}

ItemHistory _itemHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ItemHistory();
  object.averageIntervalDays = reader.readDoubleOrNull(offsets[0]);
  object.categoryId = reader.readLongOrNull(offsets[1]);
  object.displayName = reader.readString(offsets[2]);
  object.id = id;
  object.isFavorite = reader.readBool(offsets[3]);
  object.lastAddedAt = reader.readDateTimeOrNull(offsets[4]);
  object.lastCheckedAt = reader.readDateTimeOrNull(offsets[5]);
  object.lastLocation = reader.readStringOrNull(offsets[6]);
  object.lastPrice = reader.readDoubleOrNull(offsets[7]);
  object.lastUnit = reader.readStringOrNull(offsets[8]);
  object.normalizedName = reader.readString(offsets[9]);
  object.timesAdded = reader.readLong(offsets[10]);
  object.timesChecked = reader.readLong(offsets[11]);
  return object;
}

P _itemHistoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _itemHistoryGetId(ItemHistory object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _itemHistoryGetLinks(ItemHistory object) {
  return [];
}

void _itemHistoryAttach(
    IsarCollection<dynamic> col, Id id, ItemHistory object) {
  object.id = id;
}

extension ItemHistoryByIndex on IsarCollection<ItemHistory> {
  Future<ItemHistory?> getByNormalizedName(String normalizedName) {
    return getByIndex(r'normalizedName', [normalizedName]);
  }

  ItemHistory? getByNormalizedNameSync(String normalizedName) {
    return getByIndexSync(r'normalizedName', [normalizedName]);
  }

  Future<bool> deleteByNormalizedName(String normalizedName) {
    return deleteByIndex(r'normalizedName', [normalizedName]);
  }

  bool deleteByNormalizedNameSync(String normalizedName) {
    return deleteByIndexSync(r'normalizedName', [normalizedName]);
  }

  Future<List<ItemHistory?>> getAllByNormalizedName(
      List<String> normalizedNameValues) {
    final values = normalizedNameValues.map((e) => [e]).toList();
    return getAllByIndex(r'normalizedName', values);
  }

  List<ItemHistory?> getAllByNormalizedNameSync(
      List<String> normalizedNameValues) {
    final values = normalizedNameValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'normalizedName', values);
  }

  Future<int> deleteAllByNormalizedName(List<String> normalizedNameValues) {
    final values = normalizedNameValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'normalizedName', values);
  }

  int deleteAllByNormalizedNameSync(List<String> normalizedNameValues) {
    final values = normalizedNameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'normalizedName', values);
  }

  Future<Id> putByNormalizedName(ItemHistory object) {
    return putByIndex(r'normalizedName', object);
  }

  Id putByNormalizedNameSync(ItemHistory object, {bool saveLinks = true}) {
    return putByIndexSync(r'normalizedName', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByNormalizedName(List<ItemHistory> objects) {
    return putAllByIndex(r'normalizedName', objects);
  }

  List<Id> putAllByNormalizedNameSync(List<ItemHistory> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'normalizedName', objects, saveLinks: saveLinks);
  }
}

extension ItemHistoryQueryWhereSort
    on QueryBuilder<ItemHistory, ItemHistory, QWhere> {
  QueryBuilder<ItemHistory, ItemHistory, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ItemHistoryQueryWhere
    on QueryBuilder<ItemHistory, ItemHistory, QWhereClause> {
  QueryBuilder<ItemHistory, ItemHistory, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterWhereClause>
      normalizedNameEqualTo(String normalizedName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'normalizedName',
        value: [normalizedName],
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterWhereClause>
      normalizedNameNotEqualTo(String normalizedName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'normalizedName',
              lower: [],
              upper: [normalizedName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'normalizedName',
              lower: [normalizedName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'normalizedName',
              lower: [normalizedName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'normalizedName',
              lower: [],
              upper: [normalizedName],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ItemHistoryQueryFilter
    on QueryBuilder<ItemHistory, ItemHistory, QFilterCondition> {
  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      averageIntervalDaysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'averageIntervalDays',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      averageIntervalDaysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'averageIntervalDays',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      averageIntervalDaysEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'averageIntervalDays',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      averageIntervalDaysGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'averageIntervalDays',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      averageIntervalDaysLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'averageIntervalDays',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      averageIntervalDaysBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'averageIntervalDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      categoryIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'categoryId',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      categoryIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'categoryId',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      categoryIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      categoryIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      categoryIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      categoryIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categoryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      displayNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      displayNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      displayNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      displayNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'displayName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      displayNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      displayNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      displayNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      displayNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      isFavoriteEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFavorite',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastAddedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastAddedAt',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastAddedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastAddedAt',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastAddedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastAddedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastAddedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastAddedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastAddedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastAddedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastAddedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastAddedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastCheckedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastCheckedAt',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastCheckedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastCheckedAt',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastCheckedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastCheckedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastCheckedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastCheckedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastCheckedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastCheckedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastCheckedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastCheckedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastLocationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastLocation',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastLocationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastLocation',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastLocationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastLocationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastLocationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastLocationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastLocation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastLocationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastLocationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastLocationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastLocationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastLocation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastLocationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastLocation',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastLocationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastLocation',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastPriceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastPrice',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastPriceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastPrice',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastPriceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastPriceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastPriceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastPriceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastUnitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastUnit',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastUnitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastUnit',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition> lastUnitEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastUnitGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastUnitLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition> lastUnitBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUnit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastUnitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastUnitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastUnitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition> lastUnitMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastUnit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      lastUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      normalizedNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'normalizedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      normalizedNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'normalizedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      normalizedNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'normalizedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      normalizedNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'normalizedName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      normalizedNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'normalizedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      normalizedNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'normalizedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      normalizedNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'normalizedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      normalizedNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'normalizedName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      normalizedNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'normalizedName',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      normalizedNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'normalizedName',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      timesAddedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timesAdded',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      timesAddedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timesAdded',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      timesAddedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timesAdded',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      timesAddedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timesAdded',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      timesCheckedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timesChecked',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      timesCheckedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timesChecked',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      timesCheckedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timesChecked',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterFilterCondition>
      timesCheckedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timesChecked',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ItemHistoryQueryObject
    on QueryBuilder<ItemHistory, ItemHistory, QFilterCondition> {}

extension ItemHistoryQueryLinks
    on QueryBuilder<ItemHistory, ItemHistory, QFilterCondition> {}

extension ItemHistoryQuerySortBy
    on QueryBuilder<ItemHistory, ItemHistory, QSortBy> {
  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy>
      sortByAverageIntervalDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageIntervalDays', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy>
      sortByAverageIntervalDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageIntervalDays', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> sortByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> sortByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> sortByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> sortByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> sortByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> sortByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> sortByLastAddedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAddedAt', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> sortByLastAddedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAddedAt', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> sortByLastCheckedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCheckedAt', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy>
      sortByLastCheckedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCheckedAt', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> sortByLastLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastLocation', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy>
      sortByLastLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastLocation', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> sortByLastPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPrice', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> sortByLastPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPrice', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> sortByLastUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUnit', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> sortByLastUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUnit', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> sortByNormalizedName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'normalizedName', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy>
      sortByNormalizedNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'normalizedName', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> sortByTimesAdded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timesAdded', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> sortByTimesAddedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timesAdded', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> sortByTimesChecked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timesChecked', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy>
      sortByTimesCheckedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timesChecked', Sort.desc);
    });
  }
}

extension ItemHistoryQuerySortThenBy
    on QueryBuilder<ItemHistory, ItemHistory, QSortThenBy> {
  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy>
      thenByAverageIntervalDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageIntervalDays', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy>
      thenByAverageIntervalDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageIntervalDays', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> thenByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> thenByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> thenByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> thenByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> thenByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> thenByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> thenByLastAddedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAddedAt', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> thenByLastAddedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAddedAt', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> thenByLastCheckedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCheckedAt', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy>
      thenByLastCheckedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCheckedAt', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> thenByLastLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastLocation', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy>
      thenByLastLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastLocation', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> thenByLastPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPrice', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> thenByLastPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPrice', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> thenByLastUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUnit', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> thenByLastUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUnit', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> thenByNormalizedName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'normalizedName', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy>
      thenByNormalizedNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'normalizedName', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> thenByTimesAdded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timesAdded', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> thenByTimesAddedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timesAdded', Sort.desc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy> thenByTimesChecked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timesChecked', Sort.asc);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QAfterSortBy>
      thenByTimesCheckedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timesChecked', Sort.desc);
    });
  }
}

extension ItemHistoryQueryWhereDistinct
    on QueryBuilder<ItemHistory, ItemHistory, QDistinct> {
  QueryBuilder<ItemHistory, ItemHistory, QDistinct>
      distinctByAverageIntervalDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'averageIntervalDays');
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QDistinct> distinctByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryId');
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QDistinct> distinctByDisplayName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QDistinct> distinctByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFavorite');
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QDistinct> distinctByLastAddedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastAddedAt');
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QDistinct> distinctByLastCheckedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastCheckedAt');
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QDistinct> distinctByLastLocation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastLocation', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QDistinct> distinctByLastPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastPrice');
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QDistinct> distinctByLastUnit(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUnit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QDistinct> distinctByNormalizedName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'normalizedName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QDistinct> distinctByTimesAdded() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timesAdded');
    });
  }

  QueryBuilder<ItemHistory, ItemHistory, QDistinct> distinctByTimesChecked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timesChecked');
    });
  }
}

extension ItemHistoryQueryProperty
    on QueryBuilder<ItemHistory, ItemHistory, QQueryProperty> {
  QueryBuilder<ItemHistory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ItemHistory, double?, QQueryOperations>
      averageIntervalDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'averageIntervalDays');
    });
  }

  QueryBuilder<ItemHistory, int?, QQueryOperations> categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryId');
    });
  }

  QueryBuilder<ItemHistory, String, QQueryOperations> displayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayName');
    });
  }

  QueryBuilder<ItemHistory, bool, QQueryOperations> isFavoriteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFavorite');
    });
  }

  QueryBuilder<ItemHistory, DateTime?, QQueryOperations> lastAddedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastAddedAt');
    });
  }

  QueryBuilder<ItemHistory, DateTime?, QQueryOperations>
      lastCheckedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastCheckedAt');
    });
  }

  QueryBuilder<ItemHistory, String?, QQueryOperations> lastLocationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastLocation');
    });
  }

  QueryBuilder<ItemHistory, double?, QQueryOperations> lastPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastPrice');
    });
  }

  QueryBuilder<ItemHistory, String?, QQueryOperations> lastUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUnit');
    });
  }

  QueryBuilder<ItemHistory, String, QQueryOperations> normalizedNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'normalizedName');
    });
  }

  QueryBuilder<ItemHistory, int, QQueryOperations> timesAddedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timesAdded');
    });
  }

  QueryBuilder<ItemHistory, int, QQueryOperations> timesCheckedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timesChecked');
    });
  }
}
