import 'package:flutter/material.dart';

class SpaceBox extends SizedBox {
  SpaceBox({double width = 8, double height = 8})
      : super(width: width, height: height);

  SpaceBox.width([double value = 8]) : super(width: value);
  SpaceBox.height([double value = 8]) : super(height: value);
}

class DetailPageA extends StatelessWidget {
  String id;
  String title;
  String type;
  String organizer;
  String place;
  String icon;
  Color themeColor;
  Color subColor;
  String shortDesc;
  String longDesc;
  DetailPageA(this.id, this.title, this.type, this.organizer, this.place,
      this.icon, this.themeColor, this.subColor, this.shortDesc, this.longDesc);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[
          Material(
            color: subColor,
            child: Image.network(
              icon,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox.expand(
            child: DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.55,
              minChildSize: 0.5,
              maxChildSize: 0.8,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Material(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
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
                        Container(
                            margin: EdgeInsets.only(bottom: 32),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(16, 48, 16, 32),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "『 ",
                                              style: TextStyle(
                                                  fontSize: 19.0,
                                                  color: themeColor,
                                                  fontWeight: FontWeight.w900),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              title,
                                              style: TextStyle(fontSize: 19.0),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              " 』",
                                              style: TextStyle(
                                                  fontSize: 19.0,
                                                  color: themeColor,
                                                  fontWeight: FontWeight.w900),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ]),
                                      Text(
                                        type + ' / ' + organizer,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12.0),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        shortDesc,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600),
                                        overflow: TextOverflow.visible,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        longDesc,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey[850]),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        Divider(
                            height: 10,
                            thickness: 1,
                            color: Colors.grey[250],
                            indent: 16,
                            endIndent: 16),
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.place_outlined),
                                      Text(
                                        place,
                                        style: TextStyle(fontSize: 18.0),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 320,
                                  child: Image.asset(
                                    'assets/images/maps/' + id + '.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ]));
  }
}

class DetailPageB extends StatelessWidget {
  String id;
  String title;
  String type;
  String organizer;
  String place;
  String icon;
  Color themeColor;
  Color subColor;
  String shortDesc;
  String longDesc;
  List timeList;
  DetailPageB(
      this.id,
      this.title,
      this.type,
      this.organizer,
      this.place,
      this.icon,
      this.themeColor,
      this.subColor,
      this.shortDesc,
      this.longDesc,
      this.timeList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[
          Material(
            color: subColor,
            child: Image.network(
              icon,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox.expand(
            child: DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.55,
              minChildSize: 0.5,
              maxChildSize: 0.8,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Material(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
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
                        Container(
                            margin: EdgeInsets.only(bottom: 32),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(16, 48, 16, 32),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "『 ",
                                              style: TextStyle(
                                                  fontSize: 19.0,
                                                  color: themeColor,
                                                  fontWeight: FontWeight.w900),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              title,
                                              style: TextStyle(fontSize: 19.0),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              " 』",
                                              style: TextStyle(
                                                  fontSize: 19.0,
                                                  color: themeColor,
                                                  fontWeight: FontWeight.w900),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ]),
                                      Text(
                                        type + ' / ' + organizer,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12.0),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Column(children: [
                                        for (int i = 0;
                                            i < timeList.length;
                                            i++)
                                          Text(
                                            timeList[i]['start']
                                                    .substring(0, 2) +
                                                ':' +
                                                timeList[i]['start']
                                                    .substring(2, 4) +
                                                '~' +
                                                timeList[i]['end']
                                                    .substring(0, 2) +
                                                ':' +
                                                timeList[i]['end']
                                                    .substring(2, 4),
                                            style: TextStyle(fontSize: 16.0),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                      ]),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        shortDesc,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600),
                                        overflow: TextOverflow.visible,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        longDesc,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey[850]),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        Divider(
                            height: 10,
                            thickness: 1,
                            color: Colors.grey[250],
                            indent: 16,
                            endIndent: 16),
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.place_outlined),
                                      Text(
                                        place,
                                        style: TextStyle(fontSize: 18.0),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 320,
                                  child: Image.asset(
                                    'assets/images/maps/' + id + '.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ]));
  }
}
