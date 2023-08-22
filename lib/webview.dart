// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
// class WebviewScreen extends StatefulWidget {
//   const WebviewScreen({Key? key}) : super(key: key);
//
//   @override
//   State<WebviewScreen> createState() => _WebviewScreenState();
// }
//
// InAppWebViewController? inAppWebViewController;
// PullToRefreshController? pullToRefreshController;
// var url = "https://reloadbrl.netlify.app/";
// var initialUrl = "https://www.google.com/";
// double pg = 0;
//
// class _WebviewScreenState extends State<WebviewScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     pullToRefreshController = PullToRefreshController(
//         onRefresh: () {
//           inAppWebViewController!.reload();
//         },
//         options: PullToRefreshOptions(
//           color: Colors.white,
//           backgroundColor: Colors.black,
//         ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () async {
//               if (await inAppWebViewController!.canGoBack()) {
//                 inAppWebViewController!.goBack();
//               }
//             },
//             icon: Icon(Icons.arrow_back_ios)),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 inAppWebViewController!.reload();
//               },
//               icon: Icon(Icons.refresh))
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//               child: InAppWebView(
//             onLoadStop: ((controller, url) {
//               pullToRefreshController!.endRefreshing();
//             }),
//             pullToRefreshController: pullToRefreshController,
//             onWebViewCreated: ((controller) =>
//                 inAppWebViewController = controller),
//             onLoadStart: ((controller, url) {
//               var v = url.toString();
//             }),
//             initialUrlRequest: URLRequest(url: Uri.parse(initialUrl)),
//           ))
//         ],
//       ),
//     );
//   }
// }
