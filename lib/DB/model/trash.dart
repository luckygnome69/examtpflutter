final String tableTrash = 'Trash';

class trashfiled {
  static final List<String> values = [
    id_trash,
    type_trash,
    Quant,
    Price,
    Date,
    id_user,
  ];
  static final String id_trash = '_id_trash ';
  static final String type_trash = 'type_trash';
  static final String Quant = 'Quant';
  static final String Price = 'Price';
  static final String Date = 'Date';
  static final String id_user = 'id_user';
}

class Trash {
  final int? id_trash;
  final String type_trash;
  final int Quant;
  final int Price;
  final DateTime Date;
  final int? id_user;

  const Trash({
    this.id_trash,
    required this.type_trash,
    required this.Quant,
    required this.Price,
    required this.Date,
    required this.id_user,
  });
  static Trash fromJson(Map<String, Object?> json) => Trash(
      id_trash: json[trashfiled.id_trash] as int?,
      type_trash: json[trashfiled.type_trash] as String,
      Quant: json[trashfiled.Quant] as int,
      Price: json[trashfiled.Price] as int,
      Date: DateTime.parse(json[trashfiled.Date] as String),
      id_user: json[trashfiled.id_user] as int);

  Map<String, Object?> toJson() => {
        trashfiled.id_trash: id_trash,
        trashfiled.type_trash: type_trash,
        trashfiled.Quant: Quant,
        trashfiled.Price: Price,
        trashfiled.Date: Date.toIso8601String(),
        trashfiled.id_user: id_user
      };
  Trash copy({int? id_trash}) => Trash(
        id_trash: id_trash ?? this.id_trash,
        type_trash: type_trash ?? this.type_trash,
        Quant: Quant ?? this.Quant,
        Price: Price ?? this.Price,
        Date: Date ?? this.Date,
        id_user: id_user ?? this.id_user,
      );
}
