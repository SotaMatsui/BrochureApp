import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpaceBox extends SizedBox {
  SpaceBox({double width = 8, double height = 8})
      : super(width: width, height: height);

  SpaceBox.width([double value = 8]) : super(width: value);
  SpaceBox.height([double value = 8]) : super(height: value);
}

class DetailPageA extends StatelessWidget {
  final String id;
  final String title;
  final String type;
  final String organizer;
  final String place;
  final String icon;
  final Color themeColor;
  final Color subColor;
  final String shortDesc;
  final String longDesc;
  DetailPageA(this.id, this.title, this.type, this.organizer, this.place,
      this.icon, this.themeColor, this.subColor, this.shortDesc, this.longDesc);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[
          Material(
            color: subColor,
            child: Image.asset(
              icon,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox.expand(
            child: DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.55,
              minChildSize: 0.5,
              maxChildSize: 0.75,
              builder: (context, scrollController) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    controller: scrollController,
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
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(16, 48, 16, 32),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                          Flexible(
                                            child: Text(
                                              title,
                                              style: TextStyle(fontSize: 19.0),
                                              overflow: TextOverflow.ellipsis,
                                            ),
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
                                margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      shortDesc,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600),
                                      overflow: TextOverflow.visible,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 48),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                height: 25,
                                child: CustomPaint(
                                  painter: _SelifTopCustom(theme: themeColor),
                                ),
                              ),
                              Material(
                                color: themeColor,
                                child: Container(
                                  margin: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        longDesc,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 55,
                                child: CustomPaint(
                                  painter:
                                      _SelifBottomCustom(theme: themeColor),
                                ),
                              ),
                            ],
                          ),
                        ),
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
        ]));
  }
}

class DetailPageB extends StatefulWidget {
  final String title;
  final int floor;
  final String shortDesc;
  DetailPageB(
    this.title,
    this.floor,
    this.shortDesc,
  );
  @override
  _DetailPageBState createState() => _DetailPageBState();
}

class _DetailPageBState extends State<DetailPageB> {
  CrossFadeState crossFadeStateValue = CrossFadeState.showFirst;
  Timer? crossFadeTimer;

  @override
  void dispose() {
    if (crossFadeTimer != null) {
      crossFadeTimer!.cancel();
      crossFadeTimer = null;
    }
    super.dispose();
  }

