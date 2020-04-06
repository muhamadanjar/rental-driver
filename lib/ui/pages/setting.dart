import 'package:cached_network_image/cached_network_image.dart';
import 'package:driver/scope/main_model.dart';
import 'package:driver/ui/pages/change_password.dart';
import 'package:driver/ui/themes/styles.dart';
import 'package:driver/ui/views/base_view.dart';
import 'package:driver/ui/views/view_ubahpass.dart';
import 'package:driver/ui/widgets/ui_elements/logout_list_tile.dart';
import 'package:driver/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import 'accessToken.dart';
class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengaturan"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Akun",
              style: headerStyle,
            ),
            Card(
              elevation: 0.5,
              margin: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 0,
              ),
              child: Column(
                children: <Widget>[
                  BaseView<MainModel>(
                    builder:(BuildContext context,Widget child,MainModel model) {
                      String email = model.user != null ? model.user.email : 'User Driver';
                      String noAnggota = model.account != null ? (model.account != null ? (model.account.noAnggota != null ? model.account.noAnggota:'No Anggota') :'No Anggota') :'No Anggota';
                      
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(defaultImage),
                      ),
                      title: Text(email),
                      subtitle: Text(noAnggota),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AccessTokenPage(model)));
                      },
                    );
                    }
                  ),
                  _buildDivider(),
                  InkWell(
                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => ChangePassword())),
                    child: ListTile(
                      title: Text("Ubah Password"),
                      trailing: Icon(FontAwesomeIcons.caretRight),
                    ),
                  ),
                ],
              ),
            ),
            
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0,),
              child: LogoutListTile())
          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade300,
    );
  }
}


class SettingViewPage extends StatelessWidget {
  final String page;

  const SettingViewPage({Key key, this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(16),
        child: page == 'ubahpwd' ? ViewUbahPassword():Container(),
      ),
    );
  }
}