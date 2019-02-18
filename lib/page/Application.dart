import 'package:flutter/material.dart';
import 'package:gankflutter/page/home/IndexDrawPage.dart';
import 'package:gankflutter/constant/GoldenConfig.dart';
import 'package:gankflutter/page/home/HomePage.dart';
import 'package:gankflutter/page/classify/ClassifyPage.dart';

class ApplicationPage extends StatefulWidget {
  @override
  ApplicationState createState() => new ApplicationState();
}

class ApplicationState extends State<ApplicationPage>{
  String title = GoldenConfig.homeTab;
  int page = 0;
  PageController pageController;

  //定义底部导航
  final List<BottomNavigationBarItem> _bottomBar = <BottomNavigationBarItem>[
    new BottomNavigationBarItem(
        icon: Icon(Icons.home), title: new Text(GoldenConfig.homeTab)),
    new BottomNavigationBarItem(
        icon: Icon(Icons.tune), title: new Text(GoldenConfig.classType)),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = new PageController(initialPage: this.page);
  }

  @override
  void dispose() {
    pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        drawer: new Drawer(
          child: new IndexDrawPage(
            name: GoldenConfig.name,
            profileImage: "images/head.jpg",
            email: GoldenConfig.email,
            background: "images/girl.png",
          ),
        ),
        body: new PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
//          children: <Widget>[new ColumnWidget(),new ColumnWidget(),new ColumnWidget()],
        children: <Widget>[HomePage(),ClassifyPage()],
          onPageChanged: _onPageChanged,
        ),
        bottomNavigationBar: new BottomNavigationBar(
          items: _bottomBar,
          fixedColor: Colors.red,
          currentIndex: page,
          type: BottomNavigationBarType.fixed,
          onTap:_onTap,
        ),
      );
  }

  void _onTap(int index) {
    pageController.animateToPage(
        index, duration: const Duration(milliseconds: 300),
        curve: Curves.ease);
  }

  void _onPageChanged(int page) {
    setState(() {
      this.page = page;
      switch (page) {
        case 0:
          title = GoldenConfig.homeTab;
          break;
        case 1:
          title = GoldenConfig.classType;
          break;
      }
    });
  }
}
