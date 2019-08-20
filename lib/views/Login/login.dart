import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:layout_practice/blocs/auth/auth_bloc.dart';
import 'package:layout_practice/blocs/message/bloc.dart';
import 'package:layout_practice/blocs/theme/bloc.dart';
import 'package:layout_practice/blocs/webSocket/bloc.dart';
import 'package:layout_practice/components/Header/Header.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';
import 'package:layout_practice/components/tips/loading.dart';
import 'package:layout_practice/config/my_flutter_app_icons.dart';
import 'package:layout_practice/modals/login_modal/User.dart';
import 'package:layout_practice/utils/Utils.dart';
import 'package:layout_practice/modals/theme/Theme.dart' as myThemes;
import 'package:layout_practice/theme/ThemeData.dart';
import 'package:layout_practice/utils/Utils.dart';
import 'package:layout_practice/utils/consts/CacheFolderNames.dart';
import 'package:layout_practice/utils/consts/FileNames.dart';
import 'package:layout_practice/utils/consts/ServerAddresses.dart';
import 'dart:convert';
import 'dart:io';
import 'package:layout_practice/utils/webSocket/MessageUtils.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey _key = GlobalKey();
  AuthBloc _authBloc;
  ThemeBloc _themeBloc;
  MessageBloc _messageBloc;
  WebSocketBloc _webSocketBloc;
  int _selectedServerIndex = 0;
  final String userName = null; //定义常量帐号
  final String password = null; //定义常量密码
  final Color redColor = Colors.red; //需要用到的颜色
  final Color green = new Color.fromRGBO(49, 194, 124, 0);
  TextEditingController userNameController =
      new TextEditingController(); //用户名控制器，用于登录时，获取输入框中的数据
  TextEditingController passwordController =
      new TextEditingController(); //密码控制器，用于登录时，获取输入框中的数据

  final TextStyle textStyle = new TextStyle(
    color: Colors.grey,
    fontSize: 18,
  );

  //处理帐号变化回调,验证合法性
  void _login(AuthBloc authBloc, BuildContext buildContext) {
    print(
      "userName:" +
          userNameController.text +
          "\n" +
          "password:" +
          passwordController.text,
    );
    RegExp exp = new RegExp("^1(3|4|5|7|8)\d{9}");
    print(exp.hasMatch(userNameController.text));
    _initTheme(_themeBloc, userNameController.text);
    Utils.loading(context, true);
    authBloc.dispatch(
      LoginEvent(
          buildContext, userNameController.text, passwordController.text),
    );
  }

  /**
   * 切换服务器地址
   */
  _toggleServer(int index) {
    String toggleIp = ServerAddresses.ipList[index];
    print("即将切换的ip：$toggleIp");
  }

  _initTheme(ThemeBloc _themeBloc, String userAccount) async {
    myThemes.Theme initTheme = null;
    var themeJson = null;
    myThemes.Theme currentTheme = null;

    ///   初始化主题
    //1.先从本地读取缓存文件，如果换成你文件中有设置的主题，则设置当前默认主题为缓存文件中的主题
    File themeFile = await Utils.getLocalFile(
      currentLoginUserAccount: userAccount,
      folderName: CacheFolderNames.themes,
      filename: '${FileNames.theme}',
    );

    String themeData = await Utils.readContentFromFile(themeFile);
    try {
      themeJson = themeData != null ? json.decode(themeData) : null;
    } catch (e) {
      print("当前设置的主题文件已损坏！即将恢复默认设置");
    }
    if (themeJson != null) {
      try {
        currentTheme = myThemes.Theme(
          themeId: themeJson['themeId'],
          themeName: themeJson['themeName'],
          mainColor: int.parse(themeJson['mainColor']),
          titleBarBGColor: int.parse(themeJson['titleBarBGColor']),
          titleBarTextColor: int.parse(themeJson['titleBarTextColor']),
          bodyColor: int.parse(themeJson['bodyColor']),
          bottomColor: int.parse(themeJson['bottomColor']),
          personDrawerBgColor: int.parse(themeJson['personDrawerBgColor']),
          contrastColor: int.parse(themeJson['contrastColor']),
          tipModalTextColor: int.parse(themeJson['tipModalTextColor']),
          tipModalBgColor: int.parse(themeJson['tipModalBgColor']),
          settingItemBgColor: int.parse(themeJson['settingItemBgColor']),
          textColor: int.parse(themeJson['textColor']),
          shadowColor: int.parse(themeJson['shadowColor']),
          textFieldCursorColor: int.parse(themeJson['textFieldCursorColor']),
          selectedColor: int.parse(themeJson['selectedColor']),
        );
      } catch (e) {
        print("当前设置的主题文件已损坏！即将恢复默认设置2");
      }
    } else {
      print("没有进入负值");
    }
    initTheme = currentTheme ?? AllThemes().sysDefaultThemes[0];
    if (_themeBloc.currentState.theme == null) {
      _themeBloc.dispatch(ToggleTheme(
        theme: initTheme,
        currentUser: User(account: userAccount),
      ));
    }
  }

  _renderServerList() {
    List<Widget> list = List();
    list.add(
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "手动输入：http://192.168.",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10),
              width: 50,
              height: 38,
              child: TextField(
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  labelText: '后两位ip',
                ),
              ),
            ),
            ClipRect(
              child: FlatButton(
                color: Colors.blue,
                child: Text(
                  "确认",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
    ServerAddresses.ipList.forEach(
      (item) {
        int index = ServerAddresses.ipList.indexOf(item);
        print("_selectedServerIndex:$_selectedServerIndex,当前索引：$index");
        list
          ..add(
            FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () async {
                  _toggleServer(index);
                  setState(() {
                    _selectedServerIndex = index;
                  });
                  Navigator.of(context).pop();
                  File file =
                      await Utils.getLocalFile(filename: FileNames.serverIp);
                  Utils.writeContentTofile(file, item);
                  Utils.showTip(
                    context: context,
                    tipText: "服务器已切换到http://192.168.$item",
                    duration: 800,
                  );
                },
                child: Container(
                  padding:
                      EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: _selectedServerIndex == index
                        ? Colors.blue
                        : Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "http://192.168.$item",
                        style: TextStyle(
                          fontSize: 18,
                          color: _selectedServerIndex == index
                              ? Colors.white
                              : Colors.black54,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )),
          );
      },
    );
    return list;
  }

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    _messageBloc = BlocProvider.of<MessageBloc>(context);
    _webSocketBloc = BlocProvider.of<WebSocketBloc>(context);

    print("准备清空数据");
    _messageBloc.dispatch(ClearMessageState());
    return BlocBuilder(
      bloc: _authBloc,
      builder: (BuildContext context, AuthState _authState) {
        List<Widget> list = List();
        list.add(Center(
          child: SingleChildScrollView(
            child: Container(
              height: Utils.getScreenSize().height,
              padding: EdgeInsets.only(
                  left: 15, right: 15, bottom: 15), //设置4边padding为15
              child: new Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                //类似于flax布局,主轴方向上居中
                crossAxisAlignment: CrossAxisAlignment.center,
                //侧轴方向居中
                children: <Widget>[
//                  头像
                  Header(
                    width: 100.00,
                    height: 100.00,
                    imgSrc:
                        'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1177105977,3340879911&fm=26&gp=0.jpg',
                    isMan: true,
                  ),
                  //帐号输入框
                  new Container(
//                    color: Colors.pinkAccent,
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: new TextField(
                      controller: userNameController,
                      cursorColor: Color.fromRGBO(150, 150, 150, 0),
                      //设置光标颜色
                      cursorWidth: 1.5,
                      //设置光标宽度
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        focusColor: Colors.redAccent,
                        hintText: '用户名 / 手机号 / 邮箱',
                        contentPadding: EdgeInsets.only(left: 45, top: 10),
                        suffixIcon: Icon(Icons.expand_more),
                        hintStyle: textStyle,
                        //未获取焦点时的边框样式
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        //获取焦点时的边框样式
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.9),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //密码输入框
                  new Container(
//                    color: Colors.blue,
                    margin: EdgeInsets.only(top: 1, bottom: 10),
                    child: new TextField(
                      controller: passwordController,
                      //设置光标颜色
                      cursorColor: Colors.black38,
                      //设置光标宽度
                      textAlign: TextAlign.center,
                      cursorWidth: 1.5,
                      decoration: InputDecoration(
                        hintText: '密 码',
                        contentPadding: EdgeInsets.only(left: 45, top: 10),
                        suffixIcon: Icon(Icons.remove_red_eye),
                        hintStyle: textStyle,
                        //未获取焦点时的边框样式
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        //获取焦点时的边框样式
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.9),
                            width: 1,
                          ),
                        ),
                      ),
                      obscureText: true,
                      //设置文本框是否隐藏
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  //登录按钮
                  Container(
                    margin: EdgeInsets.only(
                        left: 45, right: 45, top: 15, bottom: 20),
                    child: CupertinoButton(
                      padding: EdgeInsets.only(
                        top: 5,
                        left: 65,
                        right: 65,
                        bottom: 5,
                      ),
                      color: Colors.blue,
                      onPressed: () => _login(_authBloc, context),
                      child: Text("  登    录  "),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 45, right: 45),
                    child: CupertinoButton(
                      padding: EdgeInsets.only(
                        top: 5,
                        left: 65,
                        right: 65,
                        bottom: 5,
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.of(context).pushNamed("/register");
                      },
                      child: Text("注册账号"),
                    ),
                  ),
                  //【忘记密码、注册用户】
                  Container(
                    child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        "忘记密码?",
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                    ),
                  ),
                  UnconstrainedBox(
                    child: FlatButton(
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.swap_vert, color: Colors.black38),
                            Text(
                              "切换服务器",
                              style: TextStyle(color: Colors.black38),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Stack(
                                alignment: Alignment.topCenter,
                                children: <Widget>[
                                  //背景蒙层背景色
                                  Container(
                                    color: Colors.black54,
                                  ),
                                  //标题
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.only(
                                      left: Utils.getScreenSize().width * 0.020,
                                      right:
                                          Utils.getScreenSize().width * 0.020,
                                      bottom: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "服务器切换",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  //滚动区域
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: Utils.getScreenSize().width * 0.020,
                                      right:
                                          Utils.getScreenSize().width * 0.020,
                                      bottom: 10,
                                      top: 43,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                    ),
                                    child: CupertinoScrollbar(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: _renderServerList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
        return Scaffold(
          body: Stack(
            children: list,
          ),
        );
      },
    );
  }
}
