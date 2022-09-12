import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisho_app/assets/constants.dart' as Constants;
import 'package:jisho_app/bloc/history_bloc.dart';
import 'package:jisho_app/bloc/history_event.dart';
import 'package:jisho_app/historyview.dart';
import 'package:jisho_app/model/history.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late WebViewController _controller;

  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  // WebView naviation
  // See: https://stackoverflow.com/a/63540436
  Future<bool> _onWillPop(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
          // TODO: Make button rectangular & move to draw, radicals menu
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(context: context, builder: (_) => const HistoryView());
            },
            backgroundColor: Colors.orange,
            child: const Icon(Icons.history),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          body: SafeArea(
            child: WebView(
              initialUrl: Constants.jishoUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controllerCompleter.future
                    .then((value) => _controller = value);
                _controllerCompleter.complete(webViewController);
              },
              onPageStarted: (url) {
                // Add search to history
                if (url.startsWith(Constants.jishoSearchUrl) ||
                    url.startsWith(Constants.jishoWordUrl)) {
                  context.read<HistoryBloc>().add(AddHistory(
                      WebHistory(url: url, visited: DateTime.now())));
                }
                // TODO: Show loading screen or no connection info
                // print("hey");
              },
              onPageFinished: (url) {
                // print("finished");
              },
            ),
          )),
    );
  }
}
