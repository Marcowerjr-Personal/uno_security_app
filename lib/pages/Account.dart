import 'package:flutter/material.dart';

import 'Login.dart';

var userData = user;

class AccountPage extends StatefulWidget {
  AccountPage(int iduser, {Key key}) : super(key: key);

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Text(
            'Nombre Completo: ',
            style: TextStyle(
              fontSize: 25.0,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            '${userData['name']}',
            style: TextStyle(
              fontSize: 25.0,
            ),
            textAlign: TextAlign.center,
          ),
          Divider(
            height: 50,
            color: Colors.white,
          ),
          Text(
            'Correo Electrónico:',
            style: TextStyle(
              fontSize: 25.0,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            '${userData['email']}',
            style: TextStyle(
              fontSize: 25.0,
            ),
            textAlign: TextAlign.center,
          ),
          Divider(
            height: 50,
            color: Colors.white,
          ),
          Text(
            'Teléfono',
            style: TextStyle(
              fontSize: 25.0,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            '+52 ${userData['phone']}',
            style: TextStyle(
              fontSize: 25.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        padding: EdgeInsets.only(
            left: 10, right: 10, top: MediaQuery.of(context).size.height / 3.5),
      ),
      alignment: Alignment.center,
    );
  }
}
