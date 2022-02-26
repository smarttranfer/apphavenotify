import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:boilerplate/StoredataScurety/StoreSercurity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:boilerplate/widgets/icon_assets.dart';
import 'package:boilerplate/widgets/side_bar_menu.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'StoreUrlGis.dart' as stores;
import 'package:http/http.dart' as http;

class urlview extends StatefulWidget {
  @override
  _urlState createState() => _urlState();
}

class _urlState extends State<urlview> {
  String urls ;
  final SecureStorage secureStorage = SecureStorage();
  final _storages = FlutterSecureStorage();
  num position = 1;
  Future readSecureData(String key) async {
    String readData = await _storages.read(key: key);
    setState(() {
      stores.StoreUrlGis.urlgis = readData;
    });
    print(urls);
    return readData;
  }
  @override
  void initState() {
    super.initState();
    readSecureData("urlGis");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "AI GIS",
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
        body: IndexedStack(
          index: position,
          children: [
            WebView(
              initialUrl:  stores.StoreUrlGis.urlgis,
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (value) {
                setState(() {
                  position = 1;
                });
              },
              onPageFinished: (value) {
                setState(() {
                  position = 0;
                });
              },
            ),
            Container(
              child: Center(child: CircularProgressIndicator()),
            ),
          ],
        )

        // WebView(initialUrl: urls,
        );
  }
}
