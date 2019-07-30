import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  double _width = 100;
  double _height = 100;
  String _imgSrc = null;
  bool _isMan = true;
  double _borderWidth = 0.0;
  Color _borderColor;

  Header({
    @required width,
    @required height,
    @required imgSrc,
    isMan,
    borderWidth,
    borderColor,
  }) {
    this._width = width;
    this._height = height;
    this._imgSrc = imgSrc;
    if (isMan == null) {
      this._isMan = true;
    } else {
      this._isMan = isMan;
    }
    if (borderWidth == null) {
      this._borderWidth = 0.0;
    } else {
      this._borderWidth = borderWidth;
    }
    if (borderColor == null) {
      this._borderColor = Colors.white;
    } else {
      this._borderColor = borderColor;
    }
  }

  @override
  State<StatefulWidget> createState() {
    return _Header(
      width: _width,
      height: _height,
      imgSrc: _imgSrc,
      isMan: _isMan,
      borderWidth: _borderWidth,
      borderColor: _borderColor,
    );
  }
}

class _Header extends State<Header> {
  double _width = 100;
  double _height = 100;
  String _imgSrc = "";
  bool _isMan = true;
  Color _borderColor = Colors.white;
  double _borderWidth = 0.0;

  _Header({
    @required width,
    @required height,
    @required imgSrc,
    isMan,
    borderWidth,
    borderColor,
  }) {
    this._width = width;
    this._height = height;
    this._imgSrc = imgSrc;
    this._isMan = isMan;
    this._borderWidth = borderWidth;
    this._borderColor = borderColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      padding: EdgeInsets.all(8.00),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(_width)),
        border: Border.all(
          color: _borderColor,
          width: _borderWidth,
          style: BorderStyle.solid,
        ),
      ),
      child: ClipOval(
        child: RenderHeaderImg(
          imgSrc: _imgSrc,
          isMan: _isMan,
        ),
      ),
    );
  }
}

class RenderHeaderImg extends StatefulWidget {
  String _imgSrc;
  bool _isMan;

  /*
   * 构造器
   * @imgSrc:头像地址
   * @isMan：是否是男性
   */
  RenderHeaderImg({imgSrc, isMan}) {
    this._imgSrc = imgSrc;
    this._isMan = isMan;
  }

  @override
  State<StatefulWidget> createState() {
    return _RenderHeaderImg(imgSrc: _imgSrc, isMan: _isMan);
  }
}

class _RenderHeaderImg extends State<RenderHeaderImg> {
  String _imgSrc;
  bool _isMan = true;

  /*
   * 构造器
   * @imgSrc:头像地址
   * @isMan：是否是男性
   */
  _RenderHeaderImg({imgSrc, isMan}) {
    this._imgSrc = imgSrc;
    if (isMan == null) {
      this._isMan = true;
    } else {
      this._isMan = isMan;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_imgSrc == null) {
      if (_isMan == null || _isMan) {
        return Image.asset(
          "images/headerImg-man.png",
          fit: BoxFit.cover,
        );
      } else {
        return Image.asset(
          "images/headerImg-women.png",
          fit: BoxFit.cover,
        );
      }
    } else {
      Image image;
      try {
        image = Image.network(
          _imgSrc,
          fit: BoxFit.cover,
        );
      } catch (e) {
        print("记得处理头像组件图片获取的异常");
      }
      return image;
    }
  }
}
