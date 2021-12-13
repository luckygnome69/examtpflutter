import 'package:flutter/material.dart';
import 'package:examtpflutter/DB/database.dart';
import 'package:examtpflutter/DB/model/users.dart';

class singup extends StatefulWidget {
  @override
  State<singup> createState() => _singup();
}

class _singup extends State<singup> {
  final _formKey = GlobalKey<FormState>();

  String _username = "";
  String password = "";
  String name = "";
  String lastname = "";
  String adress = "";
  String sex = "Homme";
  String typedisplay = "buyer";
  int types = 1;
  var sexitems = [
    'Homme',
    'femme',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("s’inscrire"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Nom d'utilisateur"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Nom d'utilisateur est nécessaire";
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    setState(() {
                      _username = value.toString();
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "mot de passe"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "mot de passe est nécessaire";
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    setState(() {
                      password = value.toString();
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Nom"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Nom est nécessaire";
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    setState(() {
                      name = value.toString();
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "prenom"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "prenom est nécessaire";
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    setState(() {
                      lastname = value.toString();
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "adress"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "adress est nécessaire";
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    setState(() {
                      adress = value.toString();
                    });
                  },
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Radio(
                            value: 1,
                            groupValue: types,
                            onChanged: (value) {
                              setState(() {
                                types = 1;
                              });
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        Text("dépôt")
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                            value: 2,
                            groupValue: types,
                            onChanged: (value) {
                              setState(() {
                                types = 2;
                              });
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        Text("collect")
                      ],
                    )
                  ],
                ),
                DropdownButton(
                  value: sex,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: sexitems.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      sex = newValue!;
                    });
                  },
                ),
                Container(
                  child: Center(
                      child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Users su = Users(
                                username: _username,
                                password: password,
                                name: name,
                                lastname: lastname,
                                adress: adress,
                                sex: sex,
                                types: types);
                            Databaseapp.instance.create(su);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("ins")),
                            );
                          }
                        },
                        child: const Text('insciré'),
                      ),
                      Text("vous avez un compte?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Connectez-vous'))
                    ],
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
