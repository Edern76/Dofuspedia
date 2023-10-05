
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dofuspedia/datasources/dofusdude/itemTypes/boilerplate/item_source_interface.dart';
import 'package:dofuspedia/models/item/item.dart';
import 'package:injectable/injectable.dart';

class GenericItemSource{
  Future<List<Item>> doFetch(String type, {String language="fr"}) async{
    final response = await http.get(Uri.parse("https://api.dofusdu.de/dofus2/$language/items/$type/all"));

    if (response.statusCode == 200){
      final data = json.decode(response.body);
      final items = data["items"] as List<dynamic>;
      return items.map((itemData) {
        return Item.fromJson(itemData);
      }).toList();
    }
    else{
      throw Exception("Couldn't fetch $type data (status: ${response.statusCode})");
    }
  }

}