import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/components/Drawers/Person/PersonDrawer.dart';
import 'package:layout_practice/components/Header/Header.dart';
import 'package:layout_practice/components/Tab/Tab.dart';
import 'package:layout_practice/components/TabViews/MessageListView/MessaeListView.dart';
import 'package:layout_practice/modals/Message.dart';
import 'package:layout_practice/modals/login_modal/User.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';

class Home extends StatefulWidget {
  GlobalKey _key = GlobalKey();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> {
  String _pageTitle;
  Color backgroundColor = Color.fromARGB(1, 223, 235, 240); //主页背景色
  Color fontColor = Colors.black54; //字体颜色
  AuthBloc _authBloc;

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
    return BlocBuilder(
      bloc: _authBloc,
      builder: (BuildContext context, AuthState _currentState) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
//        设置阴影辐射范围
            elevation: 0,
            leading: Header(
              width: 30.0,
              height: 30.0,
              imgSrc: _currentState.user.headerImg,
              isMan: true,
            ),
            title: Text(
              _pageTitle, //页面标题
              textAlign: TextAlign.center,
              style: TextStyle(color: fontColor),
            ),
            iconTheme: IconThemeData(color: fontColor),
            actions: <Widget>[
//          隐藏起来的菜单项
              PopupMenuButton<String>(
                itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                      PopupMenuItem(
                        value: 'A',
                        child: Row(
                          children: <Widget>[Icon(Icons.add), Text('查找好友')],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'B',
                        child: Row(
                          children: <Widget>[Icon(Icons.group), Text('创建群聊')],
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
              ),
            ],
          ),
          body: Center(
            child: Container(
              color: backgroundColor,
              child: TabView(
                onTabChange: this._changeTitle,
                titles: titles,
                tabViews: [
                  MessageListView(messageList: testData),
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
        );
      },
    );
  }
}
