import 'package:flutter/material.dart';
import 'package:sqlflitedatabase/datasetter.dart';
import 'package:sqlflitedatabase/viewpage.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbhelper().dbsetter().then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return viewpage();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
