import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key, required this.websiteUrl});

  final String websiteUrl;

  @override
  _ViewScreenState createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  late bool _isLoadingPage;
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(''),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            WebView(
              initialUrl: widget.websiteUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController controller) {
                _completer.complete(controller);
              },
              onPageFinished: (String finish) =>
                  setState(() => _isLoadingPage = false),
            ),
            if (_isLoadingPage)
              Container(
                alignment: FractionalOffset.center,
                child: const CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  color: Colors.white,
                ),
              )
            else
              Container(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _isLoadingPage = true;
  }
}
