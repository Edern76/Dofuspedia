import 'package:dofuspedia/states/settings_state.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget{
  const SettingsPage({super.key, required this.title});

  final String title;

  State<SettingsPage> createState() => SettingsState();

}