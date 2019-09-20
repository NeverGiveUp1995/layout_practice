import 'package:flutter/cupertino.dart';

/**
 *【用户详情页】
 */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/auth/bloc.dart';
import 'package:layout_practice/blocs/friend/bloc.dart';
import 'package:layout_practice/blocs/theme/bloc.dart';
import 'package:layout_practice/components/BackBtn/BackBtn.dart';
import 'package:layout_practice/components/Header/Header.dart';
import 'package:layout_practice/modals/user/user_entity.dart';
import 'package:layout_practice/utils/Utils.dart';

class PersonalDetails extends StatefulWidget {
  String userAccount; //用户账号
  UserData user; //用户信息
  bool isFriend = false; //是否好友关系
  PersonalDetails(
      {@required this.userAccount, @required this.isFriend, this.user});

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  AuthBloc _authBloc;
  ThemeBloc _themeBloc;
  FriendBloc _friendBloc;
  BuildContext context;

  Color textColor = Color.fromARGB(255, 151, 158, 184); //文本文字颜色

  /**
   * 添加好友
   */
  addFriend(String activeUserAccount, BuildContext context) {
    String passiveUserAccount = null;
    if (widget.userAccount != null) {
      passiveUserAccount = widget.userAccount;
    } else {
      passiveUserAccount = widget.user.account;
    }
    if (activeUserAccount != null && passiveUserAccount != null) {
      _friendBloc.dispatch(AddFriendEvent(
        activeUserAccount: activeUserAccount,
        passiveUserAccount: passiveUserAccount,
        context: context,
      ));
    } else {
      Utils.showTip(context: context, tipText: "添加失败！请稍后重试");
    }
  }

