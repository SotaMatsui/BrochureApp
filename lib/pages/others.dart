import 'package:flutter/material.dart';
import 'package:fes_brochure/components/moreInfo.dart';
import 'dart:convert';

final imageList = [
  'assets/images/arts/1.png',
  'assets/images/arts/2.png',
  'assets/images/arts/3.png',
  'assets/images/arts/4.png',
];

class TabInfo {
  String label;
  Widget widget;
  TabInfo(this.label, this.widget);
}

class OthersPage extends StatefulWidget {
  final String jsondata;
  OthersPage({required this.jsondata});
  @override
  _OthersPageState createState() => _OthersPageState();
}

class _OthersPageState extends State<OthersPage> {
  Map _data1 = {};
  Future<void> loadJsonAsset() async {
    setState(() {
      _data1 = json.decode(widget.jsondata)['others'];
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
        //!TODO Fix this
        case 'staffs':
          for (var i = 0; i < _data1['staffs'].length; i++) {
            var ar = <Widget>[];
            for (var j = 0; j < _data1['staffs'][i]['list'].length; j++) {
              ar.add(Text('${_data1['staffs'][i]['list'][j]}  '));
            }
            array.add(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${_data1['staffs'][i]['role']}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Wrap(children: ar),
                Text(''),
              ],
            ));
          }
          break;
        case 'gakko':
          array.add(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${_data1['gakko']['title']}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text('${_data1['gakko']['body']}\n'),
            ],
          ));
          break;
        case 'henshuu':
          array.add(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${_data1['henshuu']}\n'),
            ],
          ));
          break;
      }
      return array;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/arts/3.png'),
              fit: BoxFit.cover
            ),
        ),
        child: Stack(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.black.withOpacity(0.2),
            brightness: Brightness.dark,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo_wIcon_light.png',
                  height: 50,
                ),
              ],
            ),
            elevation: 0,
          ),
          SizedBox.expand(
            child: DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.8,
              minChildSize: 0.5,
              maxChildSize: 0.8,
              builder: (context, scrollController) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal:10),
                        child: Column(
                        children: <Widget>[
                          _menuItemB(
                              "スタッフ一覧",
                              Icon(Icons.face_outlined),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: widgets('staffs'),
                              ),
                              context),
                          _menuItem(
                            "編集後記",
                            Icon(Icons.article_outlined),
                            Column(
                              children: widgets('henshuu'),
                            ),
                          ),
                          _menuItemB(
                              "応募作品",
                              Icon(Icons.mms_outlined),
                              Wrap(
                                children: [
                                  Image.asset('assets/images/arts/1.png'),
                                  Image.asset('assets/images/arts/2.png'),
                                  Image.asset('assets/images/arts/3.png'),
                                  Image.asset('assets/images/arts/4.png')
                                ],
                              ),
                              context),
                          _menuItemB(
                              "映像作品スケジュール",
                              Icon(Icons.schedule_outlined),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '映像作品を上映する各クラスは共通して以下の時間帯に映像を上映します。',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                  Divider(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '09:00 ~ 09:30',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Divider(),
                                      Text(
                                        '09:30 ~ 10:00',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Divider(),
                                      Text(
                                        '10:00 ~ 10:30',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Divider(),
                                      Text(
                                        '10:30 ~ 10:00',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Divider(),
                                      Text(
                                        '11:00 ~ 11:30',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Divider(),
                                      Text(
                                        '11:30 ~ 12:00',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Divider(),
                                      Text(
                                        '13:00 ~ 13:30',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Divider(),
                                      Text(
                                        '13:30 ~ 14:00',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Divider(),
                                    ],
                                  )
                                ],
                              ),
                              context),
                          _menuItem(
                            "学校情報",
                            Icon(Icons.school_outlined),
                            Column(
                              children: widgets('gakko'),
                            ),
                          ),
                          _menuItem(
                            "このアプリについて",
                            Icon(Icons.info_outline),
                            RichText(
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor,
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(
                                      text:
                                          'HONJO Fes Brochure App 2021\nDevelopment Version\n',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  TextSpan(
                                      text:
                                          'Created by ComputerClub\nPowered by Flutter'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      )
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
          ),
        ],
      ),
      )
    );
  }

  Widget _menuItem(String title, Icon icon, Widget body) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1.0,
                blurRadius: 10.0,
                offset: Offset(2, 2),
              )
            ],
          ),
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
                  thickness: 1,
                  color: Colors.grey[250],
                  indent: 16,
                  endIndent: 16),
              Container(
                margin: EdgeInsets.all(12.0),
                child: body,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItemB(
      String title, Icon icon, Widget body, BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) => MoreInfoComp(title, icon, body),
            );
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1.0,
                  blurRadius: 10.0,
                  offset: Offset(2, 2),
                )
              ],
            ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
