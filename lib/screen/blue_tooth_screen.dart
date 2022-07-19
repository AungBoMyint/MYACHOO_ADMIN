import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BlueToothPrintScreen extends StatefulWidget {
  @override
  _BlueToothPrintScreenState createState() => _BlueToothPrintScreenState();
}

class _BlueToothPrintScreenState extends State<BlueToothPrintScreen> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> _devices = [];
  String _deviceMsg = "Blue Device";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => {initPrinter()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BluetoothPrint example app'),
      ),
      body: _devices.isNotEmpty ? ListView.builder(
                  itemCount: _devices.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_devices[index].name ?? ""),
                      subtitle: Text(_devices[index].address ?? ""),
                    );
                  },
                ) : Center(child: Text(_deviceMsg))
    );
  }

  //Initialize Printer
  Future<void> initPrinter() async {
    try {
      bluetoothPrint.startScan(timeout: Duration(seconds: 30));
    } on PlatformException catch (e) {
      debugPrint("Please tun on bluetooth.");
    }
    if (!mounted) return;
    bluetoothPrint.scanResults.listen((event) {
      if (!mounted) return;
      setState(() {
        _devices = event;
      });
      if (_devices.isEmpty) {
        setState(() {
          _deviceMsg = "No Devices...";
        });
      }
    });
  }
}
