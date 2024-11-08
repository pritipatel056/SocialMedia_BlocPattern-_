import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'MessageScreen.dart';

class LockScreen extends StatefulWidget {
  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final TextEditingController _pinController = TextEditingController();
  final storage = FlutterSecureStorage();
  String? savedPin;

  @override
  void initState() {
    super.initState();
    _loadPin();
  }

  Future<void> _loadPin() async {
    savedPin = await storage.read(key: 'pin');
    if (savedPin == null) {
      await storage.write(key: 'pin', value: '1234');  // Default PIN for demo
      savedPin = '1234';
    }
  }

  void _checkPin() {
    if (_pinController.text == savedPin) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MessageScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Incorrect PIN'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter PIN")),
      body: Center(

        child: Container(
          margin: new EdgeInsets.all(15.0), // Or set whatever you want
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,


            children: [
              TextField(
                controller: _pinController,
                decoration: InputDecoration(labelText: 'PIN'),
                keyboardType: TextInputType.number,
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: _checkPin,
                child: Text("Unlock"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
