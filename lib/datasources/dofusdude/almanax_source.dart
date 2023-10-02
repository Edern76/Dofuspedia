import 'package:dofuspedia/main.dart';
import 'package:dofuspedia/models/almanax_entry.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

@lazySingleton
class AlmanaxSource{
  Future<AlmanaxEntry> fetchAlmanax(DateTime date, {String language="fr"}) async{
    String dateString = DateFormat("yyyy-MM-dd").format(date);
    final response = await http.get(Uri.parse("https://api.dofusdu.de/dofus2/$language/almanax/$dateString"));

    if (response.statusCode == 200){
      final data = json.decode(response.body);
      return AlmanaxEntry.fromJson(data);
    }
    else{
      throw Exception("Couldn't fetch almanax data (status: ${response.statusCode})");
    }
  }
}