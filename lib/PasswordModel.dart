class PasswordModel {
  int _id;
  String _companyname;
  String _title;
  String _username ;
  String _password;
  String _mobilenumber;
  String _website;
  String _notes;

  PasswordModel(this._companyname,this._title, this._password,
      [this._username, this._mobilenumber, this._website, this._notes]);

  PasswordModel.withId(this._id,this._companyname, this._title, this._password,
      [this._username, this._mobilenumber, this._website, this._notes]);

  String get notes => _notes;

  String get website => _website;

  String get mobilenumber => _mobilenumber;

  String get password => _password;

  String get username => _username;

  String get title => _title;

  String get companyname => _companyname;

  int get id => _id;

  set notes(String value) {
    if (value.length <= 100) {
      _notes = value;
    }
  }

  set website(String value) {
    if (value.length <= 50) {
      _website = value;
    }
  }

  set mobilenumber(String value) {
    if (value.length <= 50) {
      _mobilenumber = value;
    }
  }

  set password(String value) {
    if (value.length <= 50) {
      _password = value;
    }
  }

  set username(String value) {
    if (value.length <= 50) {
      _username = value;
    }
  }

  set title(String value) {
    if (value.length <= 50) {
      _title = value;
    }
  }

  set companyname(String value) {
    if (value.length <= 50) {
      _companyname = value;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }

    map['companyname'] = _companyname;
    map['title'] = _title;
    map['username'] = _username;
    map['password'] = _password;
    map['mobilenumber'] = _mobilenumber;
    map['website'] = _website;
    map['notes'] = _notes;
    return map;
  }

  PasswordModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._companyname = map['companyname'];
    this._title = map['title'];
    this._username = map['username'];
    this._password = map['password'];
    this._mobilenumber = map['mobilenumber'];
    this._website = map['website'];
    this._notes = map['notes'];
  }
}

/*void _delete(BuildContext context,PasswordModel passwordModel) async{
  int result = await databaseHelper.deletePassword(passwordModel.id);
  updateListview();
}
GestureDetector
*/


/*Positioned(
top: 55,
left: 50,
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
Align(
alignment: Alignment(0.9,-0.85),
child: IconButton(
tooltip: "Copy",
onPressed: (){
CopyText(this.passwordList[0].title);
ToastMessage();
},
icon: Icon(Icons.content_copy,
color: Colors.grey[700],
size: 20.0,),
),
),*/
