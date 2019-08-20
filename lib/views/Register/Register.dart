import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';
import 'package:layout_practice/modals/ReseponseData/response_data_entity.dart';
/**
 * 【用户注册】
 * */

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthBloc _authBloc;

  String _sexValue = "1";
  TextEditingController accountController =
      TextEditingController(); //用户账号编辑框控制器
  TextEditingController passwordController = TextEditingController(); //密码编辑框控制器
  TextEditingController confirmPsdController =
      TextEditingController(); //确认密码编辑框控制器
  TextEditingController nickNameController = TextEditingController(); //昵称编辑框控制器
  TextEditingController phoneNumController = TextEditingController(); //电话编辑框控制器
  TextEditingController emailController = TextEditingController(); //邮箱编辑框控制器

  FocusNode _accountFocusNode = FocusNode(); //账号输入框判断是否获取焦点的对象
  FocusNode _passwordFocusNode = FocusNode(); //密码输入框判断是否获取焦点的对象
  FocusNode _confirmPsdFocusNode = FocusNode(); //确认密码输入框判断是否获取焦点的对象
  FocusNode _nickNameFocusNode = FocusNode(); //昵称输入框判断是否获取焦点的对象
  FocusNode _phoneNumFocusNode = FocusNode(); //电话输入框判断是否获取焦点的对象
  FocusNode _emailFocusNode = FocusNode(); //邮箱输入框判断是否获取焦点的对象
  var _accountTip = {
    "tipText": "",
    "textColor": null,
    "passState": false
  }; //账号的提示控制数据
  var _passwordTip = {
    "tipText": "",
    "textColor": null,
    "passState": false
  }; //密码的提示文本
  var _confirmPsdTip = {
    "tipText": "",
    "textColor": null,
    "passState": false
  }; //密码的提示文本
  var _nickNameTip = {
    "tipText": "",
    "textColor": null,
    "passState": false
  }; //昵称提示文本
  var _phoneNumTip = {
    "tipText": "",
    "textColor": null,
    "passState": false
  }; //电话提示文本
  var _emailTip = {
    "tipText": "",
    "textColor": null,
    "passState": true, //邮箱默认为true，因为是非必填项，所以只要过滤掉输入邮箱账号之后，邮箱账号不合理的时候设置为false就行了
  }; //邮箱提示文本

  @override
  initState() {
    //账号输入框焦点监听事件
    _accountFocusNode.addListener(() {
      if (_accountFocusNode.hasFocus) {
        setState(() {
          _accountTip['tipText'] = '账号必须为6-12位，且不能包含特殊字符，区分大小写';
          _accountTip['textColor'] = Colors.black12;
          _accountTip['passState'] = false;
        });
      } else {
        if (_accountTip['passState']) {
          setState(() {
            _accountTip['tipText'] = '';
            _accountTip['textColor'] = Colors.black12;
          });
        }
      }
    });
    //密码输入框焦点监听事件
    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) {
        setState(() {
          _passwordTip['tipText'] = '密码必须为6-12位，且不能包含特殊字符，区分大小写';
          _passwordTip['textColor'] = Colors.black12;
          _passwordTip['passState'] = false;
        });
      } else {
        if (_passwordTip['passState']) {
          setState(() {
            _passwordTip['tipText'] = '';
            _passwordTip['textColor'] = Colors.black12;
          });
        }
      }
    });
    //确认密码输入框焦点监听事件
    _confirmPsdFocusNode.addListener(() {
      if (!_confirmPsdFocusNode.hasFocus) {
        //如果密码不相同
        if (confirmPsdController.text != passwordController.text &&
            passwordController.text.length > 0) {
          setState(() {
            _confirmPsdTip['tipText'] = '两次密码不相同！';
            _confirmPsdTip['textColor'] = Colors.redAccent;
            _confirmPsdTip['passState'] = false;
          });
        } else {
          setState(() {
            _confirmPsdTip['tipText'] = '';
            _confirmPsdTip['textColor'] = Colors.black12;
            _confirmPsdTip['passState'] = true;
          });
        }
      }
    });
    //昵称输入框焦点监听事件
    _nickNameFocusNode.addListener(() {
      if (_nickNameFocusNode.hasFocus) {
        setState(() {
          _nickNameTip['tipText'] = '昵称为2-8个字符';
          _nickNameTip['textColor'] = Colors.black12;
          _nickNameTip['passState'] = false;
        });
      } else {
        if (nickNameController.text.length > 0) {
          if (_nickNameTip['passState']) {
            setState(() {
              _nickNameTip['tipText'] = '';
              _nickNameTip['textColor'] = Colors.black12;
            });
          } else {
            setState(() {
              _nickNameTip['tipText'] = '当前昵称不可用';
              _nickNameTip['textColor'] = Colors.redAccent;
              _nickNameTip['passState'] = false;
            });
          }
        } else {
          setState(() {
            _nickNameTip['tipText'] = '请输入昵称';
            _nickNameTip['textColor'] = Colors.redAccent;
            _nickNameTip['passState'] = false;
          });
        }
      }
    });
    //手机号输入框焦点监听事件
    _phoneNumFocusNode.addListener(() {
      if (_phoneNumFocusNode.hasFocus) {
        setState(() {
          _phoneNumTip['tipText'] = '请输入11位手机号码';
          _phoneNumTip['textColor'] = Colors.black12;
        });
      } else {
        if (phoneNumController.text.length > 0) {
          if (_phoneNumTip['passState']) {
            setState(() {
              _phoneNumTip['tipText'] = '';
              _phoneNumTip['textColor'] = Colors.black12;
              _phoneNumTip['passState'] = true;
            });
          } else {
            setState(() {
              _phoneNumTip['tipText'] = '请输入正确的手机号';
              _phoneNumTip['textColor'] = Colors.redAccent;
              _phoneNumTip['passState'] = false;
            });
          }
        } else {}
      }
    });
    //邮箱输入框焦点监听事件【非必填】
    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
        setState(() {
          _emailTip['tipText'] = '邮箱格式如：xxxxxxxxxxx@163.com、xxxxxxxxxxx@qq.com';
          _emailTip['textColor'] = Colors.black12;
          _emailTip['passState'] = false;
        });
      } else {
        setState(() {
          _emailTip['tipText'] = '';
          _emailTip['textColor'] = Colors.black12;
        });
      }
    });
  }

