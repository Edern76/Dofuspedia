
import 'dart:convert';
import 'package:dofuspedia/datasources/dofusdude/itemTypes/boilerplate/item_source_generic.dart';
import 'package:http/http.dart' as http;
import 'package:dofuspedia/datasources/dofusdude/itemTypes/boilerplate/item_source_interface.dart';
import 'package:dofuspedia/models/item/item.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CosmeticsSource extends GenericItemSource implements ItemSourceInterface {
  @override
  Future<List<Item>> fetchItems({String language="fr"}) async {
    return await doFetch("cosmetics", language: language);
  }
}