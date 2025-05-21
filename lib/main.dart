import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geo_location/app.dart';
import 'package:geo_location/servive/fcm_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FcmService().init();
  runApp(const LiveScoreApp());
}



