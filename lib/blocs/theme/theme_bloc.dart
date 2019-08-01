import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:layout_practice/theme/ThemeData.dart';
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
      print("准备将主题：${event.theme.themeName}写入缓存文件中");
      //将当前主题文件写入缓存文件中
      File themeFile = await Utils.getLocalFile('theme.txt');
      Utils.readContentFromFile(themeFile);
      print("返回的文件===》${themeFile}");

      await Utils.writeContentTofile(themeFile, event.theme.toString());
      print("写入成功！");
      yield CurrentThemeState(theme: event.theme);
    }
  }
}
