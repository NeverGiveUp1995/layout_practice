import 'package:layout_practice/blocs/theme/bloc.dart';
import 'package:layout_practice/modals/login_modal/User.dart';
import 'package:meta/meta.dart';
import 'package:layout_practice/modals/theme/Theme.dart' as myThemes;

@immutable
abstract class ThemeEvent {
  get theme => null;
}

class ToggleTheme extends ThemeEvent {
  myThemes.Theme theme;
  User currentUser;

  ToggleTheme({@required this.theme, @required this.currentUser});

  @override
  String toString() {
    return "ToggleTheme";
  }
}
