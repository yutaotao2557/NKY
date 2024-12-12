import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sxd/sxd.dart';
import 'package:sxd_example/utils.dart';

class SxdTestWidget extends StatefulWidget {
  @override
  State<SxdTestWidget> createState() => _SxdTestWidgetState();
}

class _SxdTestWidgetState extends State<SxdTestWidget> {
  final _sxdPlugin = Sxd();
  String _log = "";

  @override
  void initState() {
    super.initState();
    _getVersion();
  }

  @override
  Widget build(BuildContext context) => Column(children: [
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
      ]);

  Widget _btn(String name, VoidCallback callback) =>
      FilledButton(onPressed: () => callback(), child: Text(name, style: const TextStyle(fontSize: 12, color: Colors.white)));

  void _clearLog() => setState(() => (_log = ""));

  Future<void> _datalog19() async {
    var sdkData = {
      "commandId": 19,
      "param19Obj": [55]
    };
    String data = (await _sxdPlugin.setDatalogerByP0x19(sdkData))?.toHex() ?? "---";
    setState(() => (_log += "$data\n"));
  }

  Future<void> _datalog18() async {
    var sdk0x18Data = {
      "commandId": 18,
      "param18Obj": [
        {"paramId": 55, "param": 0}
      ]
    };
    String data = (await _sxdPlugin.setDatalogerByP0x18(sdk0x18Data))?.toHex() ?? "---";
    setState(() => (_log += "$data\n"));
  }

  Future<void> _parse18() async {
    String data = "00180006000f0118fe018027cac29049b2591fa8a9d95247b4d2";
    var bytes = Uint8List.fromList(hex2Bytes(data));
    var back = (await _sxdPlugin.parse18(bytes));
    setState(() => (_log += "$back\n"));
  }

  Future<void> _parse19() async {
    // String data = "0028000600160119c3ec8d5b86c782eaac8ef3dad37145c91a82ac7c88ff33c0d5ff99de778939a5839a";
    // String data = "0028000600140119c8701e9d7117b07576f2fcf9793cd825ddca57e17c331fd38c2e1a304b18ba8456ca";
    // String data = "00f8000600f101198c148f24aa1178f54db8e7a16fda91b3c5c7ce7f7edb00780dbc3fe55af8835e1a05f6cfdae73ad6328544f5a7d4d295ee2233"
    //     "99dc4cdb66e087051fb4fb74b59265f003481edc67ccca179c56fbfb98ba9369c90f56ccd52e77b8fd74a1c6cb5140d730784aed2f61934c0b911b0f045a8c19158cfc1f2f8b19f3b12b7f39d4180b728b5f1dc6ab5b39c56a0dfe17bc241f76f15fcc3f0584d26a01541ecf40720f4be89e8229e1b19bc3d34fe1cda551e07adf564c11232f7f17b5f8b85696de9345b689fdf9e70a590787799de56de3eb22d3d55445a58dfae4553705fde7ea0e893bdf8cb008e6ef6afeec4b8932ed83";
    String data = "0038000600260119b3803ffe0c1c376b4ba0129fb77cba34717a9587bdc34ce5bcd6b3938e0d024acfc14008b7091c9ccbeb55bf431a94278f2b";
    var bytes = Uint8List.fromList(hex2Bytes(data));
    var back = (await _sxdPlugin.parse19(bytes));
    setState(() => (_log += "$back\n"));
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
    setState(() => (_log += "$platformVersion\n"));
  }
}