  @override
  void initState() {
    crossFadeTimer = Timer.periodic(Duration(milliseconds: 700), (timer) {
      setState(() {
        if (crossFadeStateValue == CrossFadeState.showFirst) {
          crossFadeStateValue = CrossFadeState.showSecond;
        } else {
          crossFadeStateValue = CrossFadeState.showFirst;
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firstImage = Image.asset(
      'assets/images/deco/${widget.floor}f/${widget.title}.png',
      fit: BoxFit.fitWidth,
    );
    final secondImage = Image.asset(
      'assets/images/deco/${widget.floor}f/${widget.floor}f.png',
      fit: BoxFit.fitWidth,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: <Widget>[
          Material(
            child: AnimatedCrossFade(
              firstChild: firstImage,
              secondChild: secondImage,
              duration: Duration(seconds: 0),
              crossFadeState: crossFadeStateValue,
            ),
          ),
          SizedBox.expand(
            child: DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.55,
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
                            margin: EdgeInsets.fromLTRB(16, 48, 16, 32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "『 ",
                                        style: TextStyle(
                                            fontSize: 19.0,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w900),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        widget.title,
                                        style: TextStyle(fontSize: 19.0),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        " 』",
                                        style: TextStyle(
                                            fontSize: 19.0,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w900),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ]),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  height: 25,
                                  child: CustomPaint(
                                    painter: _SelifTop(),
                                  ),
                                ),
                                Material(
                                  color: Colors.lime.shade900,
                                  child: Container(
                                    margin: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          widget.shortDesc,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                          overflow: TextOverflow.visible,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 55,
                                  child: CustomPaint(
                                    painter: _SelifBottom(),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
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
    );
  }
}

class _SelifBottom extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.lime.shade900
      ..style = PaintingStyle.fill
      ..strokeWidth = 8.0;

    Path path = Path();
    path.addPolygon([
      Offset(size.width, -1),
      Offset(0, -1),
      Offset(0, size.height - 20),
    ], false);
    path.addPolygon([
      Offset(size.width * 0.70, 0),
      Offset(size.width * 0.45, 0),
      Offset(size.width * 0.75, size.height),
    ], false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _SelifTop extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.lime.shade900
      ..style = PaintingStyle.fill
      ..strokeWidth = 8.0;

    Path path = Path();
    path.addPolygon([
      Offset(size.width, size.height + 1),
      Offset(size.width, size.height - 10),
      Offset(0, 0),
      Offset(0, size.height + 1),
    ], false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _SelifBottomCustom extends CustomPainter {
  final Color theme;
  _SelifBottomCustom({required this.theme});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = theme
      ..style = PaintingStyle.fill
      ..strokeWidth = 8.0;

    Path path = Path();
    path.addPolygon([
      Offset(0, -1),
      Offset(size.width, -1),
      Offset(size.width, size.height - 10),
    ], false);
    path.addPolygon([
      Offset(size.width * 0.20, 0),
      Offset(size.width * 0.55, 0),
      Offset(size.width * 0.25, size.height),
    ], false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _SelifTopCustom extends CustomPainter {
  final Color theme;
  _SelifTopCustom({required this.theme});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = theme
      ..style = PaintingStyle.fill
      ..strokeWidth = 8.0;

    Path path = Path();
    path.addPolygon([
      Offset(0, size.height + 1),
      Offset(size.width, 0),
      Offset(size.width, size.height + 1),
    ], false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class DetailPageC extends StatelessWidget {
  final String id;
  final String title;
  final String type;
  final String organizer;
  final String place;
  final String icon;
  final Color themeColor;
  final Color subColor;
  final String shortDesc;
  final String longDesc;
  final List timeTable;
  final List timeList;
  DetailPageC(
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
      this.timeTable,
      this.timeList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[
          Material(
            color: subColor,
            child: Image.asset(
              icon,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox.expand(
            child: DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.55,
              minChildSize: 0.5,
              maxChildSize: 0.75,
              builder: (context, scrollController) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    controller: scrollController,
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
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(16, 16, 16, 32),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(16, 32, 16, 8),
                                      child: Column(
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  "『 ",
                                                  style: TextStyle(
                                                      fontSize: 19.0,
                                                      color: themeColor,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  title,
                                                  style:
                                                      TextStyle(fontSize: 19.0),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  " 』",
                                                  style: TextStyle(
                                                      fontSize: 19.0,
                                                      color: themeColor,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ]),
                                          Text(
                                            type + ' / ' + organizer,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.0),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Wrap(
                                      alignment: WrapAlignment.spaceAround,
                                      children: [
                                        for (int i = 0;
                                            i < timeList.length;
                                            i++)
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8),
                                            child: Text(
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
                                            ),
                                          )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      shortDesc,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600),
                                      overflow: TextOverflow.visible,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 48),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                height: 25,
                                child: CustomPaint(
                                  painter: _SelifTopCustom(theme: themeColor),
                                ),
                              ),
                              Material(
                                color: themeColor,
                                child: Container(
                                  margin: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        longDesc,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 55,
                                child: CustomPaint(
                                  painter:
                                      _SelifBottomCustom(theme: themeColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                            height: 10,
                            thickness: 1,
                            color: Colors.grey[250],
                            indent: 16,
                            endIndent: 16),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 24),
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
                          ),
                        ),
                        timeTable.length != 0
                            ? Column(
                                children: [
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons
                                                  .event_available_outlined),
                                              Text(
                                                'タイムテーブル',
                                                style:
                                                    TextStyle(fontSize: 18.0),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            width: 320,
                                            child: Column(
                                              children: timeTable
                                                  .map((e) => Text(e))
                                                  .toList(),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Material(),
                      ],
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
        ]));
  }
}
