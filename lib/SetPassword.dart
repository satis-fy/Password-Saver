import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:password_saver/AllPassword.dart';
import 'package:password_saver/DatabaseHelper.dart';
import 'package:password_saver/PasswordCheck.dart';
import 'package:password_saver/PsaveModel.dart';
import 'package:password_saver/main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'Extra.dart';

class SetPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SetPassword2();
  }
}

class SetPassword2 extends State<SetPassword> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  String passcode1;
  String passcode2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 80),
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(), // new
          children: <Widget>[
            ListWidget(),
          ],
        ),
      ),
    );
  }

  Widget ListWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        ClipOval(
          child: Image.asset('images/lock.png',
              height: 70.0, width: 70.0, fit: BoxFit.cover),
        ),

        SizedBox(height: 30,),
        Text(
          "Welcome",
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: "Calibri",
          ),
        ),
        SizedBox(height: 5),
        Text(
          "set PIN to continue!",
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: "Calibri",
          ),
        ),

        SizedBox(height: 50),

        Text(
          "   NEW PIN",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: "Calibri",
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.all(10),
          child: PinCodeTextField(
            textInputType: TextInputType.number,
            length: 4,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.circle,
              borderRadius: BorderRadius.circular(1),
              fieldHeight: 60,
              fieldWidth: 50,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
            ),
            onChanged: (value) {
              debugPrint("Hello PIN ${value}");
            },
            onCompleted: (value) {
              passcode1 = value;
            },
          ),
        ),

        SizedBox(height: 20),

        Text(
          "   REPEAT PIN",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: "Calibri",
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.all(10),
          child: PinCodeTextField(
            textInputType: TextInputType.number,
            length: 4,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.circle,
              borderRadius: BorderRadius.circular(1),
              fieldHeight: 60,
              fieldWidth: 50,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
            ),
            onChanged: (value) {
              debugPrint("Hello PIN ${value}");
            },
            onCompleted: (value) {
              passcode2 = value;
            },
          ),
        ),

        SizedBox(height: 30),

        //RaiseButton
        Bouncing(
          onPress: () {
            setState(() {
              ConfirmPasscode();
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            width: double.infinity, // <-- match_parent
            child: Text(
              "Continue",
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
      ],
    );
  }


  void ConfirmPasscode() {

    if(passcode1 == null){
      ToastEmpty();
    }

    if (passcode1 != passcode2) {
      ToastError();
    } else if(passcode1 == passcode2 && passcode1.length !=0 && passcode2.length != 0) {
      _Insert();
    }else{
      ToastError();
    }

  }

  void ToastError() {
    Fluttertoast.showToast(
      msg: "PIN not match",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  void ToastEmpty() {
    Fluttertoast.showToast(
      msg: "Enter PIN",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  void _Insert() async {
    PsaveModel psaveModel = new PsaveModel(passcode1);
    int result = await databaseHelper.insertPasscode(psaveModel);
    navigateToMainScreen();
  }

  void navigateToMainScreen() async {
    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PasswordCheck();
    }));

  }


}
