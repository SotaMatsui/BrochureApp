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
              ar.add(Text('${_data1['staffs'][i]['list'][j]} '));
            }
            array.add(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${_data1['staffs'][i]['role']}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Row(children: ar),
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
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo_wIcon_dark.png',
                  height: 50,
                ),
              ],
            ),
            elevation: 0,
          ),
          _menuItemB(
              "スタッフ一覧",
              Icon(Icons.face_outlined),
              Column(
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
              textScaleFactor: MediaQuery.of(context).textScaleFactor,
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: const <TextSpan>[
                  TextSpan(
                      text:
                          'HONJO Fes Brochure App 2021\nDevelopment Version\n',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  TextSpan(text: 'Created by ComputerClub\nPowered by Flutter'),
                ],
              ),
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1.0, color: Colors.black26),
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
              border: Border.all(width: 1.0, color: Colors.black26),
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
