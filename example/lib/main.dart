import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sxd/sxd.dart';
import 'package:sxd_example/util_byte.dart';
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
    String data = (await _sxdPlugin.setDatalogerByP0x19(sdkData))?.toHex() ?? "---";
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
    String data = (await _sxdPlugin.setDatalogerByP0x18(sdk0x18Data))?.toHex() ?? "---";
    setState(() {
      _log += "$data\n";
    });
  }

  Future<void> _parse18() async {
    String data = "00180006000f0118fe018027cac29049b2591fa8a9d95247b4d2";
    var bytes = Uint8List.fromList(hex2Bytes(data));
    var back = (await _sxdPlugin.parserPro0x18(bytes));
    setState(() {
      _log += "${back}\n";
    });
  }

  Future<void> _parse19() async {
    // String data = "01280006011e0119cc4c5f3d2845525c7b8243dbfcfe198af1256ccfb42524416a16b49ea0cddc2254a1975c35c00ab3e1612c3515bb7e5b0f1f27"
    //     "20c606df289950227fdd460680751688b49771fb01ca12224c92c260d6ac63dcfe6b8219fe4bb7971a3c27214a1186a6beaf5855bd102045c1b3ab1bd203f82d6a8d5ac53e9279c1926c69e2f653c7c32705754988adbf30d9a3303a6a2392f6afcf07a1f300e46581ac12bf2511bce64bc0827a81055c4a8c2731d984651db63fb92e38c91e10bad3239f4745c80d1156a0fdd30fd08d7db975778adfd25414f71df64bb42260ae5f7454ec0b6d88d9b5d117e1b58c765e9e5f4ee57938a304d9032cad72a964da03d40226b28855b2515858e2b66d9328ca19ca031fb666a6e89e381a60d9491aa522ecd647";
    // String data = "0028000600140119c8701e9d7117b07576f2fcf9793cd825ddca57e17c331fd38c2e1a304b18ba8456ca";
    String data = "00f8000600f101198c148f24aa1178f54db8e7a16fda91b3c5c7ce7f7edb00780dbc3fe55af8835e1a05f6cfdae73ad6328544f5a7d4d295ee2233"
        "99dc4cdb66e087051fb4fb74b59265f003481edc67ccca179c56fbfb98ba9369c90f56ccd52e77b8fd74a1c6cb5140d730784aed2f61934c0b911b0f045a8c19158cfc1f2f8b19f3b12b7f39d4180b728b5f1dc6ab5b39c56a0dfe17bc241f76f15fcc3f0584d26a01541ecf40720f4be89e8229e1b19bc3d34fe1cda551e07adf564c11232f7f17b5f8b85696de9345b689fdf9e70a590787799de56de3eb22d3d55445a58dfae4553705fde7ea0e893bdf8cb008e6ef6afeec4b8932ed83";
    var bytes = Uint8List.fromList(hex2Bytes(data));
    var back = (await _sxdPlugin.parserPro0x19(bytes)) as List;
    setState(() {
      _log += "${back}\n";
    });
    print(back[0]["bytes"]);
    List<int> content = [];
    (back[0]["bytes"] as List).forEach((item) {
      content.add(int.parse(item.toString()));
    });
    print("content:$content");
    print("content:${_parseWifiList(Uint8List.fromList(content.sublist(14,content.length -2)))}");
    setState(() {
      _log += "${_parseWifiList(Uint8List.fromList(content.sublist(14,content.length -2)))}\n";
    });
  }


  // 0, 75, 0, 222, 18, 8, 84, 80, 115, 104, 117, 111, 120, 100,
  // 225,
  // 6, 115, 104, 117, 111, 120, 100, 221,
  // 8, 84, 80, 115, 104, 117, 111, 120, 100, 215,
  // 10, 69, 83, 80, 95, 67, 70, 52, 49, 51, 57, 215,
  // 11, 80, 82, 79, 86, 95, 69, 52, 55, 66, 57, 52, 210,
  // 4, 83, 90, 75, 88, 206,
  // 11, 67, 104, 101, 110, 89, 97, 110, 84, 101, 115, 116, 205,
  // 9, 79, 99, 101, 97, 110, 49, 54, 56, 56, 204,
  // 32, 68, 73, 82, 69, 67, 84, 45, 51, 65, 45, 72, 80, 32, 68, 101, 115, 107, 74, 101, 116, 32, 50, 55, 48, 48, 32, 115, 101, 114, 105, 101, 115, 203,
  // 4, 83, 90, 75, 88, 200,
  // 7, 84, 105, 97, 110, 115, 104, 117, 193,
  // 12, 231, 129, 181, 229, 138, 168, 228, 186, 146, 232, 191, 158, 192,
  // 12, 84, 80, 45, 76, 73, 78, 75, 95, 57, 56, 69, 66, 191,
  // 3, 110, 110, 119, 190,
  // 12, 229, 140, 151, 229, 133, 131, 231, 148, 181, 229, 153, 168, 189,
  // 12, 229, 140, 151, 229, 133, 131, 231, 148, 181, 229, 153, 168, 186,
  // 15, 229, 135, 175, 230, 150, 175, 229, 190, 183, 75, 69, 83, 68, 69, 82, 185,
  // 9, 67, 77, 67, 67, 45, 107, 107, 54, 51, 182
  static String _parseWifiList(Uint8List data) {
    // 13, 15, 76, 117, 120, 115, 104, 97, 114, 101, 45, 79, 102, 102, 105, 99, 101, 203, 8, 72, 70, 95, 71, 117, 101, 1
    int wifiCount = data[0];
    String beans = "";
    List<int> nameData = [];
    bool isNewStart = true;
    int nameCount = 0;

    for (int i = 1; i < data.length; i++) {
      if (isNewStart) {
        isNewStart = false;
        nameData.clear();
        nameCount = data[i];
      } else {
        if (nameCount > nameData.length) {
          nameData.add(data[i]);
        } else if (nameCount >= nameData.length) {
          // BlueWifiBean wifiBean = BlueWifiBean();
          String name = ByteUtil.byte2String(Uint8List.fromList(nameData));
          int sign = data[i];
          beans += "${name}:${sign}\n";
          isNewStart = true;
        }
      }
    }
    print("wifiCount:$wifiCount;list${beans.toString()}");
    return beans;
  }

  Uint8List hex2Bytes(String hex) {
    if (hex.length % 2 != 0) return Uint8List.fromList([]);
    List<int> back = [];
    for (int i = 0; i < hex.length; i += 2) {
      back.add(int.parse(hex.substring(i, i + 2), radix: 16));
    }
    return Uint8List.fromList(back);
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
                      child: SingleChildScrollView(child: Text(_log, style: const TextStyle(fontSize: 14, color: Color(0xff333333)))))),
              Wrap(spacing: 10, runSpacing: 10, children: [
                _btn("获取系统版本", _getVersion),
                _btn("发送18", _datalog18),
                _btn("发送19", _datalog19),
                _btn("解析18", _parse18),
                _btn("解析19", _parse19),
                _btn("清空日志", _clearLog),
              ]),
              const SizedBox(height: 20),
            ])));
  }

  Widget _btn(String name, VoidCallback callback) =>
      FilledButton(onPressed: () => callback(), child: Text(name, style: const TextStyle(fontSize: 12, color: Colors.white)));
}
