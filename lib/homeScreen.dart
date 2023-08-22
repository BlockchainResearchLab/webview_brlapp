import 'package:brl_webview/viewScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  var websiteUrl = "https://www.google.com/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: InkWell(
            onTap: () async => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewScreen(
                        websiteUrl: "https://reloadbrl.netlify.app/"))),
            child: Text("Launch  Website")),
      )),
    );
  }
}
