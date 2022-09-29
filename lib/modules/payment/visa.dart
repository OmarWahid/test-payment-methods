import 'dart:async';

import 'package:flutter/material.dart';
import 'package:payment_c6/shared/common/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../shared/common/components.dart';
import '../register/register.dart';

class VisCard extends StatelessWidget {

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                exit(context);
              },
            )
          ],
        ),
        body: WebView(
          initialUrl:
              '$FRAME_URL$PAYMENT_FINAL_TOKEN_VISA',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onProgress: (int progress) {
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          backgroundColor: const Color(0x00000000),
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
  void exit(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Are you sure complete Payment?',
            style: TextStyle(
              color: Colors.teal,
              fontSize: 14,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                NavigateAndFinish(
                  context,
                   RegisterScreen(),
                );
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'No',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
