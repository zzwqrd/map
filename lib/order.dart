import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
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
  dynamic datalat;
  dynamic datalong;

  final ref = FirebaseDatabase.instance.reference();
  final _refss = FirebaseDatabase.instance.ref().child("Tasks");

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
        ref.set({
          "datalat": loc.latitude.toString(),
          "datalong": loc.longitude.toString(),
          "address": {"line1": "100 Mountain View"}
        });
        datalat = loc.latitude;
        datalong = loc.longitude;
      });
    });
  }

  @override
  void initState() {
    setState(() {
      getLocation();
    });

    print('🌿🌿🌿🌿🌿🌿🌿🌿🌿==-=.datalat.=-==🌿🌿🌿🌿🌿🌿🌿🌿🌿${datalat.toString()}🌿🌿🌿🌿🌿🌿🌿🌿🌿');
    print('🌿🌿🌿🌿🌿🌿🌿🌿🌿==-=.datalong.=-==🌿🌿🌿🌿🌿🌿🌿🌿🌿${datalong.toString()}🌿🌿🌿🌿🌿🌿🌿🌿🌿');

    super.initState();
  }

  DatabaseReference refddd = FirebaseDatabase.instance.ref("users/123");
  @override
  Widget build(BuildContext context) {
    final daily = ref.child('/dddd');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          zoomControlsEnabled: true,
          mapToolbarEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: const CameraPosition(
            target: LatLng(31.046096835297483, 31.353678881570186),
            zoom: 17.0,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
          markers: _markers,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.location_searching,
          color: Colors.white,
        ),
        onPressed: () async {
          setState(() {
            getLocation();
            print('🌿🌿🌿🌿🌿🌿🌿🌿🌿==-=.datalat.=-==🌿🌿🌿🌿🌿🌿🌿🌿🌿${datalat.toString()}🌿🌿🌿🌿🌿🌿🌿🌿🌿');
            print('🌿🌿🌿🌿🌿🌿🌿🌿🌿==-=.datalong.=-==🌿🌿🌿🌿🌿🌿🌿🌿🌿${datalong.toString()}🌿🌿🌿🌿🌿🌿🌿🌿🌿');
            // r.child(datalat.toString()).push().child(datalong.toString()).set(_controller).asStream();
            // _refss.child(datalat.toString()).set(_controller.toString());
          });
        },
      ),
    );
  }
}
