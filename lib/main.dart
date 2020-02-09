import 'package:driver/scope/main_model.dart';
import 'package:driver/ui/pages/auth.dart';
import 'package:driver/ui/pages/dashboard.dart';
import 'package:driver/ui/pages/notfound.dart';
import 'package:driver/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    _model.autoAuthenticate();
    _model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          RoutePaths.Index: (BuildContext context) => !_isAuthenticated ? AuthPage() : DashboardPage(_model),
        },
        onUnknownRoute: (RouteSettings setting) {
          // String unknownRoute = setting.name;
          return new MaterialPageRoute(builder: (context) => NotFoundPage());
        }
      ), 
    );
  }
}


