import 'dart:io';

import 'package:dofuspedia/main.config.dart';
import 'package:dofuspedia/utlis/constants.dart';
import 'package:dofuspedia/views/almanax_view.dart';
import 'package:dofuspedia/views/main_view.dart';
import 'package:dofuspedia/repositories/item_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';



final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => getIt.init();
void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyAppState extends State<MyApp>{
  ValueNotifier<Locale> locale = ValueNotifier<Locale>(Locale("fr"));
  ItemRepository _itemRepository = GetIt.instance<ItemRepository>();

  @override
  void initState(){
    SharedPreferences.getInstance().then((prefs){
      locale.addListener(() { _itemRepository.refreshItems(locale.value.languageCode);});

      Locale newLoc;
      String? localeName = prefs.getString("language");
      if (localeName != null){
        newLoc = Locale(localeName!);
      }
      else{
        String systemLocale = Platform.localeName.split("_")[0];
        if (!Constants.LANGUAGES_MAP.keys.contains(systemLocale)){
          systemLocale = "en";
        }
        newLoc = Locale(systemLocale);
      }
      changeLanguage(newLoc);
      _itemRepository.refreshItems(newLoc.languageCode);
    });
  }

  changeLanguage(Locale loc){
    setState(() {
      locale = ValueNotifier<Locale>(loc); //TODO: Notify item list
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dofuspedia',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("fr"),
        Locale("en")
      ],
      locale: locale.value,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
          useMaterial3: true,
          textTheme: GoogleFonts.openSansTextTheme()
      ),
      home: MainView(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();

}




