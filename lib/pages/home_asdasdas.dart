import 'package:fes_brochure/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fes_brochure/components/moreInfo.dart';
import 'dart:convert';

class homePage extends ConsumerWidget {
  final String jsondata;

  homePage(this.jsondata);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _data = ref.watch(homeDataProvider).state;
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
                        child: _data.length != 0
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
                                    RichText(
                                      textScaleFactor: MediaQuery.of(context)
                                          .textScaleFactor,
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: [
                                          TextSpan(
                                              text:
                                                  '${_data['aisatu'][0]['role']}\n${_data['aisatu'][0]['name']}\n',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                          TextSpan(
                                              text:
                                                  '${_data['aisatu'][0]['body']}\n'),
                                          TextSpan(
                                              text: '\n文化祭実行委員長\n山崎 煌\n',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                          TextSpan(
                                              text:
                                                  '今回のテーマは「煌 -咲かせよう僕らの青春-」です。「煌」という漢字には、かがやく きらめくという意味がこめられています。近年はコロナ禍というご時世もあり、僕達は冷たい水の中にいるようで皆さんが想像していた夢のDramaのような高校生活には、なっていないかもしれません。ですが、今回の文化祭では降り注ぐ星の光が僕たちを照らしてくれます。そのMAGICを信じて、このテーマにしました。 この日のために、生徒全員で一致団結して頑張ってきたので、今日だけは、誰よりも高く跳び、目の前のガラスを割る勢いで無限大のパワーを見せましょう！！\n'),
                                          TextSpan(
                                              text: '\n生徒会長\n永長 和樹\n',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                          TextSpan(
                                              text:
                                                  'こんにちは、生徒会長の永長和樹です。\n生徒の皆さん、長い間文化祭の準備お疲れ様でした\nコロナ禍でありながら今回文化祭を開催できることをとても嬉しく思います。\n今回の文化祭のテーマは「煌」であり\n\n「サブテーマは咲かせよう僕らの青春」\n\n一人一人の個性が輝くようにという意味でたてられました\n\n一二年生は映画や、展示など、を準備しています\nまた、各クラスだけでなく各部活もシンクロやライブや物品販売など本所高校ならではの\n出し物が多数あります、\n\nまた、生徒会ではアンブレラスカイを、中庭に設営しました。\nフォトスポットとしてご利用ください\n\n全てのクラスまた、団体はコロナ禍の中全力で用意してきました、是非立ち寄ってみてください\n'),
                                        ],
                                      ),
                                    ),
                                    context,
                                  ),
                                  _menuItem(
                                      "各装飾の見どころ",
                                      Icon(Icons.thumb_up_outlined),
                                      RichText(
                                        textScaleFactor: MediaQuery.of(context)
                                            .textScaleFactor,
                                        text: TextSpan(
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: const <TextSpan>[
                                            TextSpan(
                                                text: '校内装飾\n',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)),
                                            TextSpan(
                                                text:
                                                    '毎年恒例の写真スポット「HONJO」を作りました。\nぜひ、スカイツリーをバックに写真を撮ってください。\n他にも、原宿のアノ協会のアレを再現したものや、「運命の赤い糸」の写真スポットを作りました。\n'),
                                            TextSpan(
                                                text: '\n校内装飾\n',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)),
                                            TextSpan(
                                                text:
                                                    '中央階段はテーマの「空」に合った装飾にしました。\n他の階段はアクアリウムをイメージしたものと、ピンクを基調にしたかわいい雰囲気の装飾にしました。また、ステンドグラス風の窓の装飾にもご注目ください。\n'),
                                            TextSpan(
                                                text: '\nアーチ\n',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)),
                                            TextSpan(
                                                text:
                                                    'アーチは今年のテーマ「空」をモチーフにデザインしました。今年はアーチの「HONJO」を立体にしたり、お帰りになる方を見送るメッセージを付け加えるなどの工夫をしました、\nアーチをくぐる際には、ぜひ上にもご注目ください。\n'),
                                          ],
                                        ),
                                      )),
                                  _menuItem(
                                      "おねがい",
                                      Icon(Icons.feedback_outlined),
                                      Text(
                                          "• 校内は土足厳禁です。上履きまたはスリッパに履き替えてください。\n• 学校敷地内はすべて禁煙です。喫煙はご遠慮ください。\n• 飲食は指定教室に限らせていただきます。廊下・校庭・体育館での飲食はご遠慮ください。\n• 文化祭開催日は9月8日（金）9日（土）ですが、一般公開は9日のみとなっております。ご注意ください。（午前９時～午後３時、入場は午後２時まで）")),
                                ],
                              )
                            : null),
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
