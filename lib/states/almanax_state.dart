import 'package:dofuspedia/datasources/dofusdude/almanax_source.dart';
import 'package:dofuspedia/models/almanax_entry.dart';
import 'package:dofuspedia/views/almanax_view.dart';
import 'package:dofuspedia/views/components/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class AlmanaxState extends State<AlmanaxPage> {
  final AlmanaxSource _almanaxSource = GetIt.instance<AlmanaxSource>();

  DateTime _dateAlmanax = DateTime.now();

  Future<void> _changeDate(BuildContext context) async {
    DateTime? datePicked = await showDatePicker(context: context,
        initialDate: _dateAlmanax,
        firstDate: DateTime(2023),
        lastDate: DateTime(2100));

    if (datePicked != null){
      setState(() {
        // This call to setState tells the Flutter framework that something has
        // changed in this State, which causes it to rerun the build method below
        // so that the display can reflect the updated values. If we changed
        // _counter without calling setState(), then the build method would not be
        // called again, and so nothing would appear to happen.
        _dateAlmanax = datePicked;
      });
    }
  }

  Future<AlmanaxEntry> _getAlmanax() async{
    AlmanaxEntry entry = await _almanaxSource.fetchAlmanax(_dateAlmanax);
    return entry;
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
      body: FutureBuilder<AlmanaxEntry>(
        future: _getAlmanax(),
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
            return _buildAlmanax(context, snapshot.data!);
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: (){_changeDate(context);},
          tooltip: 'Set date',
          child: const Icon(Icons.calendar_month),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildAlmanax(BuildContext context, AlmanaxEntry entry){
    return
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Offrande du jour",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.withOpacity(0.8)
                  )
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundedImage(
                  size: 75,
                  image: Image.network(
                      entry.tribute.item.imageUrls.getImageUrl("hd")!,
                      fit: BoxFit.contain
                  ),
                  borderRadius: 10,
                )
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(child:
                Text("${entry.tribute.quantity} x ${entry.tribute.item.name}",
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )
        ],
      );
  }

  Widget _buildLoading(BuildContext context){
    return const Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text(
              "Chargement de l'almanax en cours..."
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