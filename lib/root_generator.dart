import 'package:examtpflutter/Buyer/itemlist.dart';
import 'package:examtpflutter/DB/model/users.dart';
import 'package:examtpflutter/DB/database.dart';
import 'package:examtpflutter/Seller/sellmenu.dart';
import 'package:flutter/material.dart';
import 'package:examtpflutter/singup/login.dart';
import 'package:examtpflutter/singup/singup.dart';
import 'package:examtpflutter/Buyer/buyerdash.dart';
import 'package:examtpflutter/seller/sellerdash.dart';
import 'package:examtpflutter/Buyer/buyermenu.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => login());
      case '/singup':
        return MaterialPageRoute(
          builder: (_) => singup(),
        );

      case '/logged':
        if (args is passlogininfo) {
          if (args.ty == 2) {
            return MaterialPageRoute(
              builder: (_) => buyerdash(args.id),
            );
          } else if (args.ty == 1) {
            return MaterialPageRoute(
              builder: (_) => sellerdash(args.id),
            );
          }
          ;
        }
        return _errorRoute();
      case '/buyermenu':
        return MaterialPageRoute(
          builder: (_) => buyermenu(),
        );

      case '/sellmenu':
        if (args is int?) {
          return MaterialPageRoute(
            builder: (_) => sellmenu(args),
          );
        }
        return _errorRoute();
      case '/itemlist':
        if (args is itemInfoSender) {
          return MaterialPageRoute(
            builder: (_) => itemlist(args.id, args.type),
          );
        }
        return _errorRoute();
      // If args is not of the correct type, return an error page.
      // You can also throw an exception while in development.
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
