# sxd

NKY-SDK插件

## Getting Started

```
  将指令18内容发送给此方法，返回加密指令
  Future<List<int>?> setDatalogerByP0x18(Map<String, dynamic> map);

  将指令18内容发送给此方法，返回加密指令
  Future<List<int>?> setDatalogerByP0x19(Map<String, dynamic> map);

  解析指令18返回的数据，进行二次封装，返回Map类型数据
  Future<Map<String, dynamic>> parse18(Uint8List hex);

  解析指令18返回的数据，直接返回原生解析的数据，不进行二次封装
  Future<dynamic> parse18ByOrigin(Uint8List hex);

  解析指令19返回的数据，进行二次封装，返回Map类型数据
  Future<Map<String, dynamic>> parse19(Uint8List hex);

  解析指令19返回的数据，直接返回原生解析的数据，不进行二次封装
  Future<dynamic> parse19ByOrigin(Uint8List hex);
```
