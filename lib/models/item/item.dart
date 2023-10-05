import 'package:dofuspedia/models/item/item_stub.dart';

class Item extends ItemStub{
  final int level;
  final int pods;

  Item({
      required ankamaId,
      required imageUrls,
      required name,
      required subtype,
      required this.level,
      this.pods=0
  }) : super(
      ankamaId: ankamaId,
      imageUrls: imageUrls,
      name: name,
      subtype: subtype);

  factory Item.fromJson(Map<String, dynamic> json){
    ItemStub baseItem = ItemStub.fromJson(json);

    return Item(
      ankamaId: baseItem.ankamaId,
      imageUrls: baseItem.imageUrls,
      name: baseItem.name,
      subtype: baseItem.subtype,
      level: json["level"],
      pods: json.containsKey("pods") ? json["pods"] : 0
    );
  }
}