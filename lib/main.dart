import 'package:driver/scope/main_model.dart';
import 'package:driver/ui/pages/auth.dart';
import 'package:driver/ui/pages/dashboard2.dart';
import 'package:driver/ui/pages/notfound.dart';
import 'package:driver/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/services.dart';
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
      print(isAuthenticated);
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.deepOrange
    ));
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Driver Utama Trans',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          RoutePaths.Index: (BuildContext context) => !_isAuthenticated ? AuthPage() : DashboardTwoPage(),
        },
        onUnknownRoute: (RouteSettings setting) {
          // String unknownRoute = setting.name;
          return new MaterialPageRoute(builder: (context) => NotFoundPage());
        }
      ), 
    );
  }
}


