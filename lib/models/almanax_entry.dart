import 'dart:convert';

import 'package:dofuspedia/models/item/item_stub.dart';
import 'package:intl/intl.dart';

class AlmanaxEntry{
  final AlmanaxBonus bonus;
  final DateTime date;
  final AlmanaxTribute tribute;

  AlmanaxEntry({
    required this.bonus,
    required this.date,
    required this.tribute
  });

  factory AlmanaxEntry.fromJson(Map<String, dynamic> json){
    return AlmanaxEntry(
        bonus: AlmanaxBonus.fromJson(json["bonus"]),
        date: new DateFormat("yyyy-MM-dd").parse(json["date"]),
        tribute: AlmanaxTribute.fromJson(json["tribute"])
    );
  }
}

class AlmanaxBonus{
  final String description;
  final AlmanaxType type;

  AlmanaxBonus({
    required this.description,
    required this.type
  });

  factory AlmanaxBonus.fromJson(Map<String, dynamic> json){
    String description = json["description"] as String;
    return AlmanaxBonus(description: utf8.decode(description.codeUnits),
        type: AlmanaxType.fromJson(json["type"])
    );
  }
}

class AlmanaxType{
  final String id;
  final String name;

  AlmanaxType({
    required this.id,
    required this.name
  });

  factory AlmanaxType.fromJson(Map<String, dynamic> json){
    String name = json["name"] as String;
    return AlmanaxType(id: json["id"],
        name: utf8.decode(name.codeUnits)
    );
  }
}

class AlmanaxTribute{
  final ItemStub item;
  final int quantity;

  AlmanaxTribute({
    required this.item,
    required this.quantity
  });

  factory AlmanaxTribute.fromJson(Map<String, dynamic> json){
    return AlmanaxTribute(item: ItemStub.fromJson(json["item"]),
        quantity: json["quantity"]
    );
  }
}