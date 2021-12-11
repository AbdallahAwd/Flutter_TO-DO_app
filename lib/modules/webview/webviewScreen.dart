import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/shared/Cubit/Cubit.dart';
import 'package:learning/shared/Cubit/states.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {

  final String url;

  WebViewScreen(this.url);
  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar:AppBar(),
          body: WebView(
            initialUrl: url,
          ),
        );

  }
}
