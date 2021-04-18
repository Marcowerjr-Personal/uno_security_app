import 'dart:convert';

import 'package:http/http.dart' as http;

Future getDeviceData() async {
  var respuesta = await http.get(
      Uri.parse("https://api-uno-security.herokuapp.com/device/2/"),
      headers: {"Content-type": "application/json"});
  var data = jsonDecode(respuesta.body)['device'];
  return data;
}