import 'dart:convert';

import 'package:dbcrypt/dbcrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart';
import '../NavBar.dart';
import '../db/getDeviceData.dart';
import '../db/getUserData.dart';

List users;
int iduser;
Map user, device;

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Duration get loginTime => Duration(milliseconds: 1000);

  Future<void> _userInfo() async {
    user = await getUserData(iduser);
    device = await getDeviceData();
  }

  _getData() async {
    var respuesta = await get(
        Uri.parse(
            "https://api-uno-security.herokuapp.com/admin/users/securityAppCuuTOKEN/all"),
        headers: {"Accept": "application/json"});
    var data = jsonDecode(respuesta.body)['all_users'];
    setState(() {
      users = data;
    });
  }

  Future<String> _autenticarUsuario(LoginData usuario) async {
    iduser = -1;
    await _getData();
    return Future.delayed(loginTime).then((_) async {
      String msg;
      bool passwordCorrect;
      for (var email in users) {
        passwordCorrect =
            new DBCrypt().checkpw(usuario.password, email['password']);
        if ((usuario.name == email['email']) && (passwordCorrect)) {
          iduser = email['n_top'];
          msg = null;
          await _userInfo();
          break;
        }
        if (!passwordCorrect || usuario.name != email['email']) {
          msg = 'El usuario no existe o la contraseña es incorrecta';
        }
      }
      return msg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Uno Security App',
      logo: 'assets/logo.png',
      onLogin: _autenticarUsuario,
      onSignup: _autenticarUsuario,
      onRecoverPassword: null,
      hideSignUpButton: true,
      hideForgotPasswordButton: true,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => NavBar(iduser),
          maintainState: true,
        ));
      },
      messages: LoginMessages(
        loginButton: 'Iniciar Sesión',
        usernameHint: 'Correo electrónico',
        passwordHint: 'Contraseña',
        confirmPasswordError: 'Contraseña incorrecta',
        flushbarTitleError: 'Error',
      ),
    );
  }
}
