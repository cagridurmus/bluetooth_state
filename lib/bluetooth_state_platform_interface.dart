import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'bluetooth_state_method_channel.dart';

abstract class BluetoothStatePlatform extends PlatformInterface {
  /// Constructs a BluetoothStatePlatform.
  BluetoothStatePlatform() : super(token: _token);

  static final Object _token = Object();

  static BluetoothStatePlatform _instance = MethodChannelBluetoothState();

  /// The default instance of [BluetoothStatePlatform] to use.
  ///
  /// Defaults to [MethodChannelBluetoothState].
  static BluetoothStatePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BluetoothStatePlatform] when
  /// they register themselves.
  static set instance(BluetoothStatePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> requestEnableBluetooth() {
    throw UnimplementedError('requestEnableBluetooth() has not been implemented.');
  }

  Future<void> requestDisableBluetooth() {
    throw UnimplementedError('disableEnableBluetooth() has not been implemented.');
  }

  Future<bool> get isBluetoothEnable {
    throw UnimplementedError('isBluetoothEnable has not been implemented.');
  }

}
