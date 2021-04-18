import 'package:flutter/material.dart';
import 'pages/SignUp.dart';
import 'pages/Login.dart';
import 'NavBar.dart';

Map<String, WidgetBuilder> routes(BuildContext context) {
  Map<String, WidgetBuilder> rutas = {
    '/': (BuildContext context) => Login(),
    'home': (BuildContext context) => NavBar(iduser),
    'signup': (BuildContext context) => SignUp()
  };
  return rutas;
}
