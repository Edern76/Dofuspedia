import 'package:dofuspedia/views/almanax_view.dart';
import 'package:dofuspedia/views/items_view.dart';
import 'package:dofuspedia/views/settings_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

PersistentTabController _controller = PersistentTabController(initialIndex: 0);

class MainView extends StatelessWidget{
  const MainView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context){
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarItems(context),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation:const  ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style3,
    );
  }

  List<Widget> _buildScreens(){
    return [
      const AlmanaxPage(title: "Dofuspedia"),
      const ItemsPage(title: "Dofuspedia"),
      Container(),
      const SettingsPage(title: "Dofuspedia"),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems(BuildContext context){
    AppLocalizations t = AppLocalizations.of(context)!;
    return [
        PersistentBottomNavBarItem(icon: const Icon(Icons.calendar_month),
        title: (t.navbar_almanax),
        activeColorPrimary: Theme.of(context).colorScheme.inversePrimary,
        inactiveColorPrimary: Colors.grey
        ),
      PersistentBottomNavBarItem(icon: const Icon(Icons.list),
          title: (t.navbar_items),
          activeColorPrimary: Theme.of(context).colorScheme.inversePrimary,
          inactiveColorPrimary: Colors.grey
      ),
      PersistentBottomNavBarItem(icon: const Icon(CupertinoIcons.wand_stars),
          title: (t.navbar_breaking),
          activeColorPrimary: Theme.of(context).colorScheme.inversePrimary,
          inactiveColorPrimary: Colors.grey
      ),
      PersistentBottomNavBarItem(icon: const Icon(Icons.settings),
          title: (t.navbar_settings),
          activeColorPrimary: Theme.of(context).colorScheme.inversePrimary,
          inactiveColorPrimary: Colors.grey
      ),
    ];
  }
}