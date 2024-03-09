import 'package:flutter/material.dart';
import 'package:flutter_google_maps/widgets/google_maps_camera.dart';

void main()
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const CustomGoogleMap(),
    );
  }
}

