import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'bluetooth_state_platform_interface.dart';

/// An implementation of [BluetoothStatePlatform] that uses method channels.
class MethodChannelBluetoothState extends BluetoothStatePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('com.cagridurmus/bluetooth_state');

  @override
  Future<void> requestEnableBluetooth() async {
    await methodChannel.invokeMethod('requestEnableBluetooth');
  }

  @override
  Future<bool> get isBluetoothEnable async{
    return await methodChannel.invokeMethod('isBluetoothEnable');
  }

  @override
  Future<void> requestDisableBluetooth() async {
    await methodChannel.invokeMethod('requestDisableBluetooth');
  }
}
