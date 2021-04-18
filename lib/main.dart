import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'pages/Login.dart';
import 'routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uno Security App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: routes(context),
      onGenerateRoute: (RouteSettings settings) =>
          MaterialPageRoute(builder: (BuildContext context) => Login()),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', 'ES'), //Español de España
        const Locale('es', 'MX')
      ],
    );
  }
}
