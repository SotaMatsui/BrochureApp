import 'package:flutter/material.dart';
import 'package:fes_brochure/components/moreInfo.dart';
import 'package:fes_brochure/components/detail.dart';
import 'dart:convert';

class TabInfo {
  String label;
  Widget widget;
  TabInfo(this.label, this.widget);
}

class DecoPage extends StatefulWidget {
  final String jsondata;
  DecoPage({required this.jsondata});
  @override
  _DecoPageState createState() => _DecoPageState();
}

class _DecoPageState extends State<DecoPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(
      text: '1階',
    ),
    Tab(
      text: "2階",
    ),
    Tab(
      text: "3階",
    )
  ];
  List<Widget> bodys = [];
  int? tabIndex = 0;
  TabController? _tabController;
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
    _tabController = TabController(length: 3, vsync: this);
    makeWidgetList(0);
    _tabController?.addListener(() {
      tabChanged();
    });
  }

  void tabChanged() {
    setState(() {
      tabIndex = _tabController?.index;
      makeWidgetList(_tabController?.index);
    });
  }

  void makeWidgetList(int? floor) {
    setState(() {
      bodys = [
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
        TabBar(
          tabs: tabs,
          controller: _tabController,
        )
      ];
      for (var i = 0; i < _data1['midokoro']['${floor! + 1}f'].length; i++) {
        bodys.add(
          _menuItemB(
            _data1['midokoro']['${floor + 1}f'][i]['title'],
            floor + 1,
            _data1['midokoro']['${floor + 1}f'][i]['body'],
            context,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Decolations',
                      style: TextStyle(fontSize: 21.0),
                    ),
                    Text(
                      ' - 校内装飾',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 16.0),
                    ),
                  ],
                ),
                backgroundColor: Colors.white.withOpacity(0),
                elevation: 0,
              ),
              Image.asset(
                'assets/images/deco/${tabIndex! + 1}f/${tabIndex! + 1}f.png',
                height: (deviceHeight * 0.5)- 112 ,
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: bodys.length,
                    itemBuilder: (context, index) {
                      return bodys[index];
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

  Widget _menuItemB(
      String title, int floor, String shortDesc, BuildContext context) {
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
                    builder: (context) => DetailPageB(title, floor, shortDesc),
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
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: Text(
                              title,
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 16.0),
                            ),
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
