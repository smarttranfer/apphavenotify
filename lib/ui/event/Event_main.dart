import 'package:flutter/material.dart';
import 'package:boilerplate/widgets/icon_assets.dart';
import 'package:boilerplate/widgets/side_bar_menu.dart';

class event_main extends StatefulWidget {
  @override
  _eventScreenState createState() => _eventScreenState();
}

class _eventScreenState extends State<event_main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Event camera",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: IconAssets(name: "menu_left"),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        }),
      ),
      drawer: SidebarMenu(),
      body: Container(),
    );
  }
}
