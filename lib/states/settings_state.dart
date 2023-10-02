import 'package:dofuspedia/main.dart';
import 'package:dofuspedia/utlis/constants.dart';
import 'package:dofuspedia/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsState extends State<SettingsPage>{
  String? _languageKey;
  late MyAppState _myAppState;

  Future<void> _changeLanguage(BuildContext context, String languageKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Navigator.of(context).pop();
    _myAppState.changeLanguage(Locale(languageKey));
    await prefs.setString("language", languageKey);
    setState(() {
      _languageKey = languageKey;
    });
  }

  @override
  Widget build(BuildContext context){
    _myAppState = context.findAncestorStateOfType<MyAppState>()!;
    _languageKey ??= _myAppState.locale.languageCode;
    AppLocalizations t = AppLocalizations.of(context)!;



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
    body: SettingsList(
      sections: [
        SettingsSection(
            title: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(t.settings_general),
            ),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                  leading: Icon(Icons.language),
                  title: Text(t.settings_language),
                  value: Text(Constants.LANGUAGES_MAP[_languageKey]!),
                  onPressed: (context) {
                    showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: Text(t.settings_language_choose),
                          children: Constants.LANGUAGES_MAP.entries.map((entry) => {
                            SimpleDialogOption(
                              child: InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(entry.value),
                                ),
                                  onTap: () => {_changeLanguage(context, entry.key)},
                                )
                            )
                          }).expand((e) => e).toList()
                        )
                    );
                  }
              )
            ]
        )
      ],
    )
    );
  }
}