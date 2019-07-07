import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  double width = 100;
  double height = 100;
  String imgSrc = null;

  Header({Key key, @required width, @required height, @required imgSrc}) {
    this.width = width;
    this.height = height;
    this.imgSrc = imgSrc;
  }

  @override
  Widget build(BuildContext context) {
    print(this.width);
    print(this.height);
    return Container(
      width: this.height,
      height: this.height,
      padding: EdgeInsets.all(8.00),
      child: ClipOval(
        child: SizedBox.expand(
          child: RenderHeaderImg(
            imgSrc: this.imgSrc,
          ),
        ),
      ),
    );
  }
}

class RenderHeaderImg extends StatelessWidget {
  String imgSrc;
  bool isMan;

  /*
   * 构造器
   * @imgSrc:头像地址
   * @isMan：是否是男性
   */
  RenderHeaderImg({imgSrc, isMan}) {
    this.imgSrc = imgSrc;
    this.isMan = isMan;
  }

  @override
  Widget build(BuildContext context) {
    if (imgSrc == null) {
      if (isMan) {
        return Image.asset("headerImg-man.svg");
      } else {
        return Image.asset("headerImg-women.png");
      }
    } else {
      return new Image.network(
        imgSrc,
      );
    }
  }
}
