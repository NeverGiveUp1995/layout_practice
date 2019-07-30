import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/components/Drawers/Person/PersonDrawer.dart';
import 'package:layout_practice/components/Header/Header.dart';
import 'package:layout_practice/components/Tab/Tab.dart';
import 'package:layout_practice/components/TabViews/MessageListView/MessaeListView.dart';
import 'package:layout_practice/modals/Message.dart';
import 'package:layout_practice/modals/login_modal/User.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';
import 'package:layout_practice/blocs/theme/bloc.dart';

class Home extends StatefulWidget {
  GlobalKey _key = GlobalKey();

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  String _pageTitle;
  Color backgroundColor = Color.fromARGB(1, 223, 235, 240); //主页背景色
  Color fontColor = Colors.black54; //字体颜色
  AuthBloc _authBloc;
  ThemeBloc _themeBloc;
  static User currentUser = User(
    account: '1000',
    nickname: '夕阳醉了',
    headerImg:
        'http://img3.imgtn.bdimg.com/it/u=2581656380,2188867205&fm=26&gp=0.jpg',
  );
  List<String> titles = ['消息', '联系人', '互动', '短视频'];
  List<Message> testData = [
    Message(
        sender: User(
          account: '1002',
          nickname: '樱木花道',
          headerImg:
              'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1177105977,3340879911&fm=26&gp=0.jpg',
        ),
        addressee: currentUser,
        sendTime: "7:50",
        messageContent: "欧蕾哇撒苦辣米奇！"),
    Message(
        sender: User(
          account: '1003',
          nickname: '赤木刚宪',
          headerImg: null,
        ),
        addressee: currentUser,
        sendTime: "昨天",
        messageContent: "好好练球，拿全国第一"),
    Message(
        sender: User(
          account: '1004',
          nickname: '赤木晴子',
          headerImg: null,
        ),
        addressee: currentUser,
        sendTime: "昨天",
        messageContent: '哥哥今年有希望拿全国第一了，为他加油！'),
    Message(
        sender: User(
          account: '1005',
          nickname: '流川枫',
          headerImg: 'http://jf258.com/uploads/2013-07-04/225600249.jpg',
        ),
        addressee: currentUser,
        sendTime: "昨天",
        messageContent: '上课又睡着了！'),
    Message(
        sender: User(
          account: '1006',
          nickname: '安西教练',
          headerImg: null,
        ),
        addressee: currentUser,
        sendTime: "昨天",
        messageContent: '哈哈哈哈哈哈。。。'),
    Message(
        sender: User(
          account: '1007',
          nickname: '宫城良田',
          headerImg: null,
        ),
        addressee: currentUser,
        sendTime: "昨天",
        messageContent: '花道又被流川虐了！'),
    Message(
        sender: User(
          account: '1008',
          nickname: '三井寿',
          headerImg: null,
        ),
        addressee: currentUser,
        sendTime: "昨天",
        messageContent: '老师，我想打篮球'),
    Message(
        sender: User(
          account: '1009',
          nickname: '仙道章',
          headerImg: null,
        ),
        addressee: currentUser,
        sendTime: "昨天",
        messageContent: '我是no.1'),
    Message(
        sender: User(
          account: '1010',
          nickname: '18号',
          headerImg: null,
        ),
        addressee: currentUser,
        sendTime: "昨天",
        messageContent: '我的克林呢'),
    Message(
        sender: User(
          account: '1011',
          nickname: '悟天',
          headerImg: null,
        ),
        addressee: currentUser,
        sendTime: "昨天",
        messageContent: '你看见特兰克斯了吗'),
    Message(
        sender: User(
          account: '1012',
          nickname: '撒旦',
          headerImg: null,
        ),
        addressee: currentUser,
        sendTime: "2天前",
        messageContent: '哈哈哈，我撒旦第一！'),
    Message(
        sender: User(
          account: '1013',
          nickname: '琦玉',
          headerImg: null,
        ),
        addressee: currentUser,
        sendTime: "2天前",
        messageContent: '一拳捶爆你哦！'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      this._pageTitle = titles[0];
    });
  }

  void _changeTitle(int tabIndex) {
    this.setState(() => {this._pageTitle = titles[tabIndex]});
  }

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    if (_themeBloc.currentState.theme != null &&
        _themeBloc.currentState.theme.textColor.value != fontColor.value) {
      this.setState(() {
        fontColor = Color(_themeBloc.currentState.theme.textColor.value);
      });
    }
    if (_themeBloc.currentState.theme != null &&
        _themeBloc.currentState.theme.mainColor.value !=
            backgroundColor.value) {
      this.setState(() {
        backgroundColor = Color(_themeBloc.currentState.theme.mainColor.value);
      });
    }
    return MultiBlocListener(
      listeners: [
        BlocListener(
          listener: (context, state) {},
          bloc: _authBloc,
        ),
        BlocListener(
          listener: (context, state) {},
          bloc: _themeBloc,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
//        设置阴影辐射范围
          elevation: 0,
          backgroundColor: _themeBloc.currentState.theme != null
              ? _themeBloc.currentState.theme.titleBarBGColor
              : Colors.white,
          leading: Header(
            width: 30.0,
            height: 30.0,
            borderColor: Color(0x00000000),
            borderWidth: 0.0,
            imgSrc: _authBloc.currentState.user != null
                ? _authBloc.currentState.user.headerImg
                : null,
            isMan: true,
          ),
          title: Text(
            _pageTitle, //页面标题
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: _themeBloc.currentState.theme != null &&
                      _themeBloc.currentState.theme.titleBarTextColor != null
                  ? _themeBloc.currentState.theme.titleBarTextColor
                  : fontColor,
            ),
          ),
          iconTheme: IconThemeData(
            color: _themeBloc.currentState.theme != null &&
                    _themeBloc.currentState.theme.textColor != null
                ? _themeBloc.currentState.theme.textColor
                : fontColor,
          ),
          actions: <Widget>[
//          隐藏起来的菜单项
            PopupMenuButton<String>(
              offset: Offset(0, 50),
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    PopupMenuItem(
                      value: 'A',
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.search,
                              color: _themeBloc.currentState.theme != null &&
                                      _themeBloc.currentState.theme
                                              .titleBarTextColor !=
                                          null
                                  ? _themeBloc
                                      .currentState.theme.titleBarTextColor
                                  : null,
                              size: 18,
                            ),
                          ),
                          Text(
                            '查找好友',
                            style: TextStyle(
                              color: _themeBloc.currentState.theme != null &&
                                      _themeBloc.currentState.theme
                                              .titleBarTextColor !=
                                          null
                                  ? _themeBloc
                                      .currentState.theme.titleBarTextColor
                                  : null,
                            ),
                          )
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'B',
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.supervisor_account,
                              color: _themeBloc.currentState.theme != null &&
                                      _themeBloc.currentState.theme
                                              .titleBarTextColor !=
                                          null
                                  ? _themeBloc
                                      .currentState.theme.titleBarTextColor
                                  : null,
                              size: 18,
                            ),
                          ),
                          Text(
                            '创建群聊',
                            style: TextStyle(
                              color: _themeBloc.currentState.theme != null &&
                                      _themeBloc.currentState.theme
                                              .titleBarTextColor !=
                                          null
                                  ? _themeBloc
                                      .currentState.theme.titleBarTextColor
                                  : null,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
              onSelected: (String action) {
                switch (action) {
                  case 'A':
                    print("选择了A");
                    break;
                  case 'B':
                    print("选择了B");
                    break;
                }
              },
            )
          ],
        ),
        body: Center(
          child: Container(
            color: _themeBloc.currentState.theme != null &&
                    _themeBloc.currentState.theme.mainColor != null
                ? _themeBloc.currentState.theme.mainColor
                : backgroundColor,
            child: TabView(
              onTabChange: this._changeTitle,
              titles: titles,
              tabViews: [
                MessageListView(
                  messageList: testData,
                  themeBloc: _themeBloc,
                ),
                Container(
                  child: Text("暂未开放"),
                ),
                Container(
                  child: Text("暂未开放"),
                ),
                Container(
                  child: Text("暂未开放"),
                ),
              ],
            ),
          ),
        ),
        drawer: Drawer(
          elevation: 200,
          child: PersonDrawer(),
        ),
      ),
    );
  }
}
