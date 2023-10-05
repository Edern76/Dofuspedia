import 'package:dofuspedia/datasources/dofusdude/almanax_source.dart';
import 'package:dofuspedia/main.dart';
import 'package:dofuspedia/models/almanax_entry.dart';
import 'package:dofuspedia/models/item/item.dart';
import 'package:dofuspedia/views/almanax_view.dart';
import 'package:dofuspedia/views/components/rounded_image.dart';
import 'package:dofuspedia/views/items_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../repositories/item_repository.dart';

class ItemsState extends State<ItemsPage> {
  late final MyAppState _myAppState;
  late Future<List<Item>> items;
  ItemRepository _itemRepository = GetIt.instance<ItemRepository>();
  static const double _PADDING_TITLE = 5.0;
  static const double _PADDING_BOTTOM = 8.0;

  @override
  void initState(){
    super.initState();
    _myAppState = context.findAncestorStateOfType<MyAppState>()!;
    getItems();
  }

  void getItems() async{
    setState(() {
      items = _itemRepository.items;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Item>>(
        future: items,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoading(context);
          }
          else if (snapshot.hasError){
            return _buildError(context, snapshot.error.toString());
          }
          else if (!snapshot.hasData){
            return _buildError(context, "Server returned an empty response");
          }
          else{
            List<Item> itemsList = snapshot.data!;
            itemsList.sort((a,b) => a.name.compareTo(b.name));
            return _buildItems(context, itemsList);
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: (){},
          tooltip: 'Set date',
          child: const Icon(Icons.filter_alt),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildItems(BuildContext context, List<Item> itemsList){
    AppLocalizations t = AppLocalizations.of(context)!;

    return
      ListView.builder(
        itemCount: itemsList.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(itemsList[index].name),
            leading: RoundedImage(
              size: 40,
              image: Image.network(
                  itemsList[index].imageUrls.getImageUrl("icon")!,
                  fit: BoxFit.contain
              ),
            ),
          );
        },
      );
  }

  Widget _buildLoading(BuildContext context){
    AppLocalizations t = AppLocalizations.of(context)!;

    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text(
              t.almanax_loading
          )
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, String error){
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 80,
          ),
          Text(
              error
          )
        ],
      ),
    );
  }
}