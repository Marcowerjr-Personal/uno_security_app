import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'Login.dart';

double lat = device['latitude'];
double long = device['longitude'];

class MapsPage extends StatefulWidget {
  MapsPage(int iduser, {Key key}) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  _getData() async {
    var respuesta = await get(
        // Uri.parse("https://api-uno-security.herokuapp.com/device/$iduser/"),
        Uri.parse("https://api-uno-security.herokuapp.com/device/2/"),
        headers: {"Content-type": "application/json"});
    var alarm = jsonDecode(respuesta.body)['device'];
    setState(() {
      lat = alarm['latitude'];
      long = alarm['longitude'];
    });
  }

  Future<void> _verificarLatLong() async {
    await _getData();
  }

  @override
  Widget build(BuildContext context) {
    _verificarLatLong();
    return Scaffold(
        body: GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(lat, long),
        zoom: 15,
      ),
      markers: <Marker>{_createMarker()},
      mapType: MapType.hybrid,
    ));
  }

  Marker _createMarker() {
    return Marker(
      markerId: MarkerId("marker_1"),
      position: LatLng(lat, long),
    );
  }
}
