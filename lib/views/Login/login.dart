import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:layout_practice/blocs/auth/auth_bloc.dart';
import 'package:layout_practice/components/Header/Header.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';
import 'package:layout_practice/components/tips/loading.dart';
import 'package:layout_practice/config/my_flutter_app_icons.dart';

class Login extends StatelessWidget {
  final GlobalKey _key = GlobalKey();
  AuthBloc _authBloc;
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

  @override
  void didUpdateWidget(Login oldWidget) {
    print("bloc状态===》${oldWidget._authBloc.currentState.loggedIn}");
  }

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
    authBloc.dispatch(LoginEvent(
        buildContext, userNameController.text, passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    Loading loading = null;
    _authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: BlocBuilder(
        bloc: _authBloc,
        builder: (BuildContext context, AuthState _currentState) {
          List<Widget> list = List();
          list.add(Scaffold(
              appBar: null,
              body: Center(
                child: Container(
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
                            hintText: '用户名 / 手机号 / 邮箱',
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
                      new Container(
                        padding: EdgeInsets.only(
                            left: 15, top: 5, right: 15, bottom: 5),
                        margin: EdgeInsets.only(top: 10),
                        height: 50,
                        width: 500,
                        child: new RaisedButton(
                          color: Colors.white,
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 5, bottom: 5),
                          textColor: Colors.grey,
                          child: new Text("登 录"),
                          onPressed: () => _login(_authBloc, context),
                        ),
                      ),
                    ],
                  ),
                ),
              )));
          print(
              "_authBloc.currentState.loading:${_authBloc.currentState.loading}");
          if (_authBloc.currentState.loading == true) {
            loading = Loading(
              icon: Icon(
                MyFlutterIcons.spin6,
                color: Colors.blue,
                size: 37,
              ),
              iconRotate: true,
              tipText: "正在登录...",
            );
            list.add(loading);
          } else {
            if (_authBloc.currentState.loggedIn == true) {
              loading = Loading(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.blue,
                  size: 37,
                ),
                iconRotate: false,
                tipText: "登录成功！",
              );
            } else {
              loading = Loading(
                icon: Icon(
                  Icons.error,
                  color: Colors.blue,
                  size: 37,
                ),
                iconRotate: false,
                tipText: _authBloc.currentState.message == null
                    ? "登录失败！"
                    : _authBloc.currentState.message,
              );
            }
          }
          return Stack(
            children: list,
          );
        },
      ),
    );
  }
}
