import 'package:driver/models/auth.dart';
import 'package:driver/scope/main_model.dart';
import 'package:flutter/material.dart';
//letak package folder flutter
import 'package:driver/ui/pages/entryform.dart';
import 'package:driver/utils/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
//untuk memanggil fungsi yg terdapat di daftar pustaka sqflite
import 'dart:async';
//pendukung program asinkron

class HomePage extends StatefulWidget {
  final MainModel model;
  HomePage(this.model);
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {

  DBHelper dbHelper = DBHelper();
  int count = 0;
  List<Auth> contactList;

  @override
  void initState() {
    updateListView();
    super.initState();
  }   

  @override
  Widget build(BuildContext context) {
    if (contactList == null) {
      contactList = List<Auth>();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Data-Data'),
      ),
      body: createListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Tambah Data',
        onPressed: () async {
          var contact = await navigateToEntryForm(context, null);
          if (contact != null) addContact(contact);
        },
      ),
    );
  }

  Future<Auth> navigateToEntryForm(BuildContext context, Auth contact) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return EntryForm(contact);
        }
      ) 
    );
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.people),
            ),
            title: Text(this.contactList[index].name == null ? "No Name":this.contactList[index].name, style: textStyle,),
            subtitle: Text(this.contactList[index].accessToken),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
                deleteContact(contactList[index]);
              },   
            ),
            onTap: () async {
              var contact = await navigateToEntryForm(context, this.contactList[index]);
              if (contact != null) editContact(contact);
            },
          ),
        );
      },
    );
  }
  //buat contact
  void addContact(Auth object) async {
    int result = await dbHelper.insert(object);
    if (result > 0) {
      updateListView();
    }
  }
    //edit contact
  void editContact(Auth object) async {
    int result = await dbHelper.update(object);
    if (result > 0) {
      updateListView();
    }
  }
    //delete contact
  void deleteContact(Auth object) async {
    int result = await dbHelper.delete(object.id);
    if (result > 0) {
      updateListView();
    }
  }
    //update contact
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Auth>> contactListFuture = dbHelper.getAuthList();
      contactListFuture.then((contactList) {
        print(contactList);
        setState(() {
          this.contactList = contactList;
          this.count = contactList.length;
        });
      });
    });
  }

}