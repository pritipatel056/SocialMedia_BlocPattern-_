import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<String> messages = ["This is my account no - 1323456342673", "Pin is  -7736561242", "IFSC-  78637812633"];
  Map<String, Timer?> messageTimers = {};

  @override
  void initState() {
    super.initState();
    _startTimers();
  }

  void _startTimers() {
    for (var message in messages) {
      messageTimers[message] = Timer(Duration(seconds: 3), () {
        setState(() {
          messages.remove(message);
        });
      });
    }
  }

  @override
  void dispose() {
    for (var timer in messageTimers.values) {
      timer?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Messages")),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(messages[index]),
          );
        },
      ),
    );
  }
}