//账号输入框发生变化时回调
  _accountChanged(String value) {
    if (value.length > 0) {
      RegExp accountReg = RegExp(r'^[a-z0-9_-]{6,12}$');
      if (accountReg.hasMatch(value)) {
        _authBloc.dispatch(CheckAccount(
          account: value,
          context: context,
          callback: (response) {
            print("验证用户的数据：$response");
            //通过的情况
            if (response != null) {
              ResponseDataEntity responseDataEntity =
                  ResponseDataEntity.fromJson(json.decode(response.toString()));
              if (responseDataEntity.data != null) {
                setState(() {
                  _accountTip['tipText'] = "账号已存在！";
                  _accountTip['textColor'] = Colors.redAccent;
                  _accountTip['passState'] = false;
                });
              } else {
                setState(() {
                  _accountTip['tipText'] = '';
                  _accountTip['textColor'] = Color.fromARGB(100, 49, 194, 124);
                  _accountTip['passState'] = true;
                });
              }
            }
          },
        ));
      } else {
        setState(() {
          _accountTip['tipText'] = '密码必须为以字母、数字、下划线、开头的6-12字符组成，区分大小写';
          _accountTip['textColor'] = Colors.redAccent;
          _accountTip['passState'] = false;
        });
      }
    } else {
      setState(() {
        _accountTip['tipText'] = '账号不能为空';
        _accountTip['textColor'] = Colors.redAccent;
        _accountTip['passState'] = false;
      });
    }
  }

