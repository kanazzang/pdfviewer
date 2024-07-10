import 'package:flutter/material.dart';
import 'package:pdfviewer/pinch.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.white),
        darkTheme: ThemeData.dark(),
        home: const PinchPage(),
      );
}
