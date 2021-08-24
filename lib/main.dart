import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pages/home.dart';
import 'pages/explore.dart';
import 'pages/others.dart';

final bnbIndexProvider = StateProvider<int>((ref) {
  return 0;
});

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int _selectedIndex = ref.watch(bnbIndexProvider).state;
    List<Widget> _pageList = [homePage(), explorePage(), othersPage()];
    void _onItemTapped(int index) {
      ref.read(bnbIndexProvider).state = index;
    }

    return MaterialApp(
      home: Scaffold(
        body: _pageList[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              title: Text('ホーム'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store_outlined),
              title: Text('展示型企画'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_outlined),
              title: Text('お気に入り'),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
