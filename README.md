# bluetooth_state

A Plugin Flutter Bluetooth turn off/on 

## Getting Started
### Install
Add the following lines in your pubspec.yaml file

```yaml
  bluetooth_state: ^latest_version
```

### API
#### Is Bluetooth Enable
```dart
Future<bool> get isBluetoothEnable async {
  try {
    return await BluetoothState().isBluetoothEnable;
  } catch (e) {
    print(e);
    throw 'Failed to get is bluetooth enable';
  }
}
```
#### Request Enable Bluetooth
```dart
Future<void> requestEnableBluetooth() async {
  try {
    await BluetoothState.requestEnableBluetooth();
  } catch (e) {
    print(e);
    throw 'Failed to request enable bluetooth';
  }
}
```
#### Request Disable Bluetooth
```dart
Future<void> requestDisableBluetooth() async {
  try {
    await BluetoothState.requestDisableBluetooth();
  } catch (e) {
    print(e);
    throw 'Failed to request disable bluetooth';
  }
}
```

