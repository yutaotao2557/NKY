import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sxd/sxd.dart';
import 'package:sxd_example/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _sxdPlugin = Sxd();
  String _log = "";

  @override
  void initState() {
    super.initState();
    _getVersion();
  }

  void _clearLog() {
    setState(() {
      _log = "";
    });
  }

  Future<void> _datalog19() async {
    var sdkData = {
      "commandId": 19,
      "param19Obj": [55]
    };
    String data = ((await _sxdPlugin.setDatalogerByP0x19(sdkData)) as List<int>).toHex();
    setState(() {
      _log += "$data\n";
    });
  }

  Future<void> _datalog18() async {
    var sdk0x18Data = {
      "commandId": 18,
      "param18Obj": [
        {"paramId": 55, "param": 0}
      ]
    };
    String data = ((await _sxdPlugin.setDatalogerByP0x18(sdk0x18Data)) as List<int>).toHex();
    setState(() {
      _log += "$data\n";
    });
  }

  Future<void> _getVersion() async {
    String platformVersion;
    try {
      platformVersion = await _sxdPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _log += "$platformVersion\n";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('硕欣达蓝牙配网')),
            body: Column(children: [
              Expanded(
                  child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color(0xffe5e5e5),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: const [BoxShadow(offset: Offset(1, 1), blurRadius: 1, color: Color(0xffcccccc))]),
                child: Text(_log, style: const TextStyle(fontSize: 14, color: Color(0xff333333))),
              )),
              Row(children: [
                const SizedBox(width: 20),
                _btn("发送18", _datalog18),
                const SizedBox(width: 10),
                _btn("发送19", _datalog19),
                const SizedBox(width: 10),
                _btn("清空日志", _clearLog),
                const SizedBox(width: 10),
                _btn("获取系统版本", _getVersion),
                const SizedBox(width: 20),
              ]),
              const SizedBox(height: 20),
            ])));
  }

  Widget _btn(String name, VoidCallback callback) => Expanded(
      child: FilledButton(onPressed: () => callback(), child: Text(name, style: const TextStyle(fontSize: 12, color: Colors.white))));
}
