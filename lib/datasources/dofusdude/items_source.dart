import 'package:dofuspedia/datasources/dofusdude/itemTypes/boilerplate/item_source_interface.dart';
import 'package:dofuspedia/datasources/dofusdude/itemTypes/consumables_source.dart';
import 'package:dofuspedia/datasources/dofusdude/itemTypes/cosmetics_source.dart';
import 'package:dofuspedia/datasources/dofusdude/itemTypes/equipment_source.dart';
import 'package:dofuspedia/datasources/dofusdude/itemTypes/quest_items_source.dart';
import 'package:dofuspedia/datasources/dofusdude/itemTypes/resources_source.dart';
import 'package:dofuspedia/main.dart';
import 'package:dofuspedia/models/almanax_entry.dart';
import 'package:dofuspedia/models/item/item.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:async/async.dart';

import 'package:intl/intl.dart';

@lazySingleton
class ItemsSource implements ItemSourceInterface{
  final ConsumablesSource _consumablesSource = GetIt.instance<ConsumablesSource>();
  final CosmeticsSource _cosmeticsSource = GetIt.instance<CosmeticsSource>();
  final EquipmentSource _equipmentSource = GetIt.instance<EquipmentSource>();
  final QuestItemsSource _questItemsSource = GetIt.instance<QuestItemsSource>();
  final ResourcesSource _resourcesSource = GetIt.instance<ResourcesSource>();

  @override
  Future<List<Item>> fetchItems({String language="fr"}) async{
    List<Item> result = [];
    FutureGroup futureGroup = FutureGroup();
    futureGroup.add(_consumablesSource.fetchItems(language: language));
    futureGroup.add(_cosmeticsSource.fetchItems(language: language));
    futureGroup.add(_equipmentSource.fetchItems(language: language));
    futureGroup.add(_questItemsSource.fetchItems(language: language));
    futureGroup.add(_resourcesSource.fetchItems(language: language));

    futureGroup.close(); //Run all queries in parallel
    List<List<Item>> futureResult = await futureGroup.future as List<List<Item>>;
    futureResult.forEach((element) {result.addAll(element);});
    return result;




  }


}