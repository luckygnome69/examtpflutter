import 'package:flutter/material.dart';
import 'package:examtpflutter/DB/database.dart';
import 'package:examtpflutter/DB/model/users.dart';

class sellerdash extends StatefulWidget {
  final int? id;

  sellerdash(this.id);
  @override
  State<sellerdash> createState() => _sellerdash();
}

class _sellerdash extends State<sellerdash> {
  Future<Users> getuserbyid(int? id) async {
    return await Databaseapp.instance.getuserbyid(widget.id);
  }

  @override
  void initState() {
    getuserbyid(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dépôt"),
      ),
      body: FutureBuilder<Users>(
        future: getuserbyid(
            widget.id), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<Users> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            Users ar = snapshot.data!;
            return Column(children: [
              Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Bienvenue :",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(' Nom : ',
                                      style: TextStyle(
                                        fontSize: 20,
                                      )),
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(' ${ar.name} ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(' prenom : ',
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(' ${ar.lastname} ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                    )),
                              ),
                            ],
                          )
                        ],
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Image.asset('images/icon.png')),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Container(
                  child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/sellmenu',
                    arguments: widget.id,
                  );
                },
                child: Text(
                  "Dépot",
                  style: TextStyle(fontSize: 35),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  maximumSize: const Size(200, 50),
                ),
              ))
            ]);
          }
          return Text("error");
        },
      ),
    );
  }
}
