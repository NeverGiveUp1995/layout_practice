import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/friend/bloc.dart';
import 'package:layout_practice/blocs/theme/bloc.dart';
import 'package:layout_practice/components/Header/Header.dart';
import 'package:layout_practice/modals/user/user_entity.dart';
import 'package:layout_practice/views/PersonalDetails/PersonalDetails.dart';

/**
 *【好友、群组、搜索页面】
 */
class SearchFriend extends StatefulWidget {
  @override
  _SearchFriendState createState() => _SearchFriendState();
}

class _SearchFriendState extends State<SearchFriend> {
  ThemeBloc _themeBloc;
  FriendBloc _friendBloc;
  TextEditingController _searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    _friendBloc = BlocProvider.of<FriendBloc>(context);

    return BlocBuilder(
      bloc: _themeBloc,
      builder: (BuildContext context, ThemeState _themeState) {
        return BlocBuilder(
          bloc: _friendBloc,
          builder: (BuildContext context, FriendState friendState) {
            print("${friendState.userResuls}");
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: _themeState.theme.titleBarBGColor,
                leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: _themeState.theme.titleBarTextColor,
                      size: 18,
                    ),
                    onPressed: () => Navigator.pop(context)),
                title: Text(
                  '查找',
                  style: TextStyle(
                      fontSize: 16, color: _themeState.theme.titleBarTextColor),
                ),
                centerTitle: true,
              ),
              body: Container(
                color: _themeState.theme != null
                    ? _themeState.theme.bodyColor
                    : null,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      //顶部搜索输入框
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xaaefefef),
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child: TextField(
                            cursorColor: _themeState.theme.textFieldCursorColor,
                            controller: _searchEditingController,
                            onChanged: (text) {
                              _friendBloc
                                  .dispatch(SearchUserEvent(keyWords: text));
                            },
                            autofocus: true,
                            cursorWidth: 1.5,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "搜索好友",
                            ),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black26),
                          ),
                        ),
                      ),
                      //结果显示区
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(top: 30),
                          child: ListView(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            children: friendState.userResuls != null
                                ? friendState.userResuls.length > 0
                                    ? friendState.userResuls.map((userResul) {
                                        String nickName = userResul.user !=
                                                    null &&
                                                userResul.user.nickName != null
                                            ? userResul.user.nickName
                                            : '';
                                        String userAccount = userResul.user !=
                                                    null &&
                                                userResul.user.account != null
                                            ? userResul.user.account
                                            : '';
                                        String address = userResul.user !=
                                                    null &&
                                                userResul.user.address != null
                                            ? userResul.user.address
                                            : '';
                                        String imgSrc = userResul.user != null
                                            ? userResul.user.headerImg
                                            : null;
                                        int age = userResul.user.birthday !=
                                                    null &&
                                                userResul.user.birthday != "" &&
                                                userResul.user.birthday
                                                        .split('-')[0] !=
                                                    null
                                            ? DateTime.now().year -
                                                int.parse(userResul
                                                    .user.birthday
                                                    .split('-')[0])
                                            : 0;
                                        return FlatButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PersonalDetails(
                                                          userAccount:
                                                              userAccount,
                                                          user:
                                                              UserData.fromJson(
                                                                  userResul.user
                                                                      .toJson()),
                                                          isFriend: userResul
                                                              .isfriend,
                                                        )));
                                          },
                                          child: Container(
                                            height: 60,
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, 10, 0),
                                                  child: Header(
                                                    width: 50.0,
                                                    height: 50.0,
                                                    imgSrc: imgSrc,
                                                    isMan: userResul
                                                                .user.gender ==
                                                            "1" ||
                                                        userResul.user.gender ==
                                                            "",
                                                  ),
                                                ),
                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text(
                                                          "$nickName ($userAccount) ",
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          15),
                                                              child: Text(
                                                                userResul.user !=
                                                                                null &&
                                                                            userResul.user.gender ==
                                                                                "1" ||
                                                                        userResul.user.gender ==
                                                                            null ||
                                                                        userResul.user.gender ==
                                                                            ""
                                                                    ? "男"
                                                                    : '女',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black38),
                                                              ),
                                                            ),
                                                            Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            10),
                                                                child: Text(
                                                                  "$age岁",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black38),
                                                                )),
                                                            Container(
                                                              child: Text(
                                                                address,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black38),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList()
                                    : [
                                        Center(
                                          child: Container(
                                            child: Text(
                                              "没有条件符合的用户",
                                              style: TextStyle(
                                                  color: Colors.black26),
                                            ),
                                          ),
                                        )
                                      ]
                                : [
                                    Center(
                                      child: Container(
                                        child: Text(
                                          "按照用户账号、昵称、地址进行搜索",
                                          style:
                                              TextStyle(color: Colors.black26),
                                        ),
                                      ),
                                    )
                                  ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
