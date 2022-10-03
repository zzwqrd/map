import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get_map/constans.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  GoogleMapController? _controller;
  Location currentLocation = Location();
  Set<Marker> _markers = {};

  void getLocation() async {
    var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc) {
      _controller?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
        zoom: 12.0,
      )));
      print('🍄🍄🍄🍄🍄🍄==-=.lat.=-==🍄🍄🍄🍄🍄🍄${loc.latitude.toString()}🍄🍄🍄🍄🍄🍄🍄🍄🍄🍄🍄🍄');
      print('🍄🍄🍄🍄🍄🍄==-=.long.=-==🍄🍄🍄🍄🍄🍄${loc.longitude.toString()}🍄🍄🍄🍄🍄🍄🍄🍄🍄🍄🍄🍄');
      setState(() {
        _markers.add(Marker(markerId: MarkerId('Home'), position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)));
      });
    });
  }

  @override
  void initState() {
    setState(() {
      getLocation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          zoomControlsEnabled: true,
          mapToolbarEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(31.046096835297483, 31.353678881570186),
            zoom: 50.5,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
          markers: _markers,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.location_searching,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            getLocation();
          });
        },
      ),
    );
  }
}
