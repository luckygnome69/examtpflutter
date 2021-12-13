import 'package:flutter/material.dart';
import 'package:examtpflutter/DB/database.dart';
import 'package:examtpflutter/DB/model/users.dart';
import 'package:examtpflutter/DB/model/trash.dart';

class buyermenu extends StatefulWidget {
  buyermenu({Key? key}) : super(key: key);

  @override
  _buyermenuState createState() => _buyermenuState();
}

class _buyermenuState extends State<buyermenu> {
  String type_trash = "plastique";
  List ab = [];
  String msg = "";
  var typetrashitems = [
    "plastique",
    "verre",
    "papier",
    "pain",
    "tissu",
  ];

  Widget ls(List ar, String typetrash) {
    if (ar.isEmpty) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Align(
            alignment: Alignment.center,
            child: Text(
              msg,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            )),
      );
    }
    return ListView.builder(
        itemCount: ab.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            child: TextButton(
              child: Text('${index + 1} --- ${ab[index]['name']}'),
              onPressed: () {
                itemInfoSender sender =
                    new itemInfoSender(ab[index]['_id_trash'], typetrash);
                Navigator.pushNamed(context, '/itemlist', arguments: sender)
                    .then((_) => setState(() {
                          ab = [];
                          msg = "";
                        }));
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("liste déchets"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: DropdownButton(
                  isExpanded: true,
                  value: type_trash,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: typetrashitems.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      type_trash = newValue!;
                    });
                  },
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () async {
                    List t = await Databaseapp.instance
                        .getUserbyTrashType(type_trash);

                    setState(() {
                      msg = "aucun résultat";
                      ab = t;
                    });
                  },
                  child: Text(
                    "GO",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ]),
            ls(ab, type_trash),
          ],
        ),
      ),
    );
  }
}

class itemInfoSender {
  int? id;
  String type;
  itemInfoSender(this.id, this.type);
}
