import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:momapp/SplashScreen.dart';
import 'package:momapp/blocs/bloc_provider.dart';
import 'package:momapp/ui/login_page.dart';

import 'blocs/app_bloc.dart';
import 'blocs/home_screen_bloc.dart';

Future<void> main() async => runApp(BlocProvider(
  bloc: AppBloc(),
  child: MaterialApp(

    initialRoute: '/',

    routes: <String, WidgetBuilder>{
      '/': (context) => BlocProvider(bloc: HomeScreenBloc(), child: SplashPage()),
      '/loginPage': (context) => BlocProvider(bloc: HomeScreenBloc(), child: LoginPage()),

    },
  ),
));

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
