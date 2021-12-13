import 'package:flutter/material.dart';
import 'package:examtpflutter/DB/database.dart';
import 'package:examtpflutter/DB/model/users.dart';

class login extends StatefulWidget {
  @override
  State<login> createState() => _login();
}

class _login extends State<login> {
  final _formKey = GlobalKey<FormState>();

  String _username = "";
  String phone = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.teal,
        title: Text("Se Connecter"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
        child: Form(
          key: _formKey,
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
                decoration: InputDecoration(labelText: "Mot de passe"),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "un mot de passe est nécessaire";
                  }
                  return null;
                },
                onChanged: (String? value) {
                  setState(() {
                    password = value.toString();
                  });
                },
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Center(
                    child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        bool test = await Databaseapp.instance
                            .authontif(_username, password);
                        if (test == true) {
                          passlogininfo inf = await Databaseapp.instance
                              .getauthin(_username, password);

                          Navigator.pushReplacementNamed(
                            context,
                            '/logged',
                            arguments: inf,
                          );
                        }
                      },
                      child: const Text('Envoyer'),
                    ),
                    Text('Vous n\'avez pas de compte ?'),
                    TextButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, '/singup');
                        },
                        child: Text("s’inscrire"))
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
