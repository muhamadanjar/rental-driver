import 'package:flutter/material.dart';
import 'package:driver/ui/style/custom_text.dart';
import 'package:driver/ui/widgets/form_inputs/custom_registration_button.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordState();
  }
}

class _ChangePasswordState extends State<ChangePassword> {
  String _oldPassword, _newPassword, _rePassword;
  bool _obscureTextOld = true;
  bool _obscureTextNew = true;
  bool _obscureTextRe = true;

  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue,
          elevation: 0.0,
          title:
              Text("Ubah Password", style: TextStyle(color: Colors.white)),
        ),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Password Lama",
                        style: CustomText.medium12,
                      ),
                    ),
                    TextFormField(
                      obscureText: _obscureTextOld,
                      onSaved: (val) => _oldPassword = val,
                      decoration: InputDecoration(
                          hintStyle: CustomText.regular13Grey,
                          fillColor: Theme.of(context).primaryColor,
                          hintText: 'Masukkan password lama',
                          suffixIcon: IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () {
                                setState(() {
                                  _obscureTextOld = !_obscureTextOld;
                                });
                              })),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Password Baru",
                        style: CustomText.medium12,
                      ),
                    ),
                    TextFormField(
                      obscureText: _obscureTextNew,
                      onSaved: (val) => _newPassword = val,
                      decoration: InputDecoration(
                          hintStyle: CustomText.regular13Grey,
                          fillColor: Theme.of(context).primaryColor,
                          hintText: 'Masukkan password baru',
                          suffixIcon: IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () {
                                setState(() {
                                  _obscureTextNew = !_obscureTextNew;
                                });
                              })),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Kata sandi minimal 8 karakter, Wajib menggunakan minimal satu huruf kapital dan angka atau tanda baca ",
                        style: CustomText.regular10Grey,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        "Ulangi Password Baru",
                        style: CustomText.medium12,
                      ),
                    ),
                    TextFormField(
                      obscureText: _obscureTextRe,
                      onSaved: (val) => _rePassword = val,
                      decoration: InputDecoration(
                          hintStyle: CustomText.regular13Grey,
                          fillColor: Theme.of(context).primaryColor,
                          hintText: 'Ulangi password baru',
                          suffixIcon: IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () {
                                setState(() {
                                  _obscureTextRe = !_obscureTextRe;
                                });
                              })),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        _showDialog();
                      },
                      child: CustomRegistrationButton("UBAH PASSWORD", true),
                    ),
                  ),
                )
              ],
            )));
  }

  // user defined function
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(margin: EdgeInsets.only(top: 32),child: Image.asset("assets/images/ic_dialog_success_01.png"),),
              Container(margin: EdgeInsets.only(top: 32, bottom: 32),child: Text("Password Berhasil Disimpan", style: CustomText.medium16,),)
            ],
          ),
        );
      },
    );
  }
}
