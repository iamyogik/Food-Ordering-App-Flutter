import 'package:flutter/material.dart';

Widget appBar(context, {backAvailable = false}) {
  return AppBar(
    //bottomOpacity: 0,
    elevation: 0,
    backgroundColor: Colors.transparent,
    leading: IconButton(
     
     onPressed: (){
       if(backAvailable){
         Navigator.pop(context);
       }
     },
      color: Colors.black,
      icon: Icon(
        backAvailable ?
        Icons.arrow_back_ios
        :
        Icons.restaurant_menu,
      ),
      iconSize: 25,
    ),

    // leading: Container(
    //   padding: EdgeInsets.all(12),
    //   child: Image(
    //             //width: 150,
    //             //height: 300,
    //             fit: BoxFit.scaleDown,
    //             image: AssetImage("assets/images/logo_symbol.png"),
    //           ),
    // ),


    // title: Container(
    //   alignment: Alignment.center,
    //   child: Text(
    //     "QEats",
    //     style: TextStyle(
    //       color: Colors.black,
    //       fontSize: 30,
    //       fontWeight: FontWeight.w800,
    //     ),
    //   ),
    // ),


    title:  Container(
      alignment: Alignment.center,
      height: 28,
      //padding: EdgeInsets.all(12),
      child: Image(
                //width: 150,
                //height: 300,
                // fit: BoxFit.scaleDown,
                image: AssetImage("assets/images/logo.png"),
              ),
    ),

    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
        child: Icon(
          Icons.filter_list,
          size: 30,
          color: Colors.black,
        ),
      ),
    ],
  );
}