//密码输入框发生变化时回调
  _passwordChanged(String value) {
    if (value.length > 0) {
      RegExp passwordReg = RegExp(r'^[a-z0-9_-]{6,16}$');
      if (passwordReg.hasMatch(value)) {
        //通过的情况
        setState(() {
          _passwordTip['tipText'] = '';
          _passwordTip['textColor'] = Colors.black12;
          _passwordTip['passState'] = true;
        });
      } else {
        setState(() {
          _passwordTip['tipText'] = '密码必须为以字母、数字、下划线、开头的6-16字符组成，区分大小写';
          _passwordTip['textColor'] = Colors.redAccent;
          _passwordTip['passState'] = false;
        });
      }
    } else {
      setState(() {
        _passwordTip['tipText'] = '密码不能为空';
        _passwordTip['textColor'] = Colors.redAccent;
        _passwordTip['passState'] = false;
      });
    }
  }

//  昵称输入框发生变化回调
  _nickNameChanged(String value) {
    if (value.length > 0) {
      if (value.length > 2 && value.length < 8) {
        //通过的情况
        setState(() {
          _nickNameTip['tipText'] = '';
          _nickNameTip['textColor'] = Colors.black12;
          _nickNameTip['passState'] = true;
        });
      } else {
        setState(() {
          _nickNameTip['tipText'] = '昵称必须2-8个字符';
          _nickNameTip['textColor'] = Colors.redAccent;
          _nickNameTip['passState'] = false;
        });
      }
    } else {
      setState(() {
        _nickNameTip['tipText'] = '昵称不能为空';
        _nickNameTip['textColor'] = Colors.redAccent;
        _nickNameTip['passState'] = false;
      });
    }
  }

//  手机号输入框发生变化回调
  _phoneNumChanged(String value) {
    RegExp phoneRegExp = RegExp(r'^1([38]\d|5[0-35-9]|7[3678])\d{8}$');
    if (value.length > 0) {
      if (phoneRegExp.hasMatch(value)) {
        _authBloc.dispatch(CheckPhoneNum(
          phoneNum: value,
          context: context,
          callback: (response) {
            print("验证用户的数据：$response");
            //通过的情况
            if (response != null) {
              ResponseDataEntity responseDataEntity =
                  ResponseDataEntity.fromJson(json.decode(response.toString()));
              if (responseDataEntity.data != null) {
                setState(() {
                  _phoneNumTip['tipText'] = "该手机号已被绑定！";
                  _phoneNumTip['textColor'] = Colors.redAccent;
                  _phoneNumTip['passState'] = false;
                });
              } else {
                setState(() {
                  _phoneNumTip['tipText'] = '';
                  _phoneNumTip['textColor'] = Color.fromARGB(100, 49, 194, 124);
                  _phoneNumTip['passState'] = true;
                });
              }
            }
          },
        ));
        //通过的情况
        setState(() {
          _phoneNumTip['tipText'] = '';
          _phoneNumTip['textColor'] = Colors.black12;
          _phoneNumTip['passState'] = true;
        });
      } else {
        setState(() {
          _phoneNumTip['tipText'] = '您输入的不是一个正常的手机号码';
          _phoneNumTip['textColor'] = Colors.redAccent;
          _phoneNumTip['passState'] = false;
        });
      }
    } else {
      setState(() {
        _phoneNumTip['tipText'] = '手机号不能为空';
        _phoneNumTip['textColor'] = Colors.redAccent;
        _phoneNumTip['passState'] = false;
      });
    }
  }

