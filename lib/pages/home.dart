import 'package:flutter/material.dart';
import 'package:fes_brochure/components/moreInfo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:fes_brochure/components/detail.dart';

class TabInfo {
  String label;
  Widget widget;
  TabInfo(this.label, this.widget);
}

class homePage extends StatefulWidget {
  final String jsondata;
  homePage({required this.jsondata});
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  Map _data1 = {};
  Future<void> loadJsonAsset() async {
    setState(() {
      _data1 = json.decode(widget.jsondata)['home'];
    });
  }

  @override
  void initState() {
    loadJsonAsset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buildItems() {
      List<Widget> items = [];
      print(_data1['aisatu']);

      _data1['aisatu'].forEach((Map obj) {
        items.add(Text(obj['body']));
      });

      return items;
    }

    List<String> list = ['one', 'two', 'three', 'four'];
    List<Widget> widgets(String type) {
      var array = <Widget>[];
      switch (type) {
        case 'aisatu':
          for (var i = 0; i < _data1['aisatu'].length; i++) {
            array.add(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${_data1['aisatu'][i]['role']}\n${_data1['aisatu'][i]['name']}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('${_data1['aisatu'][i]['body']}\n'),
              ],
            ));
          }
          break;
        case 'midokoro':
          for (var i = 0; i < _data1['midokoro'].length; i++) {
            array.add(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${_data1['midokoro'][i]['title']}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('${_data1['midokoro'][i]['body']}\n'),
              ],
            ));
          }
          break;
        case 'onegai':
          for (var i = 0; i < _data1['onegai'].length; i++) {
            array.add(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• ${_data1['onegai'][i]}\n'),
              ],
            ));
          }
          break;
      }
      return array;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Material(
            color: Colors.amber,
            child: Image.asset(
              'assets/splash/bg.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          Column(
            children: [
              AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/logo_woIcon_dark.png',
                      height: 50,
                    ),
                  ],
                ),
                backgroundColor: Colors.white.withOpacity(0),
                elevation: 0,
              ),
              Container(
                child: Image.asset(
                  'assets/splash/fg.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          SizedBox.expand(
            child: DraggableScrollableSheet(
              expand: true,
              initialChildSize: 0.15,
              minChildSize: 0.15,
              maxChildSize: 1,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Material(
                      elevation: 10,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                      color: Colors.white,
                      child: _data1.length != 0
                          ? Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Material(
                                            color: Colors.grey[300],
                                            child: SizedBox(
                                              width: 24,
                                              height: 4,
                                            ),
                                          ),
                                        )
                                      ]),
                                ),
                                _menuItemB(
                                  "ごあいさつ",
                                  Icon(Icons.pets_outlined),
                                  Column(children: widgets('aisatu')),
                                  context,
                                ),
                                _menuItem(
                                  "各装飾の見どころ",
                                  Icon(Icons.thumb_up_outlined),
                                  Column(
                                    children: widgets('midokoro'),
                                  ),
                                ),
                                _menuItem(
                                  "おねがい",
                                  Icon(Icons.feedback_outlined),
                                  Column(
                                    children: widgets('onegai'),
                                  ),
                                ),
                              ],
                            )
                          : Text('loading'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(String title, Icon icon, Widget body) {
    return GestureDetector(
        child: Container(
      padding: EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: new BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: icon,
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.grey[800], fontSize: 16.0),
                ),
              ],
            ),
            Divider(
                height: 10,
                thickness: 1.5,
                color: Colors.black,
                indent: 8,
                endIndent: 8),
            Container(
              margin: EdgeInsets.all(12.0),
              child: body,
            ),
          ],
        ),
      ),
    ));
  }

  Widget _menuItemB(
      String title, Icon icon, Widget body, BuildContext context) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) => moreInfoComp(title, icon, body),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10.0),
                                child: icon,
                              ),
                              Text(
                                title,
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 16.0),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: Icon(Icons.chevron_right_outlined),
                          ),
                        ],
                      ),
                      Divider(
                          height: 10,
                          thickness: 1.5,
                          color: Colors.black,
                          indent: 8,
                          endIndent: 8),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
