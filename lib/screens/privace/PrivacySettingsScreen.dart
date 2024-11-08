// screens/privacy_settings_screen.dart
import 'package:flutter/material.dart';

import 'model/PrivacyOption.dart';

class PrivacySettingsScreen extends StatefulWidget {
  @override
  _PrivacySettingsScreenState createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  // List of privacy options
  List<PrivacyOption> privacyOptions = [
    PrivacyOption(title: "Last seen & online", subtitle: "Who can see your last seen and online status", value: "Everyone"),
    PrivacyOption(title: "Profile photo", subtitle: "Who can see your profile photo", value: "My contacts"),
    PrivacyOption(title: "About", subtitle: "Who can see your about info", value: "Everyone"),
    PrivacyOption(title: "Groups", subtitle: "Who can add you to groups", value: "Everyone"),
    PrivacyOption(title: "Status", subtitle: "Who can see your status updates", value: "My contacts"),
    PrivacyOption(title: "Blocked", subtitle: "List of contacts you have blocked", value: "74 contacts"),
    PrivacyOption(title: "Default message timer", subtitle: "Set new chats with disappearing messages timer", value: "Off"),
  ];

  // Function to show selection dialog
  void _showOptionDialog(PrivacyOption option) async {
    String? newValue = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text("Select Privacy Level"),
          children: ["Everyone", "My contacts", "Nobody"].map((String choice) {
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, choice);
              },
              child: Text(choice),
            );
          }).toList(),
        );
      },
    );

    if (newValue != null) {
      setState(() {
        option.value = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Privacy")),
      body: ListView.builder(
        itemCount: privacyOptions.length,
        itemBuilder: (context, index) {
          final option = privacyOptions[index];
          return ListTile(
            title: Text(option.title),
            subtitle: Text(option.subtitle),
            trailing: Text(option.value),
            onTap: () => _showOptionDialog(option),
          );
        },
      ),
    );
  }

}
