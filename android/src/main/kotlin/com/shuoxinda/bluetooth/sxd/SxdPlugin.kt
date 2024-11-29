package com.shuoxinda.bluetooth.sxd

import android.util.Log

import com.alibaba.fastjson.JSONObject
import com.shuoxinda.bluetooth.sxd.protocal.proUtil.ProtocolTool
import com.shuoxinda.bluetooth.sxd.protocal.Param;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** SxdPlugin */
class SxdPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "sxd")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        try {
            when (call.method) {
                "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
                "setDatalogerByP0x18" -> setDatalogerByP0x18(call.arguments as HashMap<String, Any>, result)
                "parserPro0x18" -> parserPro0x18(call.arguments as ByteArray, result)
                "setDatalogerByP0x19" -> getDatalogerByP0x19(call.arguments as HashMap<String, Any>, result)
                "parserPro0x19" -> parserPro0x19(call.arguments as ByteArray, result)
                else -> result.notImplemented()
            }
        } catch (e: Exception) {
            Log.e("TTT", "e:${e.message}")
        }
    }

    private fun setDatalogerByP0x18(map: HashMap<String, Any>, res: Result) {
        ProtocolTool.setDatalogerByP0x18(JSONObject(map)) {
            res.success(it)
        }
    }

    private fun parserPro0x18(msg: ByteArray, res: Result) {
        ProtocolTool.parserPro0x18(msg) {
            res.success(it)
        }
    }

    private fun getDatalogerByP0x19(map: HashMap<String, Any>, res: Result) {
        ProtocolTool.getDatalogerByP0x19(JSONObject(map)) {
            res.success(it)
        }
    }

    private fun parserPro0x19(msg: ByteArray, res: Result) {
//        var str = ""
//        msg.map { str += String.format("%02X", it) }
//
//        Log.e("TTT", str)
//        val data =
//            "01280006011e0119cc4c5f3d2845525c7b8243dbfcfe198af1256ccfb42524416a16b49ea0cddc2254a1975c35c00ab3e1612c3515bb7e5b0f1f2720c606df289950227fdd460680751688b49771fb01ca12224c92c260d6ac63dcfe6b8219fe4bb7971a3c27214a1186a6beaf5855bd102045c1b3ab1bd203f82d6a8d5ac53e9279c1926c69e2f653c7c32705754988adbf30d9a3303a6a2392f6afcf07a1f300e46581ac12bf2511bce64bc0827a81055c4a8c2731d984651db63fb92e38c91e10bad3239f4745c80d1156a0fdd30fd08d7db975778adfd25414f71df64bb42260ae5f7454ec0b6d88d9b5d117e1b58c765e9e5f4ee57938a304d9032cad72a964da03d40226b28855b2515858e2b66d9328ca19ca031fb666a6e89e381a60d9491aa522ecd647";

//        val jsonHelp = JsonHelp(Param::class.java)

        ProtocolTool.parserPro0x19(msg) { back ->
            val ddData = mutableListOf<HashMap<String, Any>>()
            (back as ArrayList<Param>?)?.forEach() {
                val map = HashMap<String, Any>()
                map["length"] = it.length
                map["paramNo"] = it.paramNo
                map["bytes"] = it.bytes.toIntList()
                ddData.add(map)
            }
            res.success(ddData)
        }
    }

    private fun ByteArray.toIntList(): List<Int> {
        val list = mutableListOf<Int>()
        this.forEach { list.add(it.toMyInt()) }
        return list
    }

    private fun Byte.toMyInt(): Int = (this.toInt() and 0xFF)

//    private fun ByteArray.toHexString(): String {
//        return joinToString(separator = "") { it.toString(16).padStart(2, '0') }
//    }
//
//    private fun hexStringToByteArray(hexString: String): ByteArray {
//        val cleanedHex = hexString.replace(" ", "")
//        val bytes = ByteArray(cleanedHex.length / 2)
//        for (i in cleanedHex.indices step 2) {
//            val hexPair = cleanedHex.substring(i, i + 2)
//            bytes[i / 2] = hexPair.toInt(16).toByte()
//        }
//        return bytes
//    }
}
