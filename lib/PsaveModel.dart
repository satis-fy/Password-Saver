class PsaveModel {
  int _id;
  String _password;

  PsaveModel(this._password,[this._id]);


  int get id => _id;

  String get password => _password;


  set id(int value) {
    _id = value;
  }

  set password(String value) {
    _password = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }
    map['password'] = _password;
    return map;
  }

  PsaveModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._password = map['password'];
  }




}