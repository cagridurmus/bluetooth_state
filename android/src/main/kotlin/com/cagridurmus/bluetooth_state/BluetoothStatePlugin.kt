package com.cagridurmus.bluetooth_state

import android.app.Activity
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothManager
import android.content.Context
import android.content.Intent
import android.os.Build
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** BluetoothStatePlugin */
class BluetoothStatePlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var bluetoothAdapter : BluetoothAdapter
  private lateinit var channel : MethodChannel
  private lateinit var mActivity: Activity
  private val REQUEST_ENABLE_BLUETOOTH = 1337
  private var pendingResultForActivityResult: Result? = null
  private val REQUEST_DISCOVERABLE_BLUETOOTH = 2137



  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.cagridurmus/bluetooth_state")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if(bluetoothAdapter == null && !"isAvailable".equals(call.method)){
      result.error("bluetooth_unavailable","the device does not have bluetooth", null)
    }
    when(call.method){
      "isAvailable" -> result.success(bluetoothAdapter != null)
      "isEnabled" -> isBluetoothEnable()
      "requestEnableBluetooth" -> requestEnableBluetooth(result)
      "requestDisableBluetooth" -> requestDisableBluetooth(result)
    }
  }

  private fun isBluetoothEnable(): Boolean {
    return bluetoothAdapter.isEnabled
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun requestEnableBluetooth(@NonNull result: Result){
    if (!bluetoothAdapter.isEnabled){
      pendingResultForActivityResult = result
      val intent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
      ActivityCompat.startActivityForResult(mActivity, intent, REQUEST_ENABLE_BLUETOOTH, null)
    }
  }

  private fun requestDisableBluetooth(@NonNull result: Result){
    if (bluetoothAdapter.isEnabled){
      bluetoothAdapter.disable()
    }
  }

  override fun onAttachedToActivity(@NonNull binding: ActivityPluginBinding) {

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {this.mActivity = binding.activity
      val bluetoothManager =
        mActivity.getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager

      this.bluetoothAdapter = bluetoothManager.adapter
      binding.addActivityResultListener { requestCode, resultCode, data ->
        when (requestCode) {
          REQUEST_ENABLE_BLUETOOTH -> {
            if (pendingResultForActivityResult != null) {
              pendingResultForActivityResult!!.success(resultCode !== 0)
            }
            return@addActivityResultListener true
          }
          REQUEST_DISCOVERABLE_BLUETOOTH -> {
            pendingResultForActivityResult?.success(if (resultCode === 0) -1 else resultCode)
            return@addActivityResultListener true
          }
          else -> return@addActivityResultListener false
        }
      }
    } else {
      TODO("VERSION.SDK_INT < JELLY_BEAN_MR2")
    }

  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }
}
