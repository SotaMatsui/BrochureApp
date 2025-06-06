import 'package:flutter/material.dart';
import 'package:flutter/services.Dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'pages/home.dart';
import 'pages/explore.dart';
import 'pages/others.dart';
import 'pages/deco.dart';

final bnbIndexProvider = StateProvider<int>((ref) {
  return 0;
});

void main() async {
  await fetchJson();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  // 画面の向きを固定.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]); 
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

String loadData = "";
Future<void> fetchJson() async {
  final response =
      await http.get(Uri.parse('https://fesbrochuredata.web.app/data.json'));
  if (response.statusCode == 200) {
    loadData = utf8.decode(response.body.runes.toList());
  }
}

final homeDataProvider = StateProvider<Map>((ref) {
  return json.decode(loadData)['home'];
});

class Error0 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Error0:\nインターネットに接続されていないか、サーバーが無効です。',
            style: TextStyle(
                color: Colors.grey[400],
                fontSize: 24,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

class MyApp extends ConsumerWidget {
  static Map<int, Color> color = {
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  };

  final MaterialColor justWhite = MaterialColor(0xFFFFFFFF, color);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int _selectedIndex = ref.watch(bnbIndexProvider).state;
    List<Widget> _pageList = [
      HomePage(
        jsondata: loadData,
      ),
      ExplorePage(
        jsondata: loadData,
      ),
      DecoPage(
        jsondata: loadData,
      ),
      OthersPage(
        jsondata: loadData,
      )
    ];
    void _onItemTapped(int index) {
      ref.read(bnbIndexProvider).state = index;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: justWhite,
        brightness: Brightness.light,
        accentColor: Colors.black,
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontFamily: 'LexendDeca',
            fontWeight: FontWeight.w500,
            fontFamilyFallback: ['NotoSansJP'],
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'LexendDeca',
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamilyFallback: ['NotoSansJP']),
              ),
        ),
      ),
      home: loadData != ''
          ? Scaffold(
              body: _pageList[_selectedIndex],
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  selectedItemColor: Colors.blue[700],
                  backgroundColor: Colors.white,
                  selectedFontSize: 0,
                  unselectedFontSize: 0,
                  elevation: 0,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.store_outlined),
                      label: 'Explore',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.travel_explore_outlined),
                      label: 'Decolations',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.menu_outlined),
                      label: 'More',
                    ),
                  ],
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                ),
              ),
            )
          : Error0(),
    );
  }
}
