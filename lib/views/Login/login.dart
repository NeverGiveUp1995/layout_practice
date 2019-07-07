import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:layout_practice/entities/utilBean/login_entity.dart';
import 'package:layout_practice/utils/request.dart';
import 'package:layout_practice/views/Home/Home.dart';
import 'package:layout_practice/components/Header/Header.dart';

class Login extends StatefulWidget {
  @override
  createState() => new LoginForm();
}

class LoginForm extends State<Login> {
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

  void _showDialog() {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('用户或密码错误'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('确定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((val) {
      print(val);
    });
  }

  //处理帐号变化回调,验证合法性
  void _login() {
    print(
      "userName:" +
          userNameController.text +
          "\n" +
          "password:" +
          passwordController.text,
    );
    RegExp exp = new RegExp("^1(3|4|5|7|8)\d{9}");
    print(exp.hasMatch(userNameController.text));
//    var userData = NetServer.request(
//        url: "/user/login",
//        data: {
//          "username": userNameController.text,
//          "password": passwordController.text
//        },
//        method: "post");
    var userData = NetServer.request(
      url:
          "http://192.168.1.21:8080/user/login?userAccount=${userNameController.text}&password=${passwordController.text}",
      callback: (data) {
        LoginEntity loginEntity =
            LoginEntity.fromJson(json.decode(data.toString()));
        print("用户信息：：：：${loginEntity.data}");
        if (loginEntity.data != null) {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new Home()),
          );
        } else {
          _showDialog();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: null,
          body: Center(
            child: Container(
              padding: EdgeInsets.only(
                  left: 15, right: 15, bottom: 15), //设置4边padding为15
              child: new Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center, //类似于flax布局,主轴方向上居中
                crossAxisAlignment: CrossAxisAlignment.center, //侧轴方向居中
                children: <Widget>[
//                  头像
                  Header(
                    width: 100.00,
                    height: 100.00,
                    imgSrc:
                        'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1177105977,3340879911&fm=26&gp=0.jpg',
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
                    padding:
                        EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 5),
                    margin: EdgeInsets.only(top: 10),
                    height: 50,
                    width: 500,
                    child: new RaisedButton(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      textColor: Colors.grey,
                      child: new Text("登 录"),
                      onPressed: _login,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
