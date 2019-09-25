import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  dynamic _width = 100;
  dynamic _height = 100;
  String _imgSrc = null;
  bool _isMan = true;
  dynamic _borderWidth = 0.0;
  Color _borderColor;
  dynamic _padding = 0.0;
  Function onClick; //头像点击回调
  Header(
      {@required width,
      @required height,
      @required imgSrc,
      isMan,
      borderWidth,
      borderColor,
      onClick,
      padding}) {
    this._imgSrc = imgSrc;
    if (width != null) {
      this._width = width * 1.0;
    }
    if (height != null) {
      this._height = height * 1.0;
    }
    if (isMan == null) {
      this._isMan = true;
    } else {
      this._isMan = isMan;
    }
    if (borderWidth != null) {
      this._borderWidth = borderWidth * 1.0;
    }
    if (borderColor == null) {
      this._borderColor = Colors.white;
    } else {
      this._borderColor = borderColor;
    }
    if (onClick != null) {
      this.onClick = onClick;
    }
    if (padding != null) {
      this._padding = padding * 1.0;
    }
  }

  @override
  State<StatefulWidget> createState() {
    return _Header();
  }
}

class _Header extends State<Header> {
  Color _borderColor = Colors.white;
  double _borderWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget._width,
      height: widget._height,
      padding: EdgeInsets.all(widget._padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(widget._width)),
        border: Border.all(
          color: widget._borderColor,
          width: widget._borderWidth,
          style: BorderStyle.solid,
        ),
      ),
      child: ClipOval(
        child: Stack(
          children: <Widget>[
            RenderHeaderImg(
              imgSrc: widget._imgSrc,
              isMan: widget._isMan,
            ),
            FlatButton(
              onPressed: widget.onClick,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}

class RenderHeaderImg extends StatefulWidget {
  String _imgSrc;
  bool _isMan = true;

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
    return _RenderHeaderImg();
  }
}

class _RenderHeaderImg extends State<RenderHeaderImg> {
  @override
  Widget build(BuildContext context) {
    if (widget._imgSrc == null) {
      if (widget._isMan) {
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
          widget._imgSrc,
          fit: BoxFit.cover,
        );
      } catch (e) {
        print("记得处理头像组件图片获取的异常");
      }
      return image;
    }
  }
}
