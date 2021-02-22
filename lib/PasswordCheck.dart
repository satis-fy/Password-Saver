import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:password_saver/AllPassword.dart';
import 'package:password_saver/DatabaseHelper.dart';
import 'package:password_saver/PsaveModel.dart';
import 'package:sqflite/sqlite_api.dart';
import 'Extra.dart';

class PasswordCheck extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PasswordCheck2();
  }
}

class PasswordCheck2 extends State<PasswordCheck> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<PsaveModel> passwordList;
  String checkpassword = "";
  int count = 1;
  String PINimage1 = 'images/dot2.png';
  String PINimage2 = 'images/dot2.png';
  String PINimage3 = 'images/dot2.png';
  String PINimage4 = 'images/dot2.png';



  @override
  Widget build(BuildContext context) {

    if (passwordList == null) {
      passwordList = List<PsaveModel>();
      getPasscode();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
            padding: EdgeInsets.only(left: 30,right: 30,bottom: 30),
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
        SizedBox(height: 80),
        Center(
          child: ClipOval(
            child: Image.asset('images/lock.png',
                height: 100.0, width: 100.0, fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 30),
        Center(
            child: Text(
          "ENTER PIN",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            fontFamily: "Calibri",
          ),
        )),
        SizedBox(height: 20,),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset(
                PINimage1,
                height: 15.0,
                width: 15.0,
                fit: BoxFit.cover,
              ),
              Image.asset(
                PINimage2,
                height: 15.0,
                width: 15.0,
                fit: BoxFit.cover,
              ),
              Image.asset(
                PINimage3,
                height: 15.0,
                width: 15.0,
                fit: BoxFit.cover,
              ),
              Image.asset(
                PINimage4,
                height: 15.0,
                width: 15.0,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),

        SizedBox(height: 50),

        tenButton(),

        SizedBox(height: 55),
        Center(
          child:  Bouncing(
            onPress: () {},
            child: Text( "Forgot PIN?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Calibri',
                ),
            ),
          ),
        ),

      ],
    );
  }

  Widget tenButton(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        Container(
          margin: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              Bouncing(
                onPress: () {},
                child:MaterialButton(
                  color: Colors.blue,
                  shape: CircleBorder(),
                  onPressed: () {
                    setState(() {
                      ChangePinIcon(1);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      '1',
                      style: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'Calibri'),
                    ),
                  ),
                ),
              ),
              Bouncing(
                onPress: () {
                  setState(() {
                    ChangePinIcon(2);
                  });
                },
                child:MaterialButton(
                  color: Colors.blue,
                  shape: CircleBorder(),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      '2',
                      style: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'Calibri'),
                    ),
                  ),
                ),
              ),
              Bouncing(
                onPress: () {
                  setState(() {
                    ChangePinIcon(3);
                  });
                },
                child:MaterialButton(
                  color: Colors.blue,
                  shape: CircleBorder(),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      '3',
                      style: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'Calibri'),
                    ),
                  ),
                ),
              ),

            ],
          ),

        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              Bouncing(
                onPress: () {
                  setState(() {
                    ChangePinIcon(4);
                  });
                },
                child:MaterialButton(
                  color: Colors.blue,
                  shape: CircleBorder(),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      '4',
                      style: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'Calibri'),
                    ),
                  ),
                ),
              ),
              Bouncing(
                onPress: () {
                  setState(() {
                    ChangePinIcon(5);
                  });
                },
                child:MaterialButton(
                  color: Colors.blue,
                  shape: CircleBorder(),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      '5',
                      style: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'Calibri'),
                    ),
                  ),
                ),
              ),
              Bouncing(
                onPress: () {
                  setState(() {
                    ChangePinIcon(6);
                  });
                },
                child:MaterialButton(
                  color: Colors.blue,
                  shape: CircleBorder(),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      '6',
                      style: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'Calibri'),
                    ),
                  ),
                ),
              ),

            ],
          ),

        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              Bouncing(
                onPress: () {},
                child:MaterialButton(
                  color: Colors.blue,
                  shape: CircleBorder(),
                  onPressed: () {
                    setState(() {
                      ChangePinIcon(7);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      '7',
                      style: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'Calibri'),
                    ),
                  ),
                ),
              ),
              Bouncing(
                onPress: () {
                  setState(() {
                    ChangePinIcon(8);
                  });
                },
                child:MaterialButton(
                  color: Colors.blue,
                  shape: CircleBorder(),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      '8',
                      style: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'Calibri'),
                    ),
                  ),
                ),
              ),
              Bouncing(
                onPress: () {
                  setState(() {
                    ChangePinIcon(9);
                  });
                },
                child:MaterialButton(
                  color: Colors.blue,
                  shape: CircleBorder(),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      '9',
                      style: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'Calibri'),
                    ),
                  ),
                ),
              ),

            ],
          ),

        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              Bouncing(
                onPress: () {
                  setState(() {
                    ChangePinIcon(0);
                  });
                },
                child:MaterialButton(
                  color: Colors.blue,
                  shape: CircleBorder(),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      '0',
                      style: TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold,fontFamily: 'Calibri'),
                    ),
                  ),
                ),
              ),


            ],
          ),

        ),

      ],
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }

  void ChangePinIcon(int number){

    if(count == 1){
      checkpassword = checkpassword + '${number.toString()}' ;
      PINimage1 = 'images/dot.png';
      count++;
    }else if(count == 2){
      checkpassword = checkpassword + '${number.toString()}' ;
      PINimage2 = 'images/dot.png';
      count++;
    }
    else if(count == 3){
      checkpassword = checkpassword + '${number.toString()}' ;
      PINimage3 = 'images/dot.png';
      count++;
    }else if(count == 4){
      checkpassword = checkpassword +'${number.toString()}' ;
      PINimage4 = 'images/dot.png';
      count++;
      if(this.passwordList[0].password == checkpassword){
        navigateToMainScreen();
      }
      else{
        count = 1;
        PINimage1 = 'images/dot2.png';
        PINimage2 = 'images/dot2.png';
        PINimage3 = 'images/dot2.png';
        PINimage4 = 'images/dot2.png';
        checkpassword = "";
      }
    }


  }

  void getPasscode() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((value) {
      Future<List<PsaveModel>> passwordListFuture =
      databaseHelper.getPasscodeList();
      passwordListFuture.then((value) {
        setState(() {
          this.passwordList = value;
          this.count = passwordList.length;
        });
      });
    });
  }


  void navigateToMainScreen() async {
    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AllPassword();
    }));
  }
}
