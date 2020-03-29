import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class MenuWebView extends StatefulWidget {
  final String url;
  final String title;
  MenuWebView({Key key, @required this.url, @required this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MenuWebViewState(this.url, this.title);
  }
}

class _MenuWebViewState extends State<MenuWebView> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String url;
  String title;

  _MenuWebViewState(String url, String title) {
    this.url = url;
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
        url: url,
        appBar: new AppBar(
          title: new Text(title),
        ));
  }
}

