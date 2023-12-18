import 'dart:convert';

import 'package:admin_panel/constants/constants.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _body = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _title,
              decoration: const InputDecoration(hintText: "Notification Title"),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextFormField(
              controller: _body,
              decoration: const InputDecoration(hintText: "Notification body"),
            ),
            const SizedBox(
              height: 12.0,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_body.text.isNotEmpty && _title.text.isNotEmpty) {
                    sendNotificationToAllUsers(
                        appProvider.getUsersToken, _title.text, _body.text);
                    _title.clear();
                    _body.clear();
                  } else {
                    showMessage("Fill the Details");
                  }
                },
                child: const Text("Send Notification!"))
          ],
        ),
      ),
    );
  }
}

Future<void> sendNotificationToAllUsers(
    List<String?> usersToken, String title, String body) async {
  List<String> newAllUserToken = [];
  List<String> allUserToken = [];

  for (var element in usersToken) {
    if (element != null || element != "") {
      newAllUserToken.add(element!);
    }
  }
  allUserToken = newAllUserToken;
// Replace 'YOUR_SERVER_KEY' with your Firebase Cloud Messaging server key
  const String serverkey =
      'AAAA20vkR1M:APA91bH4Q1iG31c6lemc6y5U2kzICzQfXAiIPH7vG7q8yeNAdig8Imh47fpzuHqjbxibpl7-ktFnlVV9wMJtJ-lagqVh5ZECKM_vQuUHsLkHGUxJ5WW6hZryvN5YkzKGYzbJ-O6SoaJQ';

  const String firebaseUrl = 'https://fcm.googleapis.com/fcm/send';

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key= $serverkey',
  };

  final Map<String, dynamic> notification = {
    'title': title,
    'body': body,
  };

  final Map<String, dynamic> requestBody = {
    'notification': notification,
    'priority': 'high',
    'registration_ids': allUserToken,
  };
  final encodedBody = jsonEncode(requestBody);

  final http.Response response = await http.post(
    Uri.parse(firebaseUrl),
    headers: headers,
    body: encodedBody,
  );

  if (response.statusCode == 200) {
    print('Notification sent successfully.');
  } else {
    print('Notification sending failed with status: ${response.statusCode}');
  }
}
