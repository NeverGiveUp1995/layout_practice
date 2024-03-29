import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout_practice/blocs/theme/bloc.dart';

class BackBtn extends StatelessWidget {
  ThemeBloc _themeBloc;

  @override
  Widget build(BuildContext context) {
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    return UnconstrainedBox(
      child: SizedBox.fromSize(
        size: Size(50.0, 50.0),
        child: ClipOval(
          child: FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              color: _themeBloc.currentState.theme != null &&
                      _themeBloc.currentState.theme.titleBarTextColor != null
                  ? _themeBloc.currentState.theme.titleBarTextColor
                  : null,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
