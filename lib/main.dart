import 'package:flutter/material.dart';
import 'package:password_saver/DatabaseHelper.dart';
import 'package:password_saver/PasswordCheck.dart';
import 'package:password_saver/PsaveModel.dart';
import 'package:password_saver/SetPassword.dart';
import 'package:sqflite/sqflite.dart';


void main() {
  runApp(
    MaterialApp(
      title: "Password Saver",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: myHomePage(),
    ),
  );
}

class myHomePage extends StatefulWidget {
  @override
  _myHomePageState createState() => _myHomePageState();
}

class _myHomePageState extends State<myHomePage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<PsaveModel> passwordList;
  int count = 1;


  @override
  Widget build(BuildContext context) {

    if (passwordList == null) {
      passwordList = List<PsaveModel>();
    }

    return getPasscode();
  }

  Widget FirstScreen(){
    if(passwordList.isNotEmpty){
      return PasswordCheck();
    }

    if(passwordList.isEmpty ){
      return SetPassword();
    }
  }

  Widget getPasscode() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((value) {
      Future<List<PsaveModel>> passwordListFuture =
      databaseHelper.getPasscodeList();
      passwordListFuture.then((value) {
        setState(() {
          this.passwordList = value;
          this.count = passwordList.length;
        });
      }
      );

    }
    );

    return FirstScreen();
  }
}


