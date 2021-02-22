import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_saver/AddPassword.dart';
import 'package:password_saver/PasswordCheck.dart';
import 'package:password_saver/PasswordModel.dart';
import 'package:password_saver/SetPassword.dart';
import 'package:password_saver/getListviewItem.dart';

class AllPassword extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return AllPassword2();
  }
}

class AllPassword2 extends State<AllPassword> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onBackPressed(); // Action to perform on back pressed
        return false;
      },
      child:Scaffold(
        bottomSheet: Padding(
          padding: EdgeInsets.only(bottom: 70),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddPassword(null,"Add Password",'Google');
            }));
          },
          backgroundColor: Colors.blue,
          label: Text("Add Password"),
          icon: Icon(Icons.add),
          elevation: 8.0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 100),
                Row(
                  children: <Widget>[

                    Text.rich(
                      TextSpan(
                        text: "Password Saver",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: 'Calibri',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            wordSpacing: 5),
                      ),
                      style: TextStyle(fontSize: 35.0),
                    ),
                    SizedBox(width: 10),


                    //Icon(Icons.security),
                  ],
                ),

                //ListItem


                getListviewItem(),

                //ListeItem..
                SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),

    );
  }


  void onBackPressed() {
    //Exit Full App
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

}