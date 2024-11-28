package com.shuoxinda.bluetooth.sxd

import android.util.Log
import com.alibaba.fastjson.JSONObject
import com.shuoxinda.bluetooth.protocal.proUtil.ProtocolTool
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
                "parserPro0x18" -> parserPro0x18(call.arguments as String, result)
                "setDatalogerByP0x19" -> getDatalogerByP0x19(call.arguments as HashMap<String, Any>, result)
                "parserPro0x19" -> parserPro0x19(call.arguments as String, result)
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

    private fun parserPro0x18(msg: String, res: Result) {
        ProtocolTool.parserPro0x18(msg.toByteArray()) {
            res.success(it)
        }
    }

    private fun getDatalogerByP0x19(map: HashMap<String, Any>, res: Result) {
        ProtocolTool.getDatalogerByP0x19(JSONObject(map)) {
            res.success(it)
        }
    }

    private fun parserPro0x19(msg: String, res: Result) {
        ProtocolTool.parserPro0x19(msg.toByteArray()) {
            res.success(it)
        }
    }
}
