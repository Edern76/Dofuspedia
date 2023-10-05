
import 'package:dofuspedia/datasources/dofusdude/items_source.dart';
import 'package:dofuspedia/models/item/item.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ItemRepository{
  ItemsSource _itemsSource = GetIt.instance<ItemsSource>();
  late Future<List<Item>> items;

  void refreshItems(String language){
    items = _itemsSource.fetchItems(language: language);
  }
}