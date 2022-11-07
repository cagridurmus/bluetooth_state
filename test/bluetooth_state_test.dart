import 'package:flutter_test/flutter_test.dart';
import 'package:bluetooth_state/bluetooth_state.dart';
import 'package:bluetooth_state/bluetooth_state_platform_interface.dart';
import 'package:bluetooth_state/bluetooth_state_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBluetoothStatePlatform
    with MockPlatformInterfaceMixin
    implements BluetoothStatePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BluetoothStatePlatform initialPlatform = BluetoothStatePlatform.instance;

  test('$MethodChannelBluetoothState is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBluetoothState>());
  });

  test('getPlatformVersion', () async {
    BluetoothState bluetoothStatePlugin = BluetoothState();
    MockBluetoothStatePlatform fakePlatform = MockBluetoothStatePlatform();
    BluetoothStatePlatform.instance = fakePlatform;

    expect(await bluetoothStatePlugin.getPlatformVersion(), '42');
  });
}
