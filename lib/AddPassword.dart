import 'package:flutter/material.dart';
import 'package:password_saver/DatabaseHelper.dart';
import 'package:password_saver/PasswordModel.dart';
import 'package:sqflite/sqflite.dart';

import 'Extra.dart';

class AddPassword extends StatefulWidget {
  final String appBarTitle;
  final int id;
  String  _companyNameSelectedItem ;

  AddPassword(this.id, this.appBarTitle,this._companyNameSelectedItem);

  @override
  State<StatefulWidget> createState() {
    return InsertPassword(this.id, this.appBarTitle,this._companyNameSelectedItem);
  }
}

class InsertPassword extends State<AddPassword> {
  String appBarTitle;
  final int id;
  PasswordModel passwordModel = null;
  String  _companyNameSelectedItem ;


  DatabaseHelper databaseHelper = DatabaseHelper();

  InsertPassword(this.id, this.appBarTitle,this._companyNameSelectedItem);

  var _passwordVisible = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  List<PasswordModel> passwordList;
  int count = 0;
  var _companyName = ['Google','Facebook','Twitter','Linkedin','Amazon','Instagram','Email','Others'];

  @override
  Widget build(BuildContext context) {

    //get Selected data from database
    if (passwordList == null) {
      passwordList = List<PasswordModel>();
      updateListview();
    }

    if(this.id != null) {
      titleController.text = passwordList[0].title;
      usernameController.text = passwordList[0].username;
      passwordController.text = passwordList[0].password;
      mobileNumberController.text = passwordList[0].mobilenumber;
      websiteController.text = passwordList[0].website;
      notesController.text = passwordList[0].notes;
    }



    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            moveToLastScreen();
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30),
        children: <Widget>[
          SizedBox(height: 40),
          Form(
            key: formkey,
            child: FromListWidget(),
          ),
        ],
      ),
    );
  }



  Widget FromListWidget() {
    final node = FocusScope.of(context);

    return Column(
      children: <Widget>[

        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "COMPANY NAME",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              decoration: TextDecoration.none,
              fontFamily: 'Calibri',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

       DropdownButton<String>(
            items: _companyName.map((String   dropdownStringIten){
              return DropdownMenuItem<String>(
                value: dropdownStringIten,
                child: Text(dropdownStringIten),
              );
            }).toList(),
          onChanged: (String newValueSelected){
              setState(() {
                _companyNameSelectedItem = newValueSelected;
              });
              /*setState(() {
                _companyNameSelectedItem = newValueSelected;
                passwordList[0].companyname = newValueSelected;
              });*/
          },
         value: _companyNameSelectedItem,
         hint: Text("Select Company"),
         isExpanded: true,
        ),

        SizedBox(height: 40),

        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "TITLE",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              decoration: TextDecoration.none,
              fontFamily: 'Calibri',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextFormField(
            maxLines: 1,
            controller: titleController,
            style: TextStyle(
              fontFamily: 'Calibri',
              fontSize: 18.0,
            ),
            onChanged: (value) {
              passwordList[0].title = titleController.text;
              passwordModel.title = titleController.text;
            },
            textInputAction: TextInputAction.next,
            onEditingComplete: () => node.nextFocus(),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "e.g. Google Work",
            ),
            validator: (value) =>
                value.isEmpty ? "Field can't be empty" : null),
        SizedBox(height: 40),

        //Username
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "USERNAME",
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              decoration: TextDecoration.none,
              fontFamily: 'Calibri',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextField(
          maxLines: 1,
          onChanged: (value) {
            passwordList[0].username = usernameController.text;
            passwordModel.username = usernameController.text;
          },

          controller: usernameController,
          style: TextStyle(
            fontFamily: 'Calibri',
            fontSize: 18.0,
          ),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onEditingComplete: () => node.nextFocus(),
          decoration: InputDecoration(
            hintText: "e.g. abc@mail.com",
          ),
        ),
        SizedBox(height: 40),

        //Password
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "PASSWORD",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              decoration: TextDecoration.none,
              fontFamily: 'Calibri',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextFormField(
            maxLines: 1,
            controller: passwordController,
            onChanged: (value) {
              passwordList[0].password = passwordController.text;
              passwordModel.password = passwordController.text;
            },
            style: TextStyle(
              fontFamily: 'Calibri',
              fontSize: 18.0,
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => node.nextFocus(),
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
              hintText: "password",
              suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  }),
            ),
            validator: (value) =>
                value.isEmpty ? "Field can't be empty" : null),
        SizedBox(height: 40),

        //MobileNumber
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "MOBILE NUMBER",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              decoration: TextDecoration.none,
              fontFamily: 'Calibri',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextField(
          maxLines: 1,
          controller: mobileNumberController,
          onChanged: (value) {
            passwordList[0].mobilenumber = mobileNumberController.text;
            passwordModel.mobilenumber = mobileNumberController.text;
          },
          style: TextStyle(
            fontFamily: 'Calibri',
            fontSize: 18.0,
          ),
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          onEditingComplete: () => node.nextFocus(),
          decoration: InputDecoration(
            hintText: "e.g. 98756 87645",
          ),
        ),
        SizedBox(height: 40),

        //Website
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "WEBSITE",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              decoration: TextDecoration.none,
              fontFamily: 'Calibri',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextField(
          maxLines: 1,
          controller: websiteController,
          onChanged: (value) {
            passwordList[0].website = websiteController.text;
            passwordModel.website = websiteController.text;
          },
          style: TextStyle(
            fontFamily: 'Calibri',
            fontSize: 18.0,
          ),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          onEditingComplete: () => node.nextFocus(),
          decoration: InputDecoration(
            hintText: "e.g. www.google.com",
          ),
        ),
        SizedBox(height: 40),

        //Notes
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "NOTES",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              decoration: TextDecoration.none,
              fontFamily: 'Calibri',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextField(
          maxLines: 2,
          onChanged: (value) {
            passwordList[0].notes = notesController.text;
            passwordModel.notes = notesController.text;
          },
          controller: notesController,
          style: TextStyle(
            fontFamily: 'Calibri',
            fontSize: 18.0,
          ),
          decoration: InputDecoration(
            hintText: "notes",
          ),
        ),
        SizedBox(height: 40),

        //RaiseButton
        Bouncing(
          onPress: () {
            setState(() {
              _ValidateCheck();
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            width: double.infinity, // <-- match_parent
            child: Text(
              _RaisedButtonText(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Calibri',
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
            ),
          ),
        ),

        SizedBox(height: 50),
      ],
    );
  }

  void _ValidateCheck() {
    if (formkey.currentState.validate()) {
      _Save();
    }
  }

  void updateListview() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((value) {
      Future<List<PasswordModel>> passwordListFuture =
      databaseHelper.getPasswordListSelected(this.id);
      passwordListFuture.then((value) {
        setState(() {
          this.passwordList = value;
          this.count = passwordList.length;
        });
      });
    });
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }


  void _Save() async {

    int result;
    if (_RaisedButtonText() == "Update Password") {

      passwordList[0].companyname = _companyNameSelectedItem;
      //Update Operation
      result = await databaseHelper.updatePassword(passwordList[0]);
    } else {
      passwordModel = new PasswordModel(_companyNameSelectedItem,titleController.text, passwordController.text,usernameController.text,mobileNumberController.text,websiteController.text,notesController.text);
      //Insert Operation
      result = await databaseHelper.insertPassword(passwordModel);
    }
    moveToLastScreen();

    /* if (result != 0) {
      //Success
      _showAlertDialog('Status', 'Password Saved Successfully');
    } else {
      //Failed
      _showAlertDialog('Status', 'Problem Saving Password');
    }*/
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  String _RaisedButtonText() {
    if (appBarTitle == "Add Password") {
      return "Save Password";
    } else {
      return "Update Password";
    }
  }


}
