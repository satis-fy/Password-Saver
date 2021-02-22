import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:password_saver/AddPassword.dart';
import 'package:password_saver/DatabaseHelper.dart';
import 'package:password_saver/PasswordModel.dart';
import 'package:sqflite/sqflite.dart';
import 'Extra.dart';

class ShowPassword extends StatefulWidget {
  final int id;

  ShowPassword(this.id);

  @override
  State<StatefulWidget> createState() {
    return ShowPasswordMain(this.id);
  }
}

class ShowPasswordMain extends State<ShowPassword> {
  final int id;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<PasswordModel> passwordList;
  int count = 0;

  ShowPasswordMain(this.id);

  @override
  Widget build(BuildContext context) {
    if (passwordList == null) {
      passwordList = List<PasswordModel>();
    }
    updateListview();

    return Scaffold(
      appBar: AppBar(
        title: Text("Password"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            moveToLastScreen();
          },
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 30),
        children: <Widget>[FromListWidget()],
      ),
    );
  }

  void navigateToAddpassword() async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddPassword(this.id, "Edit Password", passwordList[0].companyname);
    }));
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

  String getUsernameText() {
    if (this.passwordList[0].username == null) {
      return " ";
    } else {
      return this.passwordList[0].username;
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

  void CopyText(String message) {
    Clipboard.setData(new ClipboardData(text: message));
  }

  void ToastMessage() {
    Fluttertoast.showToast(
      msg: "Copy",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
    );
  }

  String showPassword() {
    int c = this.passwordList[0].password.length;
    String p = "*";
    for (int i = 1; i < c; i++) {
      p = p + "*";
    }
    return p;
  }

  Widget FromListWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 40),
        Center(
          child: ClipOval(
            child: Image.asset(getImagePath(this.passwordList[0].companyname),
                height: 80.0, width: 80.0, fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 30),

        //Wrap
        Wrap(
          children: <Widget>[
            Container(
                alignment: Alignment.topLeft,
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 20),
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
                child: getFirstContainerWidget()),
          ],
        ),

        SizedBox(height: 20),

        TwoButton(),

        SizedBox(height: 30),
        //Over Wrap
      ],
    );
  }

  Widget getFirstContainerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //TITLE
        Padding(
          padding: EdgeInsets.only(top: 30, left: 50),
          child: Text(
            "TITLE",
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              fontFamily: "Calibri",
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 50),
              child: Text(
                this.passwordList[0].title,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Calibri",
                ),
              ),
            ),
            IconButton(
              tooltip: "Copy",
              onPressed: () {
                CopyText(this.passwordList[0].title);
                ToastMessage();
              },
              icon: Icon(
                Icons.content_copy,
                color: Colors.grey[700],
                size: 20.0,
              ),
            ),
          ],
        ),

        //USERNAME
        UsernameShow(),

        //PASSWORD
        Padding(
          padding: EdgeInsets.only(top: 30, left: 50),
          child: Text(
            "PASSWORD",
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              fontFamily: "Calibri",
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 50),
              child: Text(
                showPassword(),
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Calibri",
                ),
              ),
            ),
            IconButton(
              tooltip: "Copy",
              onPressed: () {
                CopyText(this.passwordList[0].password);
                ToastMessage();
              },
              icon: Icon(
                Icons.content_copy,
                color: Colors.grey[700],
                size: 20.0,
              ),
            ),
          ],
        ),

        //MOBILENUMBER
        MobilenumberShow(),

        //WEBSITE
        WebsiteShow(),

        //NOTES
        NotesShow(),
      ],
    );
  }

  Widget UsernameShow() {
    if (this.passwordList[0].username != '') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30, left: 50),
            child: Text(
              "USERNAME",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                fontFamily: "Calibri",
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 50),
                child: Text(
                  this.passwordList[0].username,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Calibri",
                  ),
                ),
              ),
              IconButton(
                tooltip: "Copy",
                onPressed: () {
                  CopyText(this.passwordList[0].username);
                  ToastMessage();
                },
                icon: Icon(
                  Icons.content_copy,
                  color: Colors.grey[700],
                  size: 20.0,
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Visibility(
        visible: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30, left: 50),
              child: Text(
                "USERNAME",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Calibri",
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 50),
                  child: Text(
                    this.passwordList[0].username,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Calibri",
                    ),
                  ),
                ),
                IconButton(
                  tooltip: "Copy",
                  onPressed: () {
                    CopyText(this.passwordList[0].username);
                    ToastMessage();
                  },
                  icon: Icon(
                    Icons.content_copy,
                    color: Colors.grey[700],
                    size: 20.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  Widget MobilenumberShow() {
    if (this.passwordList[0].mobilenumber != '') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30, left: 50),
            child: Text(
              "MOBILE NUMBER",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                fontFamily: "Calibri",
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 50),
                child: Text(
                  this.passwordList[0].mobilenumber,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Calibri",
                  ),
                ),
              ),
              IconButton(
                tooltip: "Copy",
                onPressed: () {
                  CopyText(this.passwordList[0].mobilenumber);
                  ToastMessage();
                },
                icon: Icon(
                  Icons.content_copy,
                  color: Colors.grey[700],
                  size: 20.0,
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Visibility(
        visible: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30, left: 50),
              child: Text(
                "MOBILE NUMBER",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Calibri",
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 50),
                  child: Text(
                    this.passwordList[0].mobilenumber,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Calibri",
                    ),
                  ),
                ),
                IconButton(
                  tooltip: "Copy",
                  onPressed: () {
                    CopyText(this.passwordList[0].mobilenumber);
                    ToastMessage();
                  },
                  icon: Icon(
                    Icons.content_copy,
                    color: Colors.grey[700],
                    size: 20.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  Widget WebsiteShow() {
    if (this.passwordList[0].website != '') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30, left: 50, bottom: 0),
            child: Text(
              "WEBSITE",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                fontFamily: "Calibri",
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 50),
                child: Text(
                  this.passwordList[0].website,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Calibri",
                  ),
                ),
              ),
              IconButton(
                tooltip: "Copy",
                onPressed: () {
                  CopyText(this.passwordList[0].website);
                  ToastMessage();
                },
                icon: Icon(
                  Icons.content_copy,
                  color: Colors.grey[700],
                  size: 20.0,
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Visibility(
        visible: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30, left: 50, bottom: 0),
              child: Text(
                "WEBSITE",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Calibri",
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 50),
                  child: Text(
                    this.passwordList[0].website,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Calibri",
                    ),
                  ),
                ),
                IconButton(
                  tooltip: "Copy",
                  onPressed: () {
                    CopyText(this.passwordList[0].website);
                    ToastMessage();
                  },
                  icon: Icon(
                    Icons.content_copy,
                    color: Colors.grey[700],
                    size: 20.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  Widget NotesShow() {
    if (this.passwordList[0].notes != '') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30, left: 50),
            child: Text(
              "NOTES",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                fontFamily: "Calibri",
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 50),
                child: Text(
                  this.passwordList[0].notes,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Calibri",
                  ),
                ),
              ),
              IconButton(
                tooltip: "Copy",
                onPressed: () {
                  CopyText(this.passwordList[0].notes);
                  ToastMessage();
                },
                icon: Icon(
                  Icons.content_copy,
                  color: Colors.grey[700],
                  size: 20.0,
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Visibility(
        visible: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30, left: 50),
              child: Text(
                "NOTES",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Calibri",
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 50),
                  child: Text(
                    this.passwordList[0].notes,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Calibri",
                    ),
                  ),
                ),
                IconButton(
                  tooltip: "Copy",
                  onPressed: () {
                    CopyText(this.passwordList[0].notes);
                    ToastMessage();
                  },
                  icon: Icon(
                    Icons.content_copy,
                    color: Colors.grey[700],
                    size: 20.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  Widget TwoButton() {
    return Row(
      children: <Widget>[

        Expanded(
          child: Bouncing(
            onPress: () {
              navigateToEditpassword();
            },
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Text( "UPDATE",
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
                color: Colors.blueAccent,
              ),
            ),
          ),
        ),

        Expanded(
          child: Bouncing(
            onPress: () {
              setState(() {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Delete Password"),
                    content: Text("Do you want to delete this password?"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            _deletePassword(context);
                          });
                        },
                        child: Text("YES"),
                      ),
                    ],
                  ),
                );
              });
            },
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Text( "DELETE",
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
                color: Colors.redAccent,
              ),
            ),
          ),
        ),

      ],
    );
  }

  void navigateToEditpassword() async {
    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddPassword(
          this.passwordList[0].id, "Edit Password", this.passwordList[0].companyname);
    }));

    if (result == true) {
      updateListview();
    }
  }

  void _deletePassword(BuildContext context) async{
    int result = await databaseHelper.deletePassword(this.passwordList[0].id);
    moveToLastScreen();
    moveToLastScreen();
  }
  void moveToLastScreen() {
    Navigator.pop(context);
  }

}
