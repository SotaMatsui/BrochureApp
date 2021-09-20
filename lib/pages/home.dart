import 'package:flutter/material.dart';
import 'package:fes_brochure/components/moreInfo.dart';
import 'dart:convert';

class TabInfo {
  String label;
  Widget widget;
  TabInfo(this.label, this.widget);
}

class HomePage extends StatefulWidget {
  final String jsondata;
  HomePage({required this.jsondata});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    List<Widget> widgets(String type) {
      var array = <Widget>[];
      switch (type) {
        case 'aisatu':
          for (var i = 0; i < _data1['aisatu'].length; i++) {
            array.add(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${_data1['aisatu'][i]['role']}',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                Text('${_data1['aisatu'][i]['name']}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(
                  height: 12,
                ),
                Text('${_data1['aisatu'][i]['body']}\n\n'),
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
            array.add(Text('• ${_data1['onegai'][i]}\n'));
          }
          break;
      }
      return array;
    }

    List vctOmoroi = [
      Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 24,
                height: 4,
              ),
            ),
          ],
        ),
      ),
      _menuItemB(
        "ごあいさつ",
        Icon(Icons.pets_outlined),
        Column(children: widgets('aisatu')),
        context,
      ),
      _menuItem(
        "おねがい",
        Icon(Icons.feedback_outlined),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets('onegai'),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(),
            child: Image.asset(
              'assets/splash/bg.png',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            constraints: BoxConstraints.expand(),
            child: Image.asset(
              'assets/splash/fg.png',
              fit: BoxFit.fitWidth,
            ),
          ),
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
          DraggableScrollableSheet(
            initialChildSize: 0.15,
            minChildSize: 0.15,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: vctOmoroi.length,
                    itemBuilder: (context, index) {
                      return vctOmoroi[index];
                    },
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: Offset(0, 0),
                          blurRadius: 12)
                    ]),
              );
            },
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
                    builder: (context) => MoreInfoComp(title, icon, body),
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
