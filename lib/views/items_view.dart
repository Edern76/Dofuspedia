import 'package:dofuspedia/states/almanax_state.dart';
import 'package:flutter/material.dart';

import '../states/items_state.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key, required this.title});

  final String title;

  @override
  State<ItemsPage> createState() => ItemsState();

}