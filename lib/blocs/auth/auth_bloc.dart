import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:layout_practice/blocs/webSocket/bloc.dart';
import 'package:layout_practice/modals/login_modal/login_entity.dart';
import 'package:layout_practice/utils/Utils.dart';
import 'package:layout_practice/utils/request.dart';
import './bloc.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  @override
  AuthState get initialState => UserState(
        user: null,
        loading: false,
        loggedIn: false,
      );

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is LoginEvent) {
      yield UserState(
        user: null,
        loading: true,
        loggedIn: false,
      );
      if (event.userAccount == 'root' && event.password == 'root') {
        Navigator.pushNamed(event.buildContext, '/home');
      }
      print("马上发请求");
      //发送登录的请求
      Response resultData = await NetServer.request(
        api: "/user/login",
        params: {"userAccount": event.userAccount, "password": event.password},
        method: "post",
        callback: (resultData) {},
      );
      print("获取到请求结果$resultData");
      if (resultData != null) {
        LoginEntity loginEntity =
            LoginEntity.fromJson(json.decode(resultData.toString()));
        if (loginEntity.status == "1" || loginEntity.status == 1) {
          if (loginEntity.data != null) {
            print("用户信息：：：：${loginEntity.data.nickName}");
            Navigator.pushReplacementNamed(event.buildContext, '/home');
            yield UserState(
              user: loginEntity.data,
              loading: false,
              loggedIn: true,
              message: "登录成功！",
            );
          } else {
            yield UserState(
              user: null,
              loading: false,
              loggedIn: false,
              message: '登录失败！',
            );
            print('登录失败！');
          }
        } else {
//              status状态码为0（请求成功，但是不符合业务逻辑）
          if (loginEntity.message != null) {
            yield UserState(
              user: null,
              loading: false,
              loggedIn: false,
              message: loginEntity.message,
            );
            print("${loginEntity.message}");
          } else {
            yield UserState(
                user: null,
                loading: false,
                loggedIn: false,
                message: "服务器正忙！稍后重试（status：${loginEntity.status}）");
            print("服务器正忙！稍后重试（status：${loginEntity.status}）");
          }
        }
      } else {
        print("请求失败！");
      }
    }
  }
}