//邮箱输入框变化回调
  _emailChanged(String value) {
    RegExp emailRegExp =
        RegExp(r'^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$');
    if (value.length > 0) {
      if (emailRegExp.hasMatch(value)) {
        //通过的情况
        setState(() {
          _emailTip['tipText'] = '';
          _emailTip['textColor'] = Colors.black12;
          _emailTip['passState'] = true;
        });
      } else {
        setState(() {
          _emailTip['tipText'] = '邮箱格式有误';
          _emailTip['textColor'] = Colors.redAccent;
          _emailTip['passState'] = false;
        });
      }
    }
  }

  _onRegister(AuthBloc _authBloc) {
    String account = accountController.text;
    String password = passwordController.text;
    String nickName = nickNameController.text;
    String phoneNum = phoneNumController.text;
    String email = emailController.text;
    String gender = _sexValue;
    if (_accountTip['passState'] &&
        _passwordTip['passState'] &&
        _confirmPsdTip['passState'] &&
        _nickNameTip['passState'] &&
        _phoneNumTip['passState']) {
      _authBloc.dispatch(RegisterEvent(
        context: context,
        userAccount: account,
        password: password,
        nickName: nickName,
        phoneNum: phoneNum,
        email: email,
        gender: gender,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocBuilder(
      bloc: _authBloc,
      builder: (BuildContext context, AuthState authState) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(250, 250, 250, 1),
            centerTitle: true,
            title: Text(
              "用户注册",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            elevation: .5,
          ),
          body: CupertinoScrollbar(
            child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              margin: EdgeInsets.only(bottom: 5),
                              height: 50,
                              decoration: BoxDecoration(
                                border: BorderDirectional(
                                    bottom: BorderSide(width: 1)),
                              ),
                              child: TextField(
                                focusNode: _accountFocusNode,
                                onChanged: _accountChanged,
                                controller: accountController,
                                decoration: InputDecoration(
                                  suffixIcon: _accountTip['passState'] == true
                                      ? Icon(
                                          Icons.check_circle_outline,
                                          color:
                                              Color.fromARGB(100, 49, 194, 124),
                                        )
                                      : null,
                                  hintText: "请填写账号",
                                  contentPadding: EdgeInsets.only(
                                    left: 0,
                                    right: 15,
                                    top: 20,
                                    bottom: 5,
                                  ),
                                  icon:
                                      Icon(Icons.person, color: Colors.black54),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 55),
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: Text(
                                _accountTip['tipText'],
                                style:
                                    TextStyle(color: _accountTip['textColor']),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                margin: EdgeInsets.only(bottom: 5),
                                height: 50,
                                decoration: BoxDecoration(
                                  border: BorderDirectional(
                                      bottom: BorderSide(width: 1)),
                                ),
                                child: TextField(
                                  obscureText: true,
                                  focusNode: _passwordFocusNode,
                                  controller: passwordController,
                                  onChanged: _passwordChanged,
                                  decoration: InputDecoration(
                                    suffixIcon:
                                        _passwordTip['passState'] == true
                                            ? Icon(
                                                Icons.check_circle_outline,
                                                color: Color.fromARGB(
                                                    100, 49, 194, 124),
                                              )
                                            : null,
                                    hintText: "密码",
                                    contentPadding: EdgeInsets.only(
                                      left: 0,
                                      right: 15,
                                      top: 20,
                                      bottom: 5,
                                    ),
                                    icon: Icon(Icons.vpn_key,
                                        color: Colors.black54),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                )),
                            Container(
                              padding: EdgeInsets.only(left: 55),
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: Text(
                                _passwordTip['tipText'],
                                style:
                                    TextStyle(color: _passwordTip['textColor']),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                margin: EdgeInsets.only(bottom: 5),
                                height: 50,
                                decoration: BoxDecoration(
                                  border: BorderDirectional(
                                      bottom: BorderSide(width: 1)),
                                ),
                                child: TextField(
                                  focusNode: _confirmPsdFocusNode,
                                  controller: confirmPsdController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    suffixIcon:
                                        _confirmPsdTip['passState'] == true
                                            ? Icon(
                                                Icons.check_circle_outline,
                                                color: Color.fromARGB(
                                                    100, 49, 194, 124),
                                              )
                                            : null,
                                    hintText: "确认密码",
                                    contentPadding: EdgeInsets.only(
                                      left: 0,
                                      right: 15,
                                      top: 20,
                                      bottom: 5,
                                    ),
                                    icon: Icon(Icons.vpn_key,
                                        color: Colors.black54),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                )),
                            Container(
                              padding: EdgeInsets.only(left: 5),
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: Text(
                                _confirmPsdTip['tipText'],
                                style: TextStyle(
                                    color: _confirmPsdTip['textColor']),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                margin: EdgeInsets.only(bottom: 5),
                                height: 50,
                                decoration: BoxDecoration(
                                  border: BorderDirectional(
                                      bottom: BorderSide(width: 1)),
                                ),
                                child: TextField(
                                  focusNode: _nickNameFocusNode,
                                  controller: nickNameController,
                                  onChanged: _nickNameChanged,
                                  decoration: InputDecoration(
                                    suffixIcon:
                                        _nickNameTip['passState'] == true
                                            ? Icon(
                                                Icons.check_circle_outline,
                                                color: Color.fromARGB(
                                                    100, 49, 194, 124),
                                              )
                                            : null,
                                    hintText: "昵称",
                                    contentPadding: EdgeInsets.only(
                                      left: 0,
                                      right: 15,
                                      top: 20,
                                      bottom: 5,
                                    ),
                                    icon: Icon(Icons.recent_actors,
                                        color: Colors.black54),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                )),
                            Container(
                              padding: EdgeInsets.only(left: 55),
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: Text(
                                _nickNameTip['tipText'],
                                style:
                                    TextStyle(color: _nickNameTip['textColor']),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                margin: EdgeInsets.only(bottom: 5),
                                height: 50,
                                decoration: BoxDecoration(
                                  border: BorderDirectional(
                                      bottom: BorderSide(width: 1)),
                                ),
                                child: TextField(
                                  focusNode: _phoneNumFocusNode,
                                  controller: phoneNumController,
                                  onChanged: _phoneNumChanged,
                                  decoration: InputDecoration(
                                    suffixIcon:
                                        _phoneNumTip['passState'] == true
                                            ? Icon(
                                                Icons.check_circle_outline,
                                                color: Color.fromARGB(
                                                    100, 49, 194, 124),
                                              )
                                            : null,
                                    hintText: "手机号",
                                    contentPadding: EdgeInsets.only(
                                      left: 0,
                                      right: 15,
                                      top: 20,
                                      bottom: 5,
                                    ),
                                    icon: Icon(Icons.phone_android,
                                        color: Colors.black54),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                )),
                            Container(
                              padding: EdgeInsets.only(left: 55),
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: Text(
                                _phoneNumTip['tipText'],
                                style:
                                    TextStyle(color: _phoneNumTip['textColor']),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                margin: EdgeInsets.only(bottom: 5),
                                height: 50,
                                decoration: BoxDecoration(
                                  border: BorderDirectional(
                                      bottom: BorderSide(width: 1)),
                                ),
                                child: TextField(
                                  focusNode: _emailFocusNode,
                                  controller: emailController,
                                  onChanged: _emailChanged,
                                  decoration: InputDecoration(
                                    hintText: "邮箱",
                                    contentPadding: EdgeInsets.only(
                                      left: 0,
                                      right: 15,
                                      top: 20,
                                      bottom: 5,
                                    ),
                                    icon: Icon(Icons.email,
                                        color: Colors.black54),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                )),
                            Container(
                              padding: EdgeInsets.only(left: 55),
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: Text(
                                _emailTip['tipText'],
                                style: TextStyle(color: _emailTip['textColor']),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 25),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: RadioListTile(
                                groupValue: _sexValue,
                                title: Text("男"),
                                value: "1",
                                onChanged: (Object value) {
                                  this.setState(() {
                                    _sexValue = value;
                                  });
                                },
                              ),
                            ),
                            Flexible(
                              child: RadioListTile(
                                groupValue: _sexValue,
                                title: Text("女"),
                                value: "2",
                                onChanged: (Object value) {
                                  this.setState(() {
                                    _sexValue = value;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: CupertinoButton(
                          child: Text("立即注册"),
                          onPressed: () {
                            _onRegister(_authBloc);
                          },
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }
}
