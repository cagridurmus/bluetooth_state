
import 'bluetooth_state_platform_interface.dart';

class BluetoothState {

  Future<void> requestDisableBluetooth() => BluetoothStatePlatform.instance.requestDisableBluetooth();

  Future<void> requestEnableBluetooth() => BluetoothStatePlatform.instance.requestEnableBluetooth();

  Future<bool> get isBluetoothEnable => BluetoothStatePlatform.instance.isBluetoothEnable;
}
