import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'homeScreen.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key, required this.websiteUrl});

  final String websiteUrl;

  @override
  _ViewScreenState createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  late bool _isLoadingPage;
  // final Completer<WebViewController> _completer =
  //     Completer<WebViewController>();
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            if (await _webViewController.canGoBack()) {
              _webViewController.goBack();
              return false;
            } else {
              return _onBackButtonPressed(context);
            }
          },
          // onWillPop: () => _onBackButtonPressed(context),
          child: Stack(
            children: [
              WebView(
                initialUrl: widget.websiteUrl,
                javascriptMode: JavascriptMode.unrestricted,
                // onWebViewCreated: (WebViewController controller) {
                //   _completer.complete(controller);
                // },
                onWebViewCreated: (WebViewController controller) {
                  _webViewController = controller;
                },

                onPageFinished: (String finish) async {
                  setState(() => _isLoadingPage = false);
                },
                zoomEnabled: false,
                // gestureRecognizers: Set()
                //   ..add(
                //     Factory<VerticalDragGestureRecognizer>(
                //         () => VerticalDragGestureRecognizer()
                //           ..onDown = (DragDownDetails dragDownDetails) {
                //             _webViewController.getScrollY().then((value) {
                //               if (value == 0 &&
                //                   dragDownDetails.globalPosition.direction <
                //                       1) {
                //                 _webViewController.reload();
                //               }
                //             });
                //           }),
                //   ),
                // gestureNavigationEnabled: false,
                navigationDelegate: (NavigationRequest request) {
                  print(request.url);
                  if (request.url.startsWith("tel") ||
                      request.url.startsWith("mailto")) {
                    _launchURL(request.url);
                    return NavigationDecision.prevent;
                  } else if (request.url.startsWith("https://brlakgec.com/")) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (route) => false);
                    return NavigationDecision.prevent;
                  } else {
                    return NavigationDecision.navigate;
                  }
                },
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
      ),
    );
  }

  Future<bool> _onBackButtonPressed(BuildContext context) async {
    bool? exitApp = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Really ??"),
            content: const Text("Do you want to exit the portal ?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () {
                  // Navigator.of(context)
                  //     .pushNamedAndRemoveUntil("/welcome", ModalRoute.withName('/welcome'));
                  //     },
                  Navigator.of(context).pop(true);
                },
                child: const Text("Yes"),
              ),
            ],
          );
        });
    return exitApp ?? false;
  }

  @override
  void initState() {
    super.initState();
    _isLoadingPage = true;
  }
}

_launchURL(String url) async {
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    throw 'Could not launch $url';
  }
}
