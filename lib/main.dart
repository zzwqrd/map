import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_map/firebase_notifications.dart';
import 'package:get_map/order.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GlobalNotification().setUpFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Order(),
    );
  }
}
