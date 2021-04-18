import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _name = '', _email = '', _password = '';

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
    return Scaffold(
      body: _inputElements(context),
    );
  }

  Widget _inputElements(BuildContext context) => ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: <Widget>[
          _nameField(),
          Divider(),
          _emailField(),
          Divider(),
          _passwordField(),
          Divider(),
          ElevatedButton(
              child: Text('Crear cuenta'),
              onPressed: () {
                final snackBar = SnackBar(content: Text('Datos Guardados'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }),
          Divider(),
        ],
      );

  Widget _nameField() => TextField(
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: 'Nombre Completo:',
            labelText: 'Nombre Completo',
            suffixIcon: Icon(Icons.text_fields),
            icon: Icon(Icons.account_circle),
            counter: Text('Caracteres: ${_name.length}')),
        onChanged: (text) {
          //evento
          setState(() {
            _name = text;
          });
        },
      );
  Widget _emailField() => TextField(
        keyboardType: TextInputType.emailAddress, //tipo de entrada de email
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: 'Correo:',
            labelText: 'Correo',
            suffixIcon: Icon(Icons.mail), //aparece a la derecha de field
            icon: Icon(Icons.mail),
            counter: Text('Caracteres: ${_email.length}')),
        onChanged: (text) {
          //evento
          setState(() {
            _email = text;
          });
        },
      );
  Widget _passwordField() => TextField(
        //textCapitalization: TextCapitalization.sentences, //teclado
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: 'Contraseña:',
            labelText: 'Contraseña',
            suffixIcon: Icon(Icons.security), //aparece a la derecha de field
            icon: Icon(Icons.lock),
            counter: Text('Caracteres: ${_password.length}')),
        onChanged: (text) {
          //evento
          setState(() {
            _password = text;
          });
        },
      );
}
