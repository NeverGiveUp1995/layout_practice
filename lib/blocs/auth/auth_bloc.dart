import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:layout_practice/modals/ReseponseData/response_data_entity.dart';
import 'package:layout_practice/modals/login_modal/login_entity.dart';
import 'package:layout_practice/utils/Utils.dart';
import 'package:layout_practice/utils/request.dart';
import './bloc.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  @override
  AuthState get initialState => UserState(
        user: null,
        loggedIn: false,
      );

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is LoginEvent) {
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
        //关闭加载动画
        Utils.loading(event.buildContext, false);
        if (loginEntity.status == "1" || loginEntity.status == 1) {
          if (loginEntity.data != null) {
            print("用户信息：：：：${loginEntity.data.nickName}");
            Utils.showTip(
              context: event.buildContext,
              duration: 300,
              tipText: loginEntity.tip != null ? loginEntity.tip : '登录异常！',
              callback: () {
                Navigator.pushReplacementNamed(event.buildContext, '/home');
              },
            );
            yield UserState(
              user: loginEntity.data,
              loggedIn: true,
            );
          } else {
            Utils.showTip(
              context: event.buildContext,
              tipText: loginEntity.tip != null ? loginEntity.tip : '登录异常！',
            );
            yield UserState(
              user: null,
              loggedIn: false,
            );
            print('登录失败！');
          }
        } else {
//              status状态码为0（请求成功，但是不符合业务逻辑）
          if (loginEntity.tip != null) {
            Utils.showTip(
              context: event.buildContext,
              tipText: loginEntity.tip != null ? loginEntity.tip : '登录异常！',
            );
            yield UserState(
              user: null,
              loggedIn: false,
              message: loginEntity.tip,
            );
            print("${loginEntity.tip}");
          } else {
            Utils.showTip(
              context: event.buildContext,
              tipText: loginEntity.tip != null ? loginEntity.tip : '登录异常！',
            );
            yield UserState(
              user: null,
              loggedIn: false,
            );
            print("服务器正忙！稍后重试（status：${loginEntity.status}）");
          }
        }
      } else {
        print("请求失败！");
      }
    }
    if (event is CheckAccount) {
      NetServer.request(
        api: "/user/getUserByUserAccount",
        method: 'post',
        params: {
          "userAccount": event.account,
        },
        callback: event.callback,
      );
    }
    if (event is CheckPhoneNum) {
      NetServer.request(
        api: "/user/getUserByPhoneNum",
        method: 'post',
        params: {
          "phoneNum": event.phoneNum,
        },
        callback: event.callback,
      );
    }
    if (event is RegisterEvent) {
      Utils.loading(event.context, true);
      Response response = await NetServer.request(
        api: "/user/register",
        method: 'post',
        params: {
          "userAccount": event.userAccount,
          "password": event.password,
          "nickName": event.nickName,
          "phoneNum": event.phoneNum,
          "email": event.email,
          "gender": event.gender,
        },
//        callback: event.callback,
      );
      print("获取到数据1：${response.data}");

      if (response != null) {
//        关闭加载动画
        Utils.loading(event.context, false);
        ResponseDataEntity responseDataEntity =
            ResponseDataEntity.fromJson(json.decode(response.toString()));
        print(responseDataEntity.tip);
        if (responseDataEntity.status == "1") {
          Utils.showTip(
              context: event.context,
              tipText: responseDataEntity.tip,
              duration: 800);
        }
        if (responseDataEntity.status == "0") {
          Utils.showTip(
              context: event.context, tipText: "请求错误！", duration: 800);
        }
      }
    }
  }
}
