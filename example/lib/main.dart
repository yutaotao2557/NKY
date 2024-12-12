import 'package:flutter/material.dart';
import 'package:sxd_example/sxd_test.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(home: Scaffold(appBar: AppBar(title: const Text('硕欣达蓝牙配网')), body: _body()));

  Widget _body() => SxdTestWidget();
}
