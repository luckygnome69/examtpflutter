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
        title: Text("Seller"),
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
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Welcome :",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '${ar.name}  ${ar.lastname}',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
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
                  "SELL",
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
