import 'dart:convert';
import 'dart:io';

import 'package:layout_practice/utils/Utils.dart';
import 'package:meta/meta.dart';
import 'package:layout_practice/modals/theme/Theme.dart' as myThemes;
import 'package:layout_practice/theme/ThemeData.dart';

@immutable
abstract class ThemeState {
  myThemes.Theme get theme => null;
}

class CurrentThemeState extends ThemeState {
  myThemes.Theme theme = null;

  CurrentThemeState({@required theme}) {
    if (theme != null) {
      this.theme = theme;
    }
  }

  @override
  String toString() {
    return "CurrentThemeState";
  }
}
