import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:fes_brochure/components/detail.dart';

class TabInfo {
  String label;
  Widget widget;
  TabInfo(this.label, this.widget);
}

class ExplorePage extends StatefulWidget {
  final String jsondata;
  ExplorePage({required this.jsondata}); //コンストラクタ
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with SingleTickerProviderStateMixin {
  List _data1 = [];
  List _data1Final = [];
  List _data2 = [];
  Map _data2N = {};
  Map _data2TL = {};
  Map _orgs1 = {};
  Map _orgs1B = {};
  Future<void> loadJsonAsset() async {
    _data1 = [];
    _data2 = [];
    _data2N = {};
    var unsorted = {};
    _data2TL = {};
    setState(() {
      _data1 = json.decode(widget.jsondata)['explore']['permanent'];
      _data2 = json.decode(widget.jsondata)['explore']['scheduled'];
      _data1Final = _data1;
      if (_data1.length != 0) {
        _data1.forEach((element) {
          var searchValue = element['organizer'];
          if (element['organizer'].contains('1-')) {
            searchValue = '1年';
          } else if (element['organizer'].contains('2-')) {
            searchValue = '2年';
          } else if (element['organizer'].contains('3-')) {
            searchValue = '3年';
          } else if (element['organizer'].contains('部')) {
            searchValue = '部活動';
          } else if (element['organizer'].contains('委員')) {
            searchValue = '委員会';
          } else if (element['organizer'].contains('科')) {
            searchValue = '教科';
          } else {
            searchValue = 'その他';
          }
          if (_orgs1.containsKey(searchValue)) {
            _orgs1[searchValue].add(element['ID']);
          } else {
            _orgs1.addAll({
              searchValue: [element['ID']]
            });
          }
        });
        _data1.forEach((element) {
          var searchValue = element['type'];
          if (searchValue.contains('展示')) {
            searchValue = '展示発表';
          } else if (searchValue.contains('2-')) {
            searchValue = '2年';
          } else if (searchValue.contains('3-')) {
            searchValue = '3年';
          } else if (searchValue.contains('部')) {
            searchValue = '部活動';
          } else if (searchValue.contains('委員')) {
            searchValue = '委員会';
          } else if (searchValue.contains('科')) {
            searchValue = '教科';
          } else {
            searchValue = 'その他';
          }
          if (_orgs1B.containsKey(searchValue)) {
            _orgs1B[searchValue].add(element['ID']);
          } else {
            _orgs1B.addAll({
              searchValue: [element['ID']]
            });
          }
        });
      }

      if (_data2.length != 0) {
        _data2.forEach((element) {
          //リスト生成
          _data2N.addEntries({element['ID']: element}.entries);
          // 元配列のtimeをループ
          for (int i = 0; i < element['time'].length; i++) {
            var strStart = element['time'][i]['start'].toString();
            var strEnd = element['time'][i]['end'].toString();
            var strTime = strStart.substring(0, 2) +
                ':' +
                strStart.substring(2, 4) +
                '~' +
                strEnd.substring(0, 2) +
                ':' +
                strEnd.substring(2, 4);
            var intTime = (int.parse(strStart.substring(0, 2)) * 60) +
                int.parse(strStart.substring(2, 4));
            if (unsorted[intTime] == null) {
              unsorted.addAll({
                intTime: [
                  {'ID': element["ID"], 'strTime': strTime}
                ]
              }); // TL配列にmapを追加
            } else {
              //リストに時間を追加
              unsorted[intTime].add({'ID': element["ID"], 'strTime': strTime});
            }
          }
        });
        var sortedKeys = unsorted.keys.toList()..sort();
        sortedKeys.forEach((value) {
          _data2TL[value] = unsorted[value];
        });
      }
    });
  }

  TabController? _tabController;
  bool isWithFilter = true;
  List pageWithFilter = [0];
  @override
  void initState() {
    loadJsonAsset();
    super.initState();
    // ignore: todo
    //TODO このマジでガチでヤバいハードコーディングなんとかする
    _tabController = TabController(length: 2, vsync: this);
    judgeIsWithFilter();
    _tabController?.addListener(() {
      judgeIsWithFilter();
    });
  }

  void judgeIsWithFilter() {
    setState(() {
      if (pageWithFilter.contains(_tabController?.index)) {
        isWithFilter = true;
      } else {
        isWithFilter = false;
      }
    });
  }

  List _filPermOrg = [];
  List _filPermGenre = [];
  void addFilter(String type, String value) {
    setState(() {
      if (type == 'org') {
        _filPermOrg.add(value);
      }
      if (type == 'genre') {
        _filPermGenre.add(value);
      }
    });
    renewData();
  }

  void removeFilter(String type, String value) {
    setState(() {
      if (type == 'org') {
        _filPermOrg.removeAt(_filPermOrg.indexOf(value));
      }
      if (type == 'genre') {
        _filPermGenre.removeAt(_filPermGenre.indexOf(value));
      }
    });
    renewData();
  }

  void renewData() {
    if (_filPermOrg.length != 0) {
      List hoge = [];
      List huga = [];
      //フィルターのリストからカテゴリの中身をhogeに追加
      _filPermOrg.forEach((element) {
        hoge.insertAll(0, _orgs1[element]);
      });
      //idをソート
      hoge.sort((a, b) => int.parse(a) - int.parse(b));

      _data1.forEach((element) {
        if (hoge.contains(element['ID'])) {
          huga.add(element);
        }
      });
      _data1Final = huga;
    } else {
      _data1Final = _data1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<TabInfo> _tabs = [
      TabInfo("展示型企画", PermPage(_data1Final)),
      TabInfo("イベント型企画", SchePage(_data2N, _data2TL)),
    ];

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Explore',
                style: TextStyle(fontSize: 21.0),
              ),
              Text(
                ' - 企画を探す',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
              ),
            ],
          ),
          bottom: PreferredSize(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      isScrollable: true,
                      labelColor: Colors.black,
                      labelStyle: TextStyle(fontWeight: FontWeight.w500),
                      tabs: _tabs.map((TabInfo tab) {
                        return Tab(
                          text: tab.label,
                        );
                      }).toList(),
                      controller: _tabController,
                    ),
                  ),
                ),
              ],
            ),
            preferredSize: Size.fromHeight(40.0),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _tabs.map((tab) => tab.widget).toList(),
        ),
        floatingActionButton: isWithFilter
            ? FloatingActionButton.extended(
                icon: Icon(Icons.filter_alt_outlined),
                label: _filPermOrg.length == 0
                    ? Text('絞り込む')
                    : Row(children: [
                        Text('絞り込む '),
                        Material(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          child: SizedBox(
                            height: 18,
                            width: 18,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(_filPermOrg.length.toString()),
                            ),
                          ),
                        ),
                      ]),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) => StatefulBuilder(builder:
                        (BuildContext context, StateSetter setModalState) {
                      //ModalSheetのsetStateを定義
                      return Wrap(
                        children: [
                          AppBar(
                            title: Text('条件を絞り込む'),
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Organizer',
                                      style: TextStyle(fontSize: 21.0),
                                    ),
                                    Text(
                                      ' - 主催者で絞り込む',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 120,
                                child: Wrap(
                                  children: _orgs1.keys
                                      .map((e) => Container(
                                            padding: EdgeInsets.all(4),
                                            child: FilterChip(
                                              backgroundColor:
                                                  Colors.transparent,
                                              shape: StadiumBorder(
                                                  side: BorderSide()),
                                              label: Text(e),
                                              selectedColor: Colors.black,
                                              checkmarkColor: Colors.white,
                                              labelStyle: TextStyle(
                                                  color: _filPermOrg.contains(e)
                                                      ? Colors.white
                                                      : Colors.black),
                                              selected: _filPermOrg.contains(e),
                                              onSelected: (bool value) {
                                                setModalState(() {
                                                  //Modal側のsetState
                                                  value
                                                      ? addFilter('org', e)
                                                      : removeFilter('org', e);
                                                });
                                              },
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  );
                },
              )
            : null,
      ),
    );
  }
}

class SchePage extends StatelessWidget {
  final Map _data;
  final Map _dataTL;
  SchePage(this._data, this._dataTL);

  Widget build(BuildContext context) {
    return Container(
      child: (_dataTL.length == 0)
          ? Text("Loading....")
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                var intTime = int.parse(_dataTL.keys
                    .toString()
                    .substring(1, _dataTL.keys.toString().length - 1)
                    .split(', ')[index]);
                var intHour = intTime ~/ 60;
                var intMin = intTime % 60;
                var time = intHour.toString() +
                    ':' +
                    intMin.toString().padLeft(2, '0');

                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                time,
                                style: TextStyle(fontSize: 24.0),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                ' より開始',
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 12.0),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        ScheItem(_data, _dataTL[intTime]),
                      ],
                    ),
                  ),
                );
              },
              itemCount: _dataTL.length,
            ),
    );
  }
}

