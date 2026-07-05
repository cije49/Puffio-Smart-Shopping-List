import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../data/models/shopping_list.dart';
import '../data/models/shopping_list_item.dart';
import '../data/models/item_history.dart';
import '../data/models/category.dart';

/// Opens (or re-uses) the Isar database.
Future<Isar> openIsar() async {
  if (Isar.instanceNames.isNotEmpty) {
    return Future.value(Isar.getInstance());
  }

  final dir = await getApplicationDocumentsDirectory();
  return Isar.open(
    [
      ShoppingListSchema,
      ShoppingListItemSchema,
      ItemHistorySchema,
      CategorySchema,
    ],
    directory: dir.path,
    name: 'shop_list_pro',
  );
}
