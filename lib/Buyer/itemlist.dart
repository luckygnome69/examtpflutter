import 'package:flutter/material.dart';
import 'package:examtpflutter/DB/database.dart';
import 'package:examtpflutter/DB/model/users.dart';
import 'package:examtpflutter/DB/model/trash.dart';

class itemlist extends StatefulWidget {
  int? id;
  String type;
  itemlist(this.id, this.type);

  @override
  _itemlistState createState() => _itemlistState();
}

class _itemlistState extends State<itemlist> {
  Future<List> getTrashlist(int? id) async {
    return await Databaseapp.instance.getTrashlist(widget.id);
  }

  void initState() {
    getTrashlist(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("collect"),
      ),
      body: FutureBuilder<List>(
        future: getTrashlist(
            widget.id), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            List ar = snapshot.data!;

            int prix = ar[0]['Price'];
            int qaunt = ar[0]['Quant'];

            return Column(children: [
              Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListView.builder(
                              itemCount: ar.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Column(children: [
                                    Text('Quantité :  ${ar[index]['Quant']}'),
                                    Text('Prix :  ${ar[index]['Price']}'),
                                    Text('Adress : ${ar[index]['adress']}'),
                                    Text('Date : ${ar[index]['Date']}'),
                                  ]),
                                );
                              })
                        ],
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Image.asset('images/icon.png')),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Container(
                  child: ElevatedButton(
                onPressed: () async {
                  int a = await Databaseapp.instance.deletetrashbyid(widget.id);
                  Navigator.pop(context);
                  int pay = prix * qaunt;
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("vous aver payer ${pay}")));
                },
                child: Text(
                  "Payé",
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
