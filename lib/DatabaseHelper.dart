import 'dart:async';
import 'dart:io';
import 'package:password_saver/PasswordModel.dart';
import 'package:password_saver/PsaveModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database;

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  String passwordTable = "password_table";
  String colId = "id";
  String colCompanyname = "companyname";
  String colTitle = "title";
  String colUsername = "username";
  String colPassword = "password";
  String colMobileNumber = "mobilenumber";
  String colWebsite = "website";
  String colNotes = "notes";

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get databse async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'password.db';

    var passwordDatabase =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return passwordDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        ''' CREATE TABLE $passwordTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT, 
            $colCompanyname TEXT,
            $colTitle TEXT,
            $colUsername TEXT,
            $colPassword TEXT,
            $colMobileNumber TEXT,
            $colWebsite TEXT,
            $colNotes TEXT)  ''');

    await db.execute(
        ''' CREATE TABLE psave_table (id INTEGER PRIMARY KEY AUTOINCREMENT, 
            password TEXT)  ''');
  }

  //Get Data From Table
  Future<List<Map<String, dynamic>>> getPasswordMapList() async {
    Database db = await this.databse;

    var result =
    await db.rawQuery("SELECT * FROM $passwordTable ORDER BY $colId DESC");
    return result;
  }

  Future<int> insertPassword(PasswordModel passwordModel) async {
    Database db = await this.databse;
    var result = await db.insert(passwordTable, passwordModel.toMap());
    return result;
  }

  Future<int> updatePassword(PasswordModel passwordModel) async {
    Database db = await this.databse;
    var result = await db.update(passwordTable, passwordModel.toMap(),
        where: '$colId = ?', whereArgs: [passwordModel.id]);
    return result;
  }

  Future<int> deletePassword(int id) async {
    Database db = await this.databse;
    var result =
    await db.rawDelete("DELETE FROM $passwordTable WHERE $colId = $id");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.databse;
    List<Map<String, dynamic>> x =
    await db.rawQuery("SELECT COUNT(*) FROM $passwordTable");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<PasswordModel>> getPasswordList() async {
    var passwordMapList = await getPasswordMapList();
    int count = passwordMapList.length;

    List<PasswordModel> passwordList = List<PasswordModel>();
    for(int i=0;i< count; i++){
      passwordList.add(PasswordModel.fromMapObject(passwordMapList[i]));
    }
    return passwordList;
  }

  Future<List<Map<String, dynamic>>> getPasswordMapListSelected(int id) async {
    Database db = await this.databse;

    var result =
    await db.rawQuery("SELECT * FROM $passwordTable WHERE id = '${id}' ");
    return result;
  }

  Future<List<PasswordModel>> getPasswordListSelected(int id) async {
    var passwordMapList = await getPasswordMapListSelected(id);
 //   int count = passwordMapList.length;

    List<PasswordModel> passwordList = List<PasswordModel>();
//    for(int i=0;i< count; i++){
      passwordList.add(PasswordModel.fromMapObject(passwordMapList[0]));
  //  }
    return passwordList;
  }


  //Passcode Saver
//Get Data From Table
  Future<List<Map<String, dynamic>>> getPasscodeMapList() async {
    Database db = await this.databse;

    var result =
    await db.rawQuery("SELECT * FROM psave_table");
    return result;
  }

  Future<int> insertPasscode(PsaveModel psaveModel) async {
    Database db = await this.databse;
    var result = await db.insert("psave_table", psaveModel.toMap());
    return result;
  }

  Future<int> getPasscodeCount() async {
    Database db = await this.databse;
    List<Map<String, dynamic>> x =
    await db.rawQuery("SELECT COUNT(*) FROM psave_table");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<PsaveModel>> getPasscodeList() async {
    var passcodeMapList = await getPasscodeMapList();
    int count = passcodeMapList.length;

    List<PsaveModel> passwordList = List<PsaveModel>();
    for(int i=0;i< count; i++){
      passwordList.add(PsaveModel.fromMapObject(passcodeMapList[i]));
    }
    return passwordList;
  }

}



