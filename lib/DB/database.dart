import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:examtpflutter/DB/model/users.dart';
import 'package:examtpflutter/DB/model/trash.dart';

class passlogininfo {
  final int? id;
  final int ty;
  passlogininfo(this.id, this.ty);
}

class Databaseapp {
  static final instance = Databaseapp._init();

  static Database? _database;

  Databaseapp._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('test1.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filePath);
    return (openDatabase(path, version: 1, onCreate: _createDB));
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final intType = 'INTEGER NOT NULL';

    await db.execute('''CREATE TABLE $tableUsers( 
      ${Usersfiled.id_user} $idType,
      ${Usersfiled.username} $textType,
      ${Usersfiled.password} $textType,
      ${Usersfiled.name} $textType,
      ${Usersfiled.lastname} $textType,
      ${Usersfiled.adress} $textType,
      ${Usersfiled.sex} $textType,
      ${Usersfiled.types} $intType)''');

    await db.execute('''
            CREATE TABLE $tableTrash(
              ${trashfiled.id_trash} $idType ,
              ${trashfiled.type_trash} $textType,
              ${trashfiled.Quant} $intType,
              ${trashfiled.Price} $intType,
              ${trashfiled.Date} $textType,
              ${trashfiled.id_user} $intType,
              FOREIGN KEY (id_user) REFERENCES Users (id_user)
                ON DELETE NO ACTION ON UPDATE NO ACTION
            )''');
  }

  //insert a user into the Database
  Future<Users> create(Users Users) async {
    final db = await instance.database;

    final id = await db.insert(tableUsers, Users.toJson());
    return Users.copy(id_user: id);
  }

//insert a trash into the Database
  Future<Trash> createtrash(Trash trash) async {
    final db = await instance.database;

    final id = await db.insert(tableTrash, trash.toJson());
    return trash.copy(id_trash: id);
  }

// authenif login
  Future<bool> authontif(String Username, String pass) async {
    final db = await instance.database;
    final maps = await db.query(tableUsers,
        columns: Usersfiled.values,
        where: '  ${Usersfiled.username} = ? and ${Usersfiled.password} = ?',
        whereArgs: [Username, pass]);
    if (maps.isNotEmpty) {
      return true;
    }
    return false;
  }

  // pass info

  Future<passlogininfo> getauthin(String Username, String pass) async {
    final db = await instance.database;
    final maps = await db.query(tableUsers,
        columns: Usersfiled.values,
        where: '  ${Usersfiled.username} = ? and ${Usersfiled.password} = ?',
        whereArgs: [Username, pass]);

    if (maps.isNotEmpty) {
      Users ur = Users.fromJson(maps.first);

      return passlogininfo(ur.id_user, ur.types);
    }
    throw Exception('user : $Username not found');
  }

// get userr by id
  Future<Users> getuserbyid(int? id) async {
    final db = await instance.database;
    final maps = await db.query(tableUsers,
        columns: Usersfiled.values,
        where: '  ${Usersfiled.id_user} = ? ',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Users.fromJson(maps.first);
    }
    throw Exception('user  not found');
  }

// get all user
  Future<List<Trash>> getalltrash() async {
    final db = await instance.database;
    final resualt = await db.query(tableTrash);
    return resualt.map((json) => Trash.fromJson(json)).toList();
  }

// get user by trash type
  Future<List> getUserbyTrashType(String traType) async {
    final db = await instance.database;
    final result =
        await db.rawQuery('''SELECT ${trashfiled.id_trash}, ${Usersfiled.name} 
      FROM ${tableUsers},${tableTrash}
      WHERE ${Usersfiled.id_user} = ${trashfiled.id_user} and ${trashfiled.type_trash} = "${traType}"
      ''');
    return result;
  }

  Future<List> getTrashlist(int? id) async {
    final db = await instance.database;
    final result =
        await db.rawQuery('''SELECT ${tableTrash}.*, ${Usersfiled.adress} 
      FROM ${tableUsers},${tableTrash}
      WHERE ${Usersfiled.id_user} = ${trashfiled.id_user} and ${trashfiled.id_trash} = "${id}"
      ''');
    return result;
  }

  Future<int> deletetrashbyid(int? id) async {
    final db = await instance.database;
    return await db.delete(
      tableTrash,
      where: '${trashfiled.id_trash} = ? ',
      whereArgs: [id],
    );
  }
}
