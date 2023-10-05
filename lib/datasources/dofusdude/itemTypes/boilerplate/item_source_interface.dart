import 'package:dofuspedia/models/item/item.dart';

abstract class ItemSourceInterface{
  Future<List<Item>> fetchItems({String language});
}