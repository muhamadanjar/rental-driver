import 'package:driver/models/auth_mode.dart';
import 'package:driver/models/responseapi.dart';
import 'package:driver/scope/main_model.dart';
import 'package:driver/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:driver/models/http_exception.dart';
import 'package:scoped_model/scoped_model.dart';
class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
    // _heightAnimation.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text('An Error Occurred!'),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
    );
  }

  Future<void> _submit(Function authenticate) async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    
    try {
      ResponseApi responseApi =  await authenticate(_authData['email'], _authData['password'], _authMode);

    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: 260,
        constraints: BoxConstraints(minHeight: 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return new Validations().validateEmail(value);
                    
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    return new Validations().validatePassword(value);
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                
                SizedBox(
                  height: 20,
                ),
                ScopedModelDescendant<MainModel>(
                  builder: (BuildContext context, Widget child, MainModel model) {
                    return SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                        onPressed: () => _submit(model.authenticate),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                        color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).primaryTextTheme.button.color,
                      ),
                    );
                  },
                )
                
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}