class ScheItem extends StatelessWidget {
  final Map _data;
  final List _dataTL;
  ScheItem(this._data, this._dataTL);

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < _dataTL.length; i++)
          _menuItem(
              _dataTL[i]['ID'],
              _data[_dataTL[i]['ID']]['title'],
              _data[_dataTL[i]['ID']]['genre'],
              _data[_dataTL[i]['ID']]['organizer'],
              _data[_dataTL[i]['ID']]['place'],
              _data[_dataTL[i]['ID']]['time'],
              _data[_dataTL[i]['ID']]['timeTable'],
              'https://fesbrochuredata.web.app/img/titleImg/${_dataTL[i]['ID']}.png',
              Color.fromRGBO(
                  int.parse(
                      _data[_dataTL[i]['ID']]['primaryColor'].split(',')[0]),
                  int.parse(
                      _data[_dataTL[i]['ID']]['primaryColor'].split(',')[1]),
                  int.parse(
                      _data[_dataTL[i]['ID']]['primaryColor'].split(',')[2]),
                  double.parse(
                      _data[_dataTL[i]['ID']]['primaryColor'].split(',')[3])),
              Color.fromRGBO(
                  int.parse(
                      _data[_dataTL[i]['ID']]['seconderyColor'].split(',')[0]),
                  int.parse(
                      _data[_dataTL[i]['ID']]['seconderyColor'].split(',')[1]),
                  int.parse(
                      _data[_dataTL[i]['ID']]['seconderyColor'].split(',')[2]),
                  double.parse(
                      _data[_dataTL[i]['ID']]['seconderyColor'].split(',')[3])),
              _data[_dataTL[i]['ID']]['shortDesc'],
              _data[_dataTL[i]['ID']]['longDesc'],
              _dataTL[i]['strTime'],
              context),
      ],
    );
  }

  Widget _menuItem(
      String id,
      String title,
      String type,
      String organizer,
      String place,
      List timeList,
      List timeTable,
      String icon,
      Color themeColor,
      Color subColor,
      String shortDesc,
      String longDesc,
      String time,
      BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (context) => DetailPageC(
                      id,
                      title,
                      type,
                      organizer,
                      place,
                      icon,
                      themeColor,
                      subColor,
                      shortDesc,
                      longDesc,
                      timeTable,
                      timeList),
                );
              },
              child: SizedBox(
                height: 156,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                          height: 156,
                          width: 156,
                          child: Material(
                            color: Colors.grey[200],
                            child: Image.network(
                              icon,
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    title,
                                    style: TextStyle(fontSize: 14.0),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    type + ' / ' + organizer,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12.0),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    time,
                                    style: TextStyle(fontSize: 14.0),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ), /* 
                                  Container(
                                    padding: EdgeInsets.only(top: 12),
                                    child: Icon(Icons.favorite_border_outlined),
                                  ), */
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class PermPage extends StatelessWidget {
  final List _data;
  PermPage(this._data);

  Widget build(BuildContext context) {
    return Container(
      child: (_data.length == 0)
          ? Text("Loading....")
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 320,
                mainAxisSpacing: 12.0,
                crossAxisSpacing: 12.0,
                childAspectRatio: 0.7,
              ),
              padding: EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (BuildContext context, int index) {
                return _menuItem(
                    _data[index]['ID'],
                    _data[index]['title'],
                    _data[index]['genre'],
                    _data[index]['organizer'],
                    _data[index]['place'],
                    'https://fesbrochuredata.web.app/img/titleImg/${_data[index]['ID']}.png',
                    Color.fromRGBO(
                        int.parse(_data[index]['primaryColor'].split(',')[0]),
                        int.parse(_data[index]['primaryColor'].split(',')[1]),
                        int.parse(_data[index]['primaryColor'].split(',')[2]),
                        double.parse(
                            _data[index]['primaryColor'].split(',')[3])),
                    Color.fromRGBO(
                        int.parse(_data[index]['seconderyColor'].split(',')[0]),
                        int.parse(_data[index]['seconderyColor'].split(',')[1]),
                        int.parse(_data[index]['seconderyColor'].split(',')[2]),
                        double.parse(
                            _data[index]['seconderyColor'].split(',')[3])),
                    _data[index]['shortDesc'],
                    _data[index]['longDesc'],
                    context);
              },
              itemCount: _data.length,
            ),
    );
  }

  Widget _menuItem(
      String id,
      String title,
      String type,
      String organizer,
      String place,
      String icon,
      Color themeColor,
      Color subColor,
      String shortDesc,
      String longDesc,
      BuildContext context) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
                    builder: (context) => DetailPageA(
                        id,
                        title,
                        type,
                        organizer,
                        place,
                        icon,
                        themeColor,
                        subColor,
                        shortDesc,
                        longDesc),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Material(
                          color: Colors.grey[200],
                          child: Image.network(
                            icon,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ),
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(fontSize: 14.0),
                          overflow: TextOverflow.visible,
                        ),
                        Text(
                          type + ' / ' + organizer,
                          style: TextStyle(color: Colors.grey, fontSize: 12.0),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ), /* 
                  Icon(Icons.favorite_border_outlined), */
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
