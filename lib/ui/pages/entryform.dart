import 'package:driver/models/auth.dart';
import 'package:flutter/material.dart';

class EntryForm extends StatefulWidget {
  final Auth contact;

  EntryForm(this.contact);

  @override
  EntryFormState createState() => EntryFormState(this.contact);
}
//class controller
class EntryFormState extends State<EntryForm> {
  Auth contact;

  EntryFormState(this.contact);

  TextEditingController accessController = TextEditingController();
  TextEditingController refreshController = TextEditingController();  

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (contact != null) {
      accessController.text = contact.accessToken;
      refreshController.text = contact.refreshToken;
    }
    //rubah
    return Scaffold(
      appBar: AppBar(
        title: contact == null ? Text('Tambah') : Text('Rubah'),
        leading: Icon(Icons.keyboard_arrow_left),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left:10.0, right:10.0),
        child: ListView(
          children: <Widget> [
            // nama
            Padding (
              padding: EdgeInsets.only(top:20.0, bottom:20.0),
              child: TextField(
                controller: accessController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Access Token',             
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {                  
                  //                                                    
                },
              ),
            ),

            // telepon
            Padding (
              padding: EdgeInsets.only(top:20.0, bottom:20.0),
              child: TextField(
                controller: refreshController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Refresh',                
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {                  
                  //
                },
              ),
            ),

            // tombol button
            Padding (
              padding: EdgeInsets.only(top:20.0, bottom:20.0),
              child: Row(
                children: <Widget> [
                  // tombol simpan
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        if (contact == null) {
                          // tambah data
                          contact = Auth(name: accessController.text,refreshToken: refreshController.text);
                        } else {
                          // ubah data
                          contact.accessToken = accessController.text;
                          contact.refreshToken = refreshController.text;
                        }
                        // kembali ke layar sebelumnya dengan membawa objek contact
                        Navigator.pop(context, contact);
                      },
                    ),
                  ),
                  Container(width: 5.0,),
                  // tombol batal
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Cancel',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}