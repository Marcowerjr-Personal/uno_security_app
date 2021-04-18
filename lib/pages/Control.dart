import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:uno_security_app/db/getDeviceData.dart';
import 'Login.dart';

String estadoAlarma = device['status'];
String inclination = device['tilt'];
double latitude = device['latitude'];
double longitude = device['longitude'];

class ControlPage extends StatefulWidget {
  ControlPage(iduser, {Key key}) : super(key: key);

  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  FlutterLocalNotificationsPlugin appNotification;

  @override
  void initState() {
    super.initState();
    getDeviceData();
    var initializeAndroidNotification =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializeIOSNotification = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializeAndroidNotification, iOS: initializeIOSNotification);
    appNotification = new FlutterLocalNotificationsPlugin();
    appNotification.initialize(initializationSettings,
        onSelectNotification: _notification);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Divider(
            height: 100,
            color: Colors.white,
          ),
          Center(
            child: Text(
              'Estado de la alarma: $estadoAlarma',
              style: TextStyle(fontSize: 22),
            ),
          ),
          Divider(
            height: 50,
            color: Colors.white,
          ),
          Center(
            child: Text(
              'Sensor de inclinación: $inclination',
              style: TextStyle(fontSize: 22),
            ),
          ),
          Divider(
            height: 100,
            color: Colors.white,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () => _postAlarmStatus('ENCENDIDO'),
                child: Text(
                  "Encender",
                  style: TextStyle(fontSize: 20),
                ),
                style: ButtonStyle(
                    alignment: Alignment.centerLeft,
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    fixedSize: MaterialStateProperty.all(Size.fromHeight(50)))),
          ),
          Divider(
            color: Colors.white,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () => _postAlarmStatus('APAGADO'),
                child: Text("Apagar", style: TextStyle(fontSize: 20)),
                style: ButtonStyle(
                    alignment: Alignment.centerLeft,
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    fixedSize: MaterialStateProperty.all(Size.fromHeight(50)))),
          )
        ],
      ),
    );
  }

  _postAlarmStatus(String estado) async {
    var datos = jsonEncode({
      'n_top': 2,
      'status': estado,
      'latitude': latitude,
      'longitude': longitude,
      'tilt': inclination
    });
    sleep(Duration(milliseconds: 500));
    await put(Uri.parse(
            // "https://api-uno-security.herokuapp.com/api/top_device/update/${iduser.toString()}"),
            "https://api-uno-security.herokuapp.com/api/top_device/update/2"),
        headers: {"Content-type": "application/json"}, body: datos);
    await _getAlarmStatus();
  }

  _getAlarmStatus() async {
    var respuesta = await get(
        // Uri.parse("https://api-uno-security.herokuapp.com/device/$iduser/"),
        Uri.parse("https://api-uno-security.herokuapp.com/device/2/"),
        headers: {"Content-type": "application/json"});
    var device = jsonDecode(respuesta.body)['device'];
    setState(() {
      estadoAlarma = device['status'];
      inclination = device['tilt'];
      latitude = device['latitude'];
      longitude = device['longitude'];
    });
    _showNotification();
  }

  Future _showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    if (estadoAlarma == 'ENCENDIDO') {
      if (inclination == "INCLINADO") {
        await appNotification.show(
            0,
            'ESTADO DE LA ALARMA',
            'La alarma se encuentra encendida y está inclinada',
            platformChannelSpecifics,
            payload: 'item x');
      } else {
        await appNotification.show(
            0,
            'ESTADO DE LA ALARMA',
            'La alarma se encuentra encendida y no está inclinada',
            platformChannelSpecifics,
            payload: 'item x');
      }
    } else {
      if (inclination == "INCLINADO") {
        await appNotification.show(
            0,
            'ESTADO DE LA ALARMA',
            'La alarma se encuentra apagada y está inclinada',
            platformChannelSpecifics,
            payload: 'item x');
      } else {
        await appNotification.show(
            0,
            'ESTADO DE LA ALARMA',
            'La alarma se encuentra apagada y no está inclinada',
            platformChannelSpecifics,
            payload: 'item x');
      }
    }
  }

  Future _notification(String payload) async {}
}
