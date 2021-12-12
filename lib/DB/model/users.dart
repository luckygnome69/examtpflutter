final String tableUsers = 'users';

class Usersfiled {
  static final List<String> values = [
    id_user,
    username,
    password,
    name,
    lastname,
    adress,
    sex,
    types,
  ];
  static final String id_user = '_id_user';
  static final String username = 'username';
  static final String password = 'password';
  static final String name = 'name';
  static final String lastname = 'lastname';
  static final String adress = 'adress';
  static final String sex = 'sex';
  static final String types = 'types';
}

class Users {
  final int? id_user;
  final String username;
  final String password;
  final String name;
  final String lastname;
  final String adress;
  final String sex;
  final int types;

  const Users({
    this.id_user,
    required this.username,
    required this.password,
    required this.name,
    required this.lastname,
    required this.adress,
    required this.sex,
    required this.types,
  });
  static Users fromJson(Map<String, Object?> json) => Users(
      id_user: json[Usersfiled.id_user] as int?,
      username: json[Usersfiled.username] as String,
      password: json[Usersfiled.password] as String,
      name: json[Usersfiled.name] as String,
      lastname: json[Usersfiled.lastname] as String,
      adress: json[Usersfiled.adress] as String,
      sex: json[Usersfiled.sex] as String,
      types: json[Usersfiled.types] as int);

  Map<String, Object?> toJson() => {
        Usersfiled.id_user: id_user,
        Usersfiled.username: username,
        Usersfiled.password: password,
        Usersfiled.name: name,
        Usersfiled.lastname: lastname,
        Usersfiled.adress: adress,
        Usersfiled.sex: sex,
        Usersfiled.types: types
      };
  Users copy({int? id_user}) => Users(
        id_user: id_user ?? this.id_user,
        username: username ?? this.username,
        password: password ?? this.password,
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        adress: adress ?? this.adress,
        sex: sex ?? this.sex,
        types: types ?? this.types,
      );
}
