import 'dart:convert';

import 'package:http/http.dart' as http;

Future getUserData(int iduser) async {
  var respuesta = await http.get(
      Uri.parse("https://api-uno-security.herokuapp.com/users/$iduser"),
      headers: {"Content-type": "application/json"});
  var data = jsonDecode(respuesta.body)['user'];
  return data;
}
