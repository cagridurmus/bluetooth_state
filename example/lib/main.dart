import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:bluetooth_state/bluetooth_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _bluetoothStatePlugin = BluetoothState();
  bool _stateBluetooth = false;
  @override
  void initState() {
    super.initState();
    isBluetoothEnable;
  }

  Future<bool?> get isBluetoothEnable async{
    bool isEnable;
    try{
      isEnable = await _bluetoothStatePlugin.isBluetoothEnable;
    }on PlatformException{
      isEnable = false;

    }
    setState(() {
      _stateBluetooth = isEnable;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> requestEnableBluetooth() async {

    try {
          await _bluetoothStatePlugin.requestEnableBluetooth();
    } on PlatformException {
      print("xxxx");
    }
    if (!mounted) return;

  }

  Future<void> requestDisableBluetooth() async {

    try {

      await _bluetoothStatePlugin.requestDisableBluetooth();
    } on PlatformException {
      print("xxxx");
    }
    if (!mounted) return;

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Center(
              child: Text('Genel'),
            ),
            SwitchListTile(
                title: Text("Enable/Disable Bluetooth"),
                value: _stateBluetooth,
                onChanged: (value){
                  if(_stateBluetooth){
                    requestDisableBluetooth();
                  }
                  else{
                    requestEnableBluetooth();
                  }
                  setState(() {
                    _stateBluetooth = value;
                  });
                }
            ),
            Text(_stateBluetooth.toString())
          ],
        )
      ),
    );
  }
}
