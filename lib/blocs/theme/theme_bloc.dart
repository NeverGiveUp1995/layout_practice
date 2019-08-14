import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:layout_practice/theme/ThemeData.dart';
import 'package:layout_practice/utils/consts/CacheFolderNames.dart';
import 'package:layout_practice/utils/consts/FileNames.dart';
import './bloc.dart';
import 'package:layout_practice/utils/Utils.dart';
import 'package:layout_practice/modals/theme/Theme.dart' as myThemes;

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => CurrentThemeState(theme: null);

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ToggleTheme) {
      print("准备读取用户【${event.currentUser.account}】设置的主题缓存文件");
      //将当前主题文件写入缓存文件中
      File themeFile = await Utils.getLocalFile(
        event.currentUser.account,
        '${CacheFolderNames.themes}',
        '${FileNames.theme}.txt',
      );
//      Utils.readContentFromFile(themeFile);
      await Utils.writeContentTofile(themeFile, event.theme.toString());
      yield CurrentThemeState(theme: event.theme);
    }
  }
}
