import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fes_brochure/components/moreInfo.dart';

class othersPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              RichText(
                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: const <TextSpan>[
                    TextSpan(text: '文化祭実行委員長\n'),
                    TextSpan(
                        text: '山崎 煌\n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    TextSpan(text: '\n生徒会長\n'),
                    TextSpan(
                        text: '永長 和樹\n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),
              context),
          _menuItem(
              "編集後記",
              Icon(Icons.article_outlined),
              Text(
                  "本所祭は楽しんでいただけましたか？\nこのパンフレットは美術部・漫画研究部に協力していただき、素敵なものが作れました。また、表紙は３F工藤珠莉さん、ポスターは１A飯塚若菜さんの作品です。ご協力ありがとうございました。")),
          _menuItemB("応募作品", Icon(Icons.mms_outlined), Text(""), context),
          _menuItem(
              "学校情報",
              Icon(Icons.school_outlined),
              RichText(
                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: const <TextSpan>[
                    TextSpan(
                        text: '東京都立本所高等学校\n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    TextSpan(
                        text:
                            '〒131-0033 東京都墨田区向島3-37-25\n電話 : 03-3622-0344\nファクシミリ : 03-3622-0146'),
                  ],
                ),
              )),
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    TextSpan(
                        text: 'Created by ComputerClub\nPowered by Flutter'),
                  ],
                ),
              )),
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
              builder: (context) => moreInfoComp(title, icon, body),
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
