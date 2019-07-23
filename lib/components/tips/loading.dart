import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:layout_practice/components/logo/logo.dart';
import 'dart:math' as math;

import 'package:layout_practice/config/my_flutter_app_icons.dart';

class Loading extends StatefulWidget {
  String _tipText = "加载中...";
  Icon _icon = Icon(MyFlutterIcons.spin6); //显示的图标，默认为loading的
  bool _iconRotate = true;
  Theme theme = null;

  Loading({tipText, icon, iconRotate, timeOutOfClose}) {
    this._tipText = tipText;
    this._icon = icon;
    this._iconRotate = iconRotate;
  }

  @override
  _LoadingState createState() => _LoadingState(
      tipText: this._tipText, icon: this._icon, iconRotate: this._iconRotate);
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  String _tipText = "加载中...";
  Icon _icon = Icon(MyFlutterIcons.spin6); //显示的图标，默认为loading的
  bool _iconRotate = true;

  _LoadingState({tipText, icon, iconRotate}) {
    this._tipText = tipText;
    this._icon = icon;
    this._iconRotate = iconRotate;
  }

  AnimationController _animationRorateController; //定义动画控制器
  CurvedAnimation curved; //曲线动画，动画插值，

  @override
  void initState() {
    super.initState();
    double upperBound = 2 * math.pi;
    if (_iconRotate == false) {
      upperBound = 1.0;
    }
    _animationRorateController = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: upperBound,
      duration: Duration(milliseconds: 1000),
    );
//  添加动画值在变化是的监听函数，通过setState修改值，从而进行动画
    _animationRorateController.addListener(() {
      setState(() {});
    });
    _animationRorateController.addStatusListener((AnimationStatus status) {
//      当动画完成一次时，重复执行（无限循环播放）
      if (_animationRorateController.status == AnimationStatus.completed) {
        _animationRorateController.repeat();
      }
      print("$status");
    });
//    初始化时，开启动画
    _animationRorateController.forward();
  }

  @override
  void dispose() {
//    组件销毁的同时，将动画一起销毁
    _animationRorateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0),
      body: Center(
        child: Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(5.0),
          ),
//          padding: EdgeInsets.fromLTRB(80, 50, 80, 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform.rotate(
                angle: _iconRotate ? _animationRorateController.value : 0,
                child: _icon,
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  _tipText,
                  style: TextStyle(
                    fontSize: 14,
//                    color: Color.fromRGBO(240, 240, 240, 0.8),
                    color: Colors.blue,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
