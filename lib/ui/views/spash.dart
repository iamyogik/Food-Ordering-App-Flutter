import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery_app_crio/ui/views/home.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Route route = MaterialPageRoute(builder: (context) => HomeScreen());
    //Navigator.of(context).pushReplacementNamed();
    Navigator.push(context, route);
  }


  @override
void initState() {
  super.initState();
  startTime();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Image(
          height: double.infinity,
              //width: 150,
              //height: 300,
              fit: BoxFit.cover,
              image: AssetImage("assets/images/splash.png"),
              // image: AssetImage("assets/images/food-img-1.jpg"),
            ),
      ),
    );
  }
}



