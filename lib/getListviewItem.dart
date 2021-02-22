import 'dart:async';

import 'package:flutter/material.dart';
import 'package:password_saver/AddPassword.dart';
import 'package:password_saver/DatabaseHelper.dart';
import 'package:password_saver/PasswordModel.dart';
import 'package:password_saver/ShowPassword.dart';
import 'package:sqflite/sqflite.dart';

class getListviewItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return getListviewItem2();
  }
}

class getListviewItem2 extends State<getListviewItem> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<PasswordModel> passwordList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (passwordList == null) {
      passwordList = List<PasswordModel>();
      //updateListview();
    }
    updateListview();

    return getListview();
  }

  ListView getListview() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Container(
          margin: EdgeInsets.only(top: 20),
          child: InkWell(
            child: Stack(
              children: <Widget>[
                SizedBox(height: 40),
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 12,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 30,
                  child: ClipOval(
                    child: Image.asset(getImagePath(this.passwordList[position].companyname),
                        height: 45.0, width: 45.0, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 100,
                  child: Text(
                    this.passwordList[position].title,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Calibri",
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 100,
                  child: Text(
                    _UsernameText(position),
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Calibri",
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              navigateToShowpassword(this.passwordList[position],position);
            },
          ),
        );
      },
    );
  }

  void navigateToAddpassword(PasswordModel passwordModel) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddPassword(
          passwordModel.id, "Edit Password", passwordModel.companyname);
    }));

    if (result == true) {
      updateListview();
    }
  }

  void navigateToShowpassword(PasswordModel passwordModel,int index) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ShowPassword(this.passwordList[index].id);
    }));

    if (result == true) {
      updateListview();
    }
  }

  void updateListview() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((value) {
      Future<List<PasswordModel>> passwordListFuture =
          databaseHelper.getPasswordList();
      passwordListFuture.then((value) {
        setState(() {
          this.passwordList = value;
          this.count = passwordList.length;
        });
      });
    });
  }

  String _UsernameText(int index) {
    if (passwordList[index].username == null) {
      return "";
    } else {
      return passwordList[index].username;
    }
  }

  String getImagePath(String companyName) {
    if (companyName == "Google") {
      return 'images/google.png';
    } else if (companyName == 'Facebook') {
      return 'images/facebook.png';
    } else if (companyName == 'Twitter') {
      return 'images/twitter.png';
    } else if (companyName == 'Linkedin') {
      return 'images/linkedin.png';
    } else if (companyName == 'Amazon') {
      return 'images/amazon.png';
    } else if (companyName == 'Instagram') {
      return 'images/instagram.png';
    } else if (companyName == 'Email') {
      return 'images/email.png';
    } else {
      return 'images/lock.png';
    }
  }
}
