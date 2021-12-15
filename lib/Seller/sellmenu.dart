import 'package:flutter/material.dart';
import 'package:examtpflutter/DB/database.dart';
import 'package:examtpflutter/DB/model/users.dart';
import 'package:examtpflutter/DB/model/trash.dart';

class sellmenu extends StatefulWidget {
  int? id_user;
  sellmenu(this.id_user);

  @override
  _sellmenuState createState() => _sellmenuState();
}

class _sellmenuState extends State<sellmenu> {
  final _formKey = GlobalKey<FormState>();
  String type_trash = "plastique";
  int Price = 0;
  int Quant = 0;

  var typetrashitems = [
    "plastique",
    "verre",
    "papier",
    "pain",
    "tissu",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dépôt"),
      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(20, 40, 20, 10),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
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
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "Quantity"),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Quantity is required";
                            }
                            return null;
                          },
                          onChanged: (String? value) {
                            setState(() {
                              Quant = int.parse(value!);
                            });
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "Price"),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "price is required";
                            }
                            return null;
                          },
                          onChanged: (String? value) {
                            setState(() {
                              Price = int.parse(value!);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        DateTime Date = new DateTime.now();
                        Trash tar = new Trash(
                            type_trash: type_trash,
                            Quant: Quant,
                            Price: Price,
                            Date: Date,
                            id_user: widget.id_user);
                        Databaseapp.instance.createtrash(tar);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Sumbimited")),
                        );
                      }
                    },
                    child: const Text('Post'),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
