import 'package:meta/meta.dart';
import 'package:layout_practice/modals/theme/Theme.dart' as myThemes;

@immutable
abstract class ThemeEvent {
  get theme => null;
}

class ToggleTheme extends ThemeEvent {
  myThemes.Theme theme;

  ToggleTheme({@required this.theme});

  @override
  String toString() {
    return "ToggleTheme";
  }
}
