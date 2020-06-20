import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tab1_page.dart';
import 'package:newsapp/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text('News Today'),
        ),
        body: _Pages(),
        bottomNavigationBar: _BottomNav(),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);
    
    return BottomNavigationBar(
        currentIndex: navigationModel.currentPage,
        onTap: (i) => {navigationModel.currentPage = i},
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), title: Text('para ti')),
          BottomNavigationBarItem(
              icon: Icon(Icons.public), title: Text('Encabezados'))
        ]);
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(      
      controller: navigationModel.pageController, 
      physics: BouncingScrollPhysics(),
      onPageChanged: (i) => navigationModel.currentPage = i,
      children: <Widget>[Tab1Page(), Tab2Page()],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);

  int get currentPage => this._currentPage;

  set currentPage(int value) {
    this._currentPage = value;
    _pageController.animateToPage(value,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);

    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
