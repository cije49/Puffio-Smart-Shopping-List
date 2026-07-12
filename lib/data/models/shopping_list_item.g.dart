// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_list_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetShoppingListItemCollection on Isar {
  IsarCollection<ShoppingListItem> get shoppingListItems => this.collection();
}

const ShoppingListItemSchema = CollectionSchema(
  name: r'ShoppingListItem',
  id: -3816175988203906805,
  properties: {
    r'addedFrom': PropertySchema(
      id: 0,
      name: r'addedFrom',
      type: IsarType.string,
    ),
    r'categoryId': PropertySchema(
      id: 1,
      name: r'categoryId',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dueDate': PropertySchema(
      id: 3,
      name: r'dueDate',
      type: IsarType.dateTime,
    ),
    r'hasDueTime': PropertySchema(
      id: 4,
      name: r'hasDueTime',
      type: IsarType.bool,
    ),
    r'isChecked': PropertySchema(
      id: 5,
      name: r'isChecked',
      type: IsarType.bool,
    ),
    r'listId': PropertySchema(
      id: 6,
      name: r'listId',
      type: IsarType.long,
    ),
    r'location': PropertySchema(
      id: 7,
      name: r'location',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 8,
      name: r'name',
      type: IsarType.string,
    ),
    r'normalizedName': PropertySchema(
      id: 9,
      name: r'normalizedName',
      type: IsarType.string,
    ),
    r'position': PropertySchema(
      id: 10,
      name: r'position',
      type: IsarType.long,
    ),
    r'price': PropertySchema(
      id: 11,
      name: r'price',
      type: IsarType.double,
    ),
    r'quantity': PropertySchema(
      id: 12,
      name: r'quantity',
      type: IsarType.double,
    ),
    r'reminderEnabled': PropertySchema(
      id: 13,
      name: r'reminderEnabled',
      type: IsarType.bool,
    ),
    r'reminderOffsetMinutes': PropertySchema(
      id: 14,
      name: r'reminderOffsetMinutes',
      type: IsarType.long,
    ),
    r'reminderRepeat': PropertySchema(
      id: 15,
      name: r'reminderRepeat',
      type: IsarType.string,
    ),
    r'unit': PropertySchema(
      id: 16,
      name: r'unit',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 17,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _shoppingListItemEstimateSize,
  serialize: _shoppingListItemSerialize,
  deserialize: _shoppingListItemDeserialize,
  deserializeProp: _shoppingListItemDeserializeProp,
  idName: r'id',
  indexes: {
    r'listId': IndexSchema(
      id: -4312380808616005139,
      name: r'listId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'listId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'normalizedName': IndexSchema(
      id: -9115371092206571671,
      name: r'normalizedName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'normalizedName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'dueDate': IndexSchema(
      id: -7871003637559820552,
      name: r'dueDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dueDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _shoppingListItemGetId,
  getLinks: _shoppingListItemGetLinks,
  attach: _shoppingListItemAttach,
  version: '3.3.2',
);

int _shoppingListItemEstimateSize(
  ShoppingListItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.addedFrom.length * 3;
  {
    final value = object.location;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.normalizedName.length * 3;
  bytesCount += 3 + object.reminderRepeat.length * 3;
  {
    final value = object.unit;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _shoppingListItemSerialize(
  ShoppingListItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.addedFrom);
  writer.writeLong(offsets[1], object.categoryId);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeDateTime(offsets[3], object.dueDate);
  writer.writeBool(offsets[4], object.hasDueTime);
  writer.writeBool(offsets[5], object.isChecked);
  writer.writeLong(offsets[6], object.listId);
  writer.writeString(offsets[7], object.location);
  writer.writeString(offsets[8], object.name);
  writer.writeString(offsets[9], object.normalizedName);
  writer.writeLong(offsets[10], object.position);
  writer.writeDouble(offsets[11], object.price);
  writer.writeDouble(offsets[12], object.quantity);
  writer.writeBool(offsets[13], object.reminderEnabled);
  writer.writeLong(offsets[14], object.reminderOffsetMinutes);
  writer.writeString(offsets[15], object.reminderRepeat);
  writer.writeString(offsets[16], object.unit);
  writer.writeDateTime(offsets[17], object.updatedAt);
}

ShoppingListItem _shoppingListItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ShoppingListItem();
  object.addedFrom = reader.readString(offsets[0]);
  object.categoryId = reader.readLongOrNull(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.dueDate = reader.readDateTimeOrNull(offsets[3]);
  object.hasDueTime = reader.readBool(offsets[4]);
  object.id = id;
  object.isChecked = reader.readBool(offsets[5]);
  object.listId = reader.readLong(offsets[6]);
  object.location = reader.readStringOrNull(offsets[7]);
  object.name = reader.readString(offsets[8]);
  object.normalizedName = reader.readString(offsets[9]);
  object.position = reader.readLongOrNull(offsets[10]);
  object.price = reader.readDoubleOrNull(offsets[11]);
  object.quantity = reader.readDouble(offsets[12]);
  object.reminderEnabled = reader.readBool(offsets[13]);
  object.reminderOffsetMinutes = reader.readLong(offsets[14]);
  object.reminderRepeat = reader.readString(offsets[15]);
  object.unit = reader.readStringOrNull(offsets[16]);
  object.updatedAt = reader.readDateTime(offsets[17]);
  return object;
}

P _shoppingListItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    case 11:
      return (reader.readDoubleOrNull(offset)) as P;
    case 12:
      return (reader.readDouble(offset)) as P;
    case 13:
      return (reader.readBool(offset)) as P;
    case 14:
      return (reader.readLong(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _shoppingListItemGetId(ShoppingListItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _shoppingListItemGetLinks(ShoppingListItem object) {
  return [];
}

void _shoppingListItemAttach(
    IsarCollection<dynamic> col, Id id, ShoppingListItem object) {
  object.id = id;
}

extension ShoppingListItemQueryWhereSort
    on QueryBuilder<ShoppingListItem, ShoppingListItem, QWhere> {
  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhere> anyListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'listId'),
      );
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhere> anyDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dueDate'),
      );
    });
  }
}

extension ShoppingListItemQueryWhere
    on QueryBuilder<ShoppingListItem, ShoppingListItem, QWhereClause> {
  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhereClause> idBetween(
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

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhereClause>
      listIdEqualTo(int listId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'listId',
        value: [listId],
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhereClause>
      listIdNotEqualTo(int listId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'listId',
              lower: [],
              upper: [listId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'listId',
              lower: [listId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'listId',
              lower: [listId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'listId',
              lower: [],
              upper: [listId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhereClause>
      listIdGreaterThan(
    int listId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'listId',
        lower: [listId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhereClause>
      listIdLessThan(
    int listId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'listId',
        lower: [],
        upper: [listId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhereClause>
      listIdBetween(
    int lowerListId,
    int upperListId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'listId',
        lower: [lowerListId],
        includeLower: includeLower,
        upper: [upperListId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhereClause>
      normalizedNameEqualTo(String normalizedName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'normalizedName',
        value: [normalizedName],
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhereClause>
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

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhereClause>
      dueDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dueDate',
        value: [null],
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhereClause>
      dueDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dueDate',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhereClause>
      dueDateEqualTo(DateTime? dueDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dueDate',
        value: [dueDate],
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhereClause>
      dueDateNotEqualTo(DateTime? dueDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dueDate',
              lower: [],
              upper: [dueDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dueDate',
              lower: [dueDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dueDate',
              lower: [dueDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dueDate',
              lower: [],
              upper: [dueDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhereClause>
      dueDateGreaterThan(
    DateTime? dueDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dueDate',
        lower: [dueDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhereClause>
      dueDateLessThan(
    DateTime? dueDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dueDate',
        lower: [],
        upper: [dueDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterWhereClause>
      dueDateBetween(
    DateTime? lowerDueDate,
    DateTime? upperDueDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dueDate',
        lower: [lowerDueDate],
        includeLower: includeLower,
        upper: [upperDueDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ShoppingListItemQueryFilter
    on QueryBuilder<ShoppingListItem, ShoppingListItem, QFilterCondition> {
  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      addedFromEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addedFrom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      addedFromGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'addedFrom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      addedFromLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'addedFrom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      addedFromBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'addedFrom',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      addedFromStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'addedFrom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      addedFromEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'addedFrom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      addedFromContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'addedFrom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      addedFromMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'addedFrom',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      addedFromIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addedFrom',
        value: '',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      addedFromIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'addedFrom',
        value: '',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      categoryIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'categoryId',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      categoryIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'categoryId',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      categoryIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
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

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
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

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
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

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      dueDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dueDate',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      dueDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dueDate',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      dueDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      dueDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      dueDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      dueDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dueDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      hasDueTimeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasDueTime',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      isCheckedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isChecked',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      listIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'listId',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      listIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'listId',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      listIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'listId',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      listIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'listId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      locationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'location',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      locationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'location',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      locationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      locationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      locationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      locationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'location',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      locationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      locationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      locationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      locationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'location',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      locationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      locationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
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

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
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

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
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

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
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

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
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

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
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

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      normalizedNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'normalizedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      normalizedNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'normalizedName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      normalizedNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'normalizedName',
        value: '',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      normalizedNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'normalizedName',
        value: '',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      positionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'position',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      positionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'position',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      positionEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      positionGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      positionLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      positionBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'position',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      priceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'price',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      priceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'price',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      priceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      priceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      priceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      priceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'price',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      quantityEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      quantityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      quantityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      quantityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      reminderEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reminderEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      reminderOffsetMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reminderOffsetMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      reminderOffsetMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reminderOffsetMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      reminderOffsetMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reminderOffsetMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      reminderOffsetMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reminderOffsetMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      reminderRepeatEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reminderRepeat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      reminderRepeatGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reminderRepeat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      reminderRepeatLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reminderRepeat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      reminderRepeatBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reminderRepeat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      reminderRepeatStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'reminderRepeat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      reminderRepeatEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'reminderRepeat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      reminderRepeatContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'reminderRepeat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      reminderRepeatMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'reminderRepeat',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      reminderRepeatIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reminderRepeat',
        value: '',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      reminderRepeatIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'reminderRepeat',
        value: '',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      unitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'unit',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      unitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'unit',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      unitEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      unitGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      unitLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      unitBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      unitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      unitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      unitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      unitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      unitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: '',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      unitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unit',
        value: '',
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ShoppingListItemQueryObject
    on QueryBuilder<ShoppingListItem, ShoppingListItem, QFilterCondition> {}

extension ShoppingListItemQueryLinks
    on QueryBuilder<ShoppingListItem, ShoppingListItem, QFilterCondition> {}

extension ShoppingListItemQuerySortBy
    on QueryBuilder<ShoppingListItem, ShoppingListItem, QSortBy> {
  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByAddedFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedFrom', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByAddedFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedFrom', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByHasDueTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasDueTime', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByHasDueTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasDueTime', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByIsChecked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isChecked', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByIsCheckedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isChecked', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listId', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByListIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listId', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByNormalizedName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'normalizedName', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByNormalizedNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'normalizedName', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy> sortByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderEnabled', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByReminderEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderEnabled', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByReminderOffsetMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderOffsetMinutes', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByReminderOffsetMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderOffsetMinutes', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByReminderRepeat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderRepeat', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByReminderRepeatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderRepeat', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy> sortByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension ShoppingListItemQuerySortThenBy
    on QueryBuilder<ShoppingListItem, ShoppingListItem, QSortThenBy> {
  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByAddedFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedFrom', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByAddedFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedFrom', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByHasDueTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasDueTime', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByHasDueTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasDueTime', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByIsChecked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isChecked', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByIsCheckedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isChecked', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listId', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByListIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listId', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByNormalizedName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'normalizedName', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByNormalizedNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'normalizedName', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy> thenByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderEnabled', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByReminderEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderEnabled', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByReminderOffsetMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderOffsetMinutes', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByReminderOffsetMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderOffsetMinutes', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByReminderRepeat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderRepeat', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByReminderRepeatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderRepeat', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy> thenByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension ShoppingListItemQueryWhereDistinct
    on QueryBuilder<ShoppingListItem, ShoppingListItem, QDistinct> {
  QueryBuilder<ShoppingListItem, ShoppingListItem, QDistinct>
      distinctByAddedFrom({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'addedFrom', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QDistinct>
      distinctByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryId');
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QDistinct>
      distinctByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dueDate');
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QDistinct>
      distinctByHasDueTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasDueTime');
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QDistinct>
      distinctByIsChecked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isChecked');
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QDistinct>
      distinctByListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'listId');
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QDistinct>
      distinctByLocation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'location', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QDistinct>
      distinctByNormalizedName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'normalizedName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QDistinct>
      distinctByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'position');
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QDistinct>
      distinctByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'price');
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QDistinct>
      distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QDistinct>
      distinctByReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reminderEnabled');
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QDistinct>
      distinctByReminderOffsetMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reminderOffsetMinutes');
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QDistinct>
      distinctByReminderRepeat({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reminderRepeat',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QDistinct> distinctByUnit(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ShoppingListItem, ShoppingListItem, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension ShoppingListItemQueryProperty
    on QueryBuilder<ShoppingListItem, ShoppingListItem, QQueryProperty> {
  QueryBuilder<ShoppingListItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ShoppingListItem, String, QQueryOperations> addedFromProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'addedFrom');
    });
  }

  QueryBuilder<ShoppingListItem, int?, QQueryOperations> categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryId');
    });
  }

  QueryBuilder<ShoppingListItem, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<ShoppingListItem, DateTime?, QQueryOperations>
      dueDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dueDate');
    });
  }

  QueryBuilder<ShoppingListItem, bool, QQueryOperations> hasDueTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasDueTime');
    });
  }

  QueryBuilder<ShoppingListItem, bool, QQueryOperations> isCheckedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isChecked');
    });
  }

  QueryBuilder<ShoppingListItem, int, QQueryOperations> listIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'listId');
    });
  }

  QueryBuilder<ShoppingListItem, String?, QQueryOperations> locationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'location');
    });
  }

  QueryBuilder<ShoppingListItem, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ShoppingListItem, String, QQueryOperations>
      normalizedNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'normalizedName');
    });
  }

  QueryBuilder<ShoppingListItem, int?, QQueryOperations> positionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'position');
    });
  }

  QueryBuilder<ShoppingListItem, double?, QQueryOperations> priceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'price');
    });
  }

  QueryBuilder<ShoppingListItem, double, QQueryOperations> quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }

  QueryBuilder<ShoppingListItem, bool, QQueryOperations>
      reminderEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reminderEnabled');
    });
  }

  QueryBuilder<ShoppingListItem, int, QQueryOperations>
      reminderOffsetMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reminderOffsetMinutes');
    });
  }

  QueryBuilder<ShoppingListItem, String, QQueryOperations>
      reminderRepeatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reminderRepeat');
    });
  }

  QueryBuilder<ShoppingListItem, String?, QQueryOperations> unitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unit');
    });
  }

  QueryBuilder<ShoppingListItem, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
