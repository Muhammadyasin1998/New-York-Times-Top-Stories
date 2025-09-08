// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class ArticleWebViewPage extends StatefulWidget {
//   final String url;
//   final String title;

//   const ArticleWebViewPage({
//     super.key,
//     required this.url,
//     required this.title,
//   });

//   @override
//   State<ArticleWebViewPage> createState() => _ArticleWebViewPageState();
// }

// class _ArticleWebViewPageState extends State<ArticleWebViewPage> {
//   late final WebViewController _controller;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (_) => setState(() => _isLoading = true),
//           onPageFinished: (_) => setState(() => _isLoading = false),
//         ),
//       )
//       ..loadRequest(Uri.parse(widget.url));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title, maxLines: 1, overflow: TextOverflow.ellipsis),
//       ),
//       body: Stack(
//         children: [
//           WebViewWidget(controller: _controller),
//           if (_isLoading)
//             const Center(
//               child: CircularProgressIndicator(),
//             ),
//         ],
//       ),
//     );
//   }
// }