  /**
   * 路由跳转
   */
  replaceRoute() {
    print("跳转到聊天界面");
  }

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    _friendBloc = BlocProvider.of<FriendBloc>(context);
    if (context == null) {
      this.context = context;
    }
    //如果从外部传入了用户信息，则直接将用户的信息展示
    if (widget.user == null) {
      _friendBloc.dispatch(InitUserInfoEvent(userAccount: widget.userAccount));
    } else {
      //如果外部传入的用户对象信息为null，则使用传入的用户账号去发送请求，然后进行展示
      _friendBloc.dispatch(InitUserInfoEvent(
          userAccount: widget.userAccount, user: widget.user));
    }
    String currentUserAccount = _authBloc.currentState != null
        ? _authBloc.currentState.user.account
        : null;
    //标题栏的背景颜色
    Color titleBarBGColor = _themeBloc.currentState.theme != null &&
            _themeBloc.currentState.theme.titleBarBGColor != null
        ? _themeBloc.currentState.theme.titleBarBGColor
        : null;
    Color titleBarTextColor = _themeBloc.currentState.theme != null &&
            _themeBloc.currentState.theme.titleBarTextColor != null
        ? _themeBloc.currentState.theme.titleBarTextColor
        : null;
    return BlocBuilder(
      bloc: _authBloc,
      builder: (BuildContext context, AuthState authState) {
        return BlocBuilder(
          bloc: _themeBloc,
          builder: (BuildContext context, ThemeState themeState) {
            return BlocBuilder(
              bloc: _friendBloc,
              builder: (BuildContext context, FriendState friendState) {
                String address = friendState.userData != null &&
                        friendState.userData.address != null
                    ? friendState.userData.address
                    : '暂无地址信息';
                String account = friendState.userData != null &&
                        friendState.userData.account != null
                    ? friendState.userData.account
                    : '暂无地址信息';
                return Scaffold(
                  body: Center(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
//                              背景图片
                              image: NetworkImage(
                                  "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3848897141,834260771&fm=26&gp=0.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        //=======================【用户信息展示区域】==================
                        SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 200),
                                  constraints: BoxConstraints(
                                      minHeight: Utils.getScreenSize().height),
                                  color: Color(0xddffffff),
                                  //内容
                                  child: Transform.translate(
                                    offset: Offset(0, -50),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                            color: Colors.black12,
                                          ))),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    15, 0, 15, 20),
                                                child: Row(
                                                  children: <Widget>[
                                                    Header(
                                                      width: 100.0,
                                                      height: 100.0,
                                                      borderColor: Colors.white,
                                                      borderWidth: 3.0,
                                                      imgSrc: friendState
                                                                      .userData !=
                                                                  null &&
                                                              (friendState.userData
                                                                          .headerImg !=
                                                                      null ||
                                                                  friendState
                                                                          .userData
                                                                          .headerImg !=
                                                                      "")
                                                          ? friendState.userData
                                                              .headerImg
                                                          : null,
                                                      isMan: friendState
                                                                  .userData !=
                                                              null &&
                                                          friendState.userData
                                                                  .gender ==
                                                              "1",
                                                    ),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          10),
                                                              child: Text(
                                                                friendState.userData !=
                                                                        null
                                                                    ? friendState
                                                                        .userData
                                                                        .nickName
                                                                    : "未知用户",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  color:
                                                                      textColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  //性别
                                                                  Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      right: 15,
                                                                    ),
                                                                    child: Text(
                                                                      friendState.userData != null &&
                                                                              friendState.userData.gender == "1"
                                                                          ? "男"
                                                                          : "女",
                                                                      style: TextStyle(
                                                                          color:
                                                                              textColor),
                                                                    ),
                                                                  ),
                                                                  //地址
                                                                  Text(
                                                                    address,
                                                                    style: TextStyle(
                                                                        color:
                                                                            textColor),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.fromLTRB(
                                                    15, 0, 15, 15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    //账号
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 10),
                                                            child: Icon(
                                                              Icons
                                                                  .account_circle,
                                                              color: textColor,
                                                              size: 18,
                                                            ),
                                                          ),
                                                          Text(
                                                            account,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: textColor,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    //地址
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 10),
                                                            child: Icon(
                                                              Icons.location_on,
                                                              color: textColor,
                                                              size: 18,
                                                            ),
                                                          ),
                                                          Text(
                                                            address,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: textColor,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    //邮箱
                                                    Container(
                                                      child: Row(
                                                        children: <Widget>[
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 10),
                                                            child: Icon(
                                                              Icons.email,
                                                              color: textColor,
                                                              size: 18,
                                                            ),
                                                          ),
                                                          Text(
                                                            friendState.userData !=
                                                                        null &&
                                                                    (friendState.userData.email !=
                                                                            null &&
                                                                        friendState.userData.email !=
                                                                            "")
                                                                ? friendState
                                                                    .userData
                                                                    .email
                                                                : '暂无',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: textColor,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    //查看更多资料
                                                    UnconstrainedBox(
                                                      child: FlatButton(
                                                        padding:
                                                            EdgeInsets.all(0),
                                                        onPressed: () {},
                                                        child: Row(
                                                          children: <Widget>[
                                                            Text(
                                                              "详细资料",
                                                              style: TextStyle(
                                                                  color:
                                                                      textColor,
                                                                  fontSize: 14),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                              size: 16,
                                                              color: textColor,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        //==========================【相册区域】

                                        Container(
                                          padding: EdgeInsets.only(top: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    15, 0, 15, 5),
                                                child: Text(
                                                  authState.user.account ==
                                                          friendState
                                                              .userData.account
                                                      ? "我的相册"
                                                      : '他的相册',
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 200,
                                                child: ListView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  children: [
                                                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1568891807576&di=62c0b019cf41461ecd92a6ae0ac2064d&imgtype=0&src=http%3A%2F%2Fs7.rr.itc.cn%2Fr%2Fv%2FAM%2Fz2Iru6r.jpg",
                                                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1568891850321&di=f2955687d85ab28db2cc6cbc88838423&imgtype=0&src=http%3A%2F%2Fphotocdn.sohu.com%2F20110607%2FImg309486232.jpg",
                                                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1568891867999&di=02fcb65fe5a87c4645a7adf303199060&imgtype=0&src=http%3A%2F%2Fent.cctv.com%2F20090626%2Fimages%2F1245979481113_1245979481113_r.jpg",
                                                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1568891885814&di=4f3b966cce4432bcae1f8028d890b23e&imgtype=0&src=http%3A%2F%2Fi0.hdslb.com%2Fbfs%2Farchive%2F6abe72c26e967c6c5fcb08de87bf33b799b732db.jpg",
                                                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1568891900615&di=cd1c3b07805be8da8e17d02b7f3db614&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fq_70%2Cc_zoom%2Cw_640%2Fimages%2F20180716%2Fe10c6bd6c29a4aafb6f140bc0fc90bf3.jpeg",
                                                    "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1859658185,3116235753&fm=26&gp=0.jpg",
                                                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1568891988274&di=0b6969a04d98de177c24c0cf47465299&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201807%2F14%2F20180714211943_vlvpq.jpg",
                                                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1568892006219&di=b9f3d751ab0a9ec3007e364feb816b7e&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20180719%2F41c7c6ee6e7f40af99abffd02102eef7.jpeg",
                                                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1568892040851&di=9ee43840ad35526638820e3969c844f8&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201512%2F07%2F20151207171034_nHaus.jpeg",
                                                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1568892072555&di=1fcde272a5d81268233f5f31504e2645&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Ftransform%2F20150721%2F9D6t-fxfaswi4168160.jpg",
                                                    "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3202944050,3025287062&fm=26&gp=0.jpg"
                                                  ]
                                                      .map((item) => Container(
                                                            height: 220,
                                                            color:
                                                                Colors.black54,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child:
                                                                Image.network(
                                                                    item),
                                                          ))
                                                      .toList(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        //=======================【顶部appBar】==================
                        Container(
                          padding: EdgeInsets.only(top: 22),
                          height: 80,
                          decoration: BoxDecoration(color: Color(0x55ffffff)),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: BackBtn(),
                              ),
                              Expanded(
                                flex: 6,
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      currentUserAccount ==
                                                  widget.userAccount ||
                                              (widget.user != null &&
                                                  currentUserAccount ==
                                                      widget.user.account)
                                          ? "我的资料"
                                          : '个人资料',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: themeState.theme != null &&
                                                themeState.theme
                                                        .titleBarTextColor !=
                                                    null
                                            ? themeState.theme.titleBarTextColor
                                            : null,
                                      ),
                                    )),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(),
                              ),
                            ],
                          ),
                        ),
                        //底部操作按钮
                        Positioned(
                          bottom: 0,
                          width: Utils.getScreenSize().width,
                          child: Container(
                            color: Color(0x55ffffff),
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                {"label": "查看资料", "key": 0},
                                {"label": "送礼物", "key": 1},
                                {
                                  "label": widget.isFriend ? "发送消息" : "添加好友",
                                  "key": 2
                                }
                              ]
                                  .map(
                                    (item) => ClipRect(
                                      child: FlatButton(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 15, 20, 15),
                                        color: item["key"] == 2
                                            ? Colors.blueAccent
                                            : Color(0xffeeefef),
                                        onPressed: widget.isFriend
                                            ? replaceRoute
                                            : () {
                                                addFriend(
                                                    authState.user.account,
                                                    context);
                                              },
                                        child: Text(
                                          item["label"],
                                          style: TextStyle(
                                            color: item["key"] == 2
                                                ? Colors.white
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
