import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';

class TabView extends StatefulWidget {
  Color normalColor = Colors.black38; //默认常态的颜色
  Color selectedColor = Colors.redAccent; //默认选中时的颜色
  double iconSize = 18;
  double textSize = 10;
  Function onTabChange;
  List<String> titles = ['tab1', 'tab2', 'tab3', 'tab4'];
  List<IconData> icons = [
    Icons.message,
    Icons.person,
    Icons.supervisor_account,
    Icons.videocam,
  ];
  List<Widget> tabViews = [
    Container(
      color: Colors.black26,
      child: Text('page1'),
    ),
    Container(
      color: Colors.black26,
      child: Text('page2'),
    ),
    Container(
      color: Colors.black26,
      child: Text('page3'),
    ),
    Container(
      color: Colors.black26,
      child: Text('page4'),
    ),
  ];

  TabView({
    icons,
    titles,
    tabViews,
    iconSize,
    textSize,
    onTabChange,
    normalColor,
    selectedColor,
  }) {
    if (icons != null) {
      this.icons = icons;
    }
    if (titles != null) {
      this.titles = titles;
    }
    if (iconSize != null) {
      this.iconSize = iconSize;
    }
    if (textSize != null) {
      this.iconSize = textSize;
    }
    if (normalColor != null) {
      this.normalColor = normalColor;
    }
    if (selectedColor != null) {
      this.selectedColor = selectedColor;
    }
    if (tabViews != null) {
      this.tabViews = tabViews;
    }
    this.onTabChange = onTabChange;
  }

  @override
  State<StatefulWidget> createState() {
    return TabViewState(
      icons: this.icons,
      titles: this.titles,
      tabViews: this.tabViews,
      iconSize: this.iconSize,
      textSize: this.textSize,
      onTabChange: this.onTabChange,
      normalColor: this.normalColor,
      selectedColor: this.selectedColor,
    );
  }
}

class TabViewState extends State<TabView> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _selectedIndex;
  Color normalColor; //默认常态的颜色
  Color selectedColor; //默认选中时的颜色
  double iconSize;
  double textSize;
  @required
  Function onTabChange; //tab切换时，回调函数
  List<String> titles;
  List<IconData> icons;
  List<Widget> tabViews;

  TabViewState(
      {icons,
      titles,
      tabViews,
      iconSize,
      textSize,
      onTabChange,
      normalColor,
      selectedColor}) {
    this.icons = icons;
    this.titles = titles;
    this.tabViews = tabViews;
    this.iconSize = iconSize;
    this.textSize = textSize;
    this.onTabChange = onTabChange;
    this.normalColor = normalColor;
    this.selectedColor = selectedColor;
  }

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(vsync: this, initialIndex: 0, length: titles.length);
    _tabController.addListener(() {
      setState(() => _selectedIndex = _tabController.index);
      this.onTabChange(_tabController.index);
    });
  }

  List<Widget> _renderTabs() {
    List<Widget> tabs = [];
    if (icons != null && icons.length > 0) {
      for (int i = 0; i < icons.length; i++) {
        tabs.add(new EachTab(
          width: i == 0 ? 70 : null,
          height: 60,
          iconPadding: EdgeInsets.all(0),
          icon: _selectedIndex == i
              ? Icon(
                  icons[i],
                  color: this.selectedColor,
                  size: iconSize,
                )
              : Icon(
                  icons[i],
                  color: this.normalColor,
                  size: iconSize,
                ),
          text: titles[i],
          textStyle: TextStyle(
              fontSize: textSize,
              color: _selectedIndex == i ? selectedColor : null),
          badgeNo: i == 0 ? "13" : "",
          badgeColor: Colors.red,
        ));
      }
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 64,
        child: Column(
          children: <Widget>[
            Divider(
              height: 2,
            ),
            new TabBar(
              isScrollable: false,
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: selectedColor,
              labelPadding: EdgeInsets.all(0),
              unselectedLabelColor: normalColor,
              tabs: _renderTabs(),
            ),
          ],
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(), //设置滑动的效果，这个禁用滑动
        controller: _tabController,
        children: this.tabViews,
      ),
    );
  }
}
