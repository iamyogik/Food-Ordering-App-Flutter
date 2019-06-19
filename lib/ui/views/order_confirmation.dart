import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_app_crio/core/viewmodels/base_model.dart';
import 'package:food_delivery_app_crio/core/viewmodels/order_confirmation.dart';
import 'package:food_delivery_app_crio/ui/views/base_view.dart';
import 'package:food_delivery_app_crio/ui/views/home.dart';
import 'package:food_delivery_app_crio/ui/widgets/appBar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OrderConfirmationPage extends StatefulWidget {
  var orderId;
  OrderConfirmationPage({this.orderId});

  @override
  _OrderConfirmationPageState createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {

  Timer timer, timer_once;
  bool cancelButton = false;

 
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  refreshOrderData(model){
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => model.refreshOrderData(widget.orderId));
  }


  cancelOrder(model) async{
    setState(() {
      cancelButton = true;
    });
    
    var response = await model.cancelOrder(widget.orderId);
    
     setState(() {
      cancelButton = false;
    });

  }


  @override
  Widget build(BuildContext context) {
    return BaseView<OrderModel>(onModelReady: (model) {

      model.getOrderData(widget.orderId);
      Future.delayed(const Duration(milliseconds: 2000), () {
        refreshOrderData(model);
      });


    }, builder: (context, model, child) {
      return Scaffold(
        appBar: appBar(context, backAvailable: true),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: 
          model.state == ViewState.Busy ?
          Center(
            child: SpinKitChasingDots(color: Color(0xfffd5f00)),
          )
          :
          orderStatusScreen(model.orderData, model),
        ),
      );
    });
  }


Widget orderStatusScreen(data, model){
    switch(data.status) { 
      case "PENDING ": { 
        return pendingOrder(model);
      } 
      break; 
      
      case "ACCEPTED": { 
        return acceptedOrder(model);
      } 
      break; 
      case "REJECTED": { 
        return rejectedOrder(model);
      } 
      break; 
      case "CANCELLED": { 
        return cancelledOrder(model);
      } 
      break; 
      case "PREPARING": { 
        return preparingOrder(model);
      } 
      break; 
      case "READY": { 
        return readyOrder(model);
      } 
      break;
      case "DISPATCHED": { 
        return dispatchedOrder(model);
      } 
      break; 
          
      default: { 
        return pendingOrder(model);
      }
      break; 
    } 

}


  Widget dispatchedOrder(model) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // SizedBox(
          //   height: 50,
          // ),

          Spacer(
            flex: 5,
          ),

          Center(
            child: Text(
              "Order Status",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 25,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w800),
            ),
          ),

          Center(
            child: Text(
              "Jun 18, 2019 at 3:47 PM",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),

          // SizedBox(
          //   height: 80,
          // ),

          Spacer(
            flex: 8,
          ),

          Center(
            child: Image(
              width: 150,
              //height: 300,
              fit: BoxFit.cover,
              image: AssetImage("assets/images/3.png"),
              // image: AssetImage("assets/images/food-img-1.jpg"),
            ),
          ),

          // SizedBox(
          //   height: 80,
          // ),

          Spacer(
            flex: 8,
          ),

          Center(
            child: Text(
              "Order has been Dispatched",
              style: TextStyle(
                  color: Colors.blue.withOpacity(0.9),
                  fontSize: 30,
                  fontWeight: FontWeight.w800),
            ),
          ),

          SizedBox(
            height: 5,
          ),


          Center(
            child: Container(
              width: 250,
              child: Text(
                "Your order has been dispatched. It will reach you soon.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),

          SizedBox(
            height: 5,
          ),

          // SizedBox(
          //   height: 30,
          // ),

          Spacer(
            flex: 3,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.watch_later,
                size: 25,
                color: Colors.green,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                model.orderData.preprationTime.toString() +"min.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),

          // SizedBox(
          //   height: 120,
          // ),

          
          Spacer(
            flex: 9,
          ),


         
          Spacer(
            flex: 3,
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: ()  {
                  Route route =
                    MaterialPageRoute(builder: (context) => HomeScreen());
                Navigator.push(context, route);

                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    border: new Border.all(
                        color: Color(0xfffd5f00),
                        style: BorderStyle.solid,
                        width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Center(
                          child: new Text(
                            'Go back to Home',
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

       

          Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }

  Widget readyOrder(model) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // SizedBox(
          //   height: 50,
          // ),

          Spacer(
            flex: 5,
          ),

          Center(
            child: Text(
              "Order Status",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 25,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w800),
            ),
          ),

          Center(
            child: Text(
              model.orderData.orderedOn,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),

          // SizedBox(
          //   height: 80,
          // ),

          Spacer(
            flex: 8,
          ),

          Center(
            child: Image(
              width: 150,
              //height: 300,
              fit: BoxFit.cover,
              image: AssetImage("assets/images/3.png"),
              // image: AssetImage("assets/images/food-img-1.jpg"),
            ),
          ),

          // SizedBox(
          //   height: 80,
          // ),

          Spacer(
            flex: 8,
          ),

          Center(
            child: Text(
              "Order is Ready",
              style: TextStyle(
                  color: Colors.blue.withOpacity(0.9),
                  fontSize: 30,
                  fontWeight: FontWeight.w800),
            ),
          ),

          SizedBox(
            height: 5,
          ),


          Center(
            child: Container(
              width: 250,
              child: Text(
                "Your order is ready and will be dispatched soon.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),

          SizedBox(
            height: 5,
          ),

          // SizedBox(
          //   height: 30,
          // ),

          Spacer(
            flex: 3,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.watch_later,
                size: 25,
                color: Colors.green,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                model.orderData.preprationTime.toString() +"min.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),

          // SizedBox(
          //   height: 120,
          // ),

          Spacer(
            flex: 12,
          ),

          

          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: ()  {
                  Route route =
                    MaterialPageRoute(builder: (context) => HomeScreen());
                Navigator.push(context, route);

                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    border: new Border.all(
                        color: Color(0xfffd5f00),
                        style: BorderStyle.solid,
                        width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Center(
                          child: new Text(
                            'Go back to Home',
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

       

          Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }

  Widget preparingOrder(model) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // SizedBox(
          //   height: 50,
          // ),

          Spacer(
            flex: 5,
          ),

          Center(
            child: Text(
              "Order Status",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 25,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w800),
            ),
          ),

          Center(
            child: Text(
              model.orderData.orderedOn,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),

          // SizedBox(
          //   height: 80,
          // ),

          Spacer(
            flex: 8,
          ),

          Center(
            child: Image(
              width: 150,
              //height: 300,
              fit: BoxFit.cover,
              image: AssetImage("assets/images/2.png"),
              // image: AssetImage("assets/images/food-img-1.jpg"),
            ),
          ),

          // SizedBox(
          //   height: 80,
          // ),

          Spacer(
            flex: 8,
          ),

          Center(
            child: Text(
              "Preparing your Order",
              style: TextStyle(
                  color: Colors.green.withOpacity(0.9),
                  fontSize: 30,
                  fontWeight: FontWeight.w800),
            ),
          ),

          SizedBox(
            height: 5,
          ),


          Center(
            child: Container(
              width: 250,
              child: Text(
                "Your order is being placed. Don't forget to order Desserts?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),

          SizedBox(
            height: 5,
          ),

          // SizedBox(
          //   height: 30,
          // ),

          Spacer(
            flex: 3,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.watch_later,
                size: 25,
                color: Colors.green,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                model.orderData.preprationTime.toString() +"min.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),

          // SizedBox(
          //   height: 120,
          // ),

          
          Spacer(
            flex: 9,
          ),


          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Material(
              color: Colors.red.withOpacity(0.85),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: (){
                  cancelOrder(model);
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Center(
                          child: 
                          cancelButton

                          ?
                          Container(
                            width: 40,
                            child:  SpinKitDoubleBounce(color: Colors.white),
                          )
                         
                          
                          :
                          
                           Text(
                            'CANCEL ORDER',
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),


          Spacer(
            flex: 3,
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: ()  {
                  Route route =
                    MaterialPageRoute(builder: (context) => HomeScreen());
                Navigator.push(context, route);

                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    border: new Border.all(
                        color: Color(0xfffd5f00),
                        style: BorderStyle.solid,
                        width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Center(
                          child: new Text(
                            'Go back to Home',
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

       

          Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }

  Widget cancelledOrder(model) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // SizedBox(
          //   height: 50,
          // ),

          Spacer(
            flex: 5,
          ),

          Center(
            child: Text(
              "Order Status",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 25,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w800),
            ),
          ),

          Center(
            child: Text(
              model.orderData.orderedOn,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),

          // SizedBox(
          //   height: 80,
          // ),

          Spacer(
            flex: 8,
          ),

          Center(
            child: Image(
              width: 100,
              //height: 300,
              fit: BoxFit.cover,
              image: AssetImage("assets/images/1.png"),
              // image: AssetImage("assets/images/food-img-1.jpg"),
            ),
          ),

          // SizedBox(
          //   height: 80,
          // ),

          Spacer(
            flex: 8,
          ),

          Center(
            child: Text(
              "Order Cancelled",
              style: TextStyle(
                  color: Colors.red.withOpacity(0.9),
                  fontSize: 30,
                  fontWeight: FontWeight.w800),
            ),
          ),

          SizedBox(
            height: 5,
          ),


          Center(
            child: Container(
              width: 250,
              child: Text(
                "As per your request we have cancelled your order.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),

          SizedBox(
            height: 5,
          ),

          Spacer(
            flex: 3,
          ),

          Spacer(
            flex: 12,
          ),

          
         

          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: ()  {
                  Route route =
                    MaterialPageRoute(builder: (context) => HomeScreen());
                Navigator.push(context, route);

                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    border: new Border.all(
                        color: Color(0xfffd5f00),
                        style: BorderStyle.solid,
                        width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Center(
                          child: new Text(
                            'Go back to Home',
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

       

          Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }


  Widget rejectedOrder(model) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // SizedBox(
          //   height: 50,
          // ),

          Spacer(
            flex: 5,
          ),

          Center(
            child: Text(
              "Order Status",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 25,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w800),
            ),
          ),

          Center(
            child: Text(
              model.orderData.orderedOn,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),

          // SizedBox(
          //   height: 80,
          // ),

          Spacer(
            flex: 8,
          ),

          Center(
            child: Image(
              width: 100,
              //height: 300,
              fit: BoxFit.cover,
              image: AssetImage("assets/images/1.png"),
              // image: AssetImage("assets/images/food-img-1.jpg"),
            ),
          ),

          // SizedBox(
          //   height: 80,
          // ),

          Spacer(
            flex: 8,
          ),

          Center(
            child: Text(
              "Order Rejected",
              style: TextStyle(
                  color: Colors.red.withOpacity(0.9),
                  fontSize: 30,
                  fontWeight: FontWeight.w800),
            ),
          ),

          SizedBox(
            height: 5,
          ),


          Center(
            child: Container(
              width: 350,
              child: Text(
                "Restaurant has rejected the order. We apologise for the inconvenience caused.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),

          SizedBox(
            height: 5,
          ),

          // SizedBox(
          //   height: 30,
          // ),

          Spacer(
            flex: 3,
          ),

      
          // SizedBox(
          //   height: 120,
          // ),

          Spacer(
            flex: 12,
          ),

          
          

          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: ()  {
                  Route route =
                    MaterialPageRoute(builder: (context) => HomeScreen());
                Navigator.push(context, route);

                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    border: new Border.all(
                        color: Color(0xfffd5f00),
                        style: BorderStyle.solid,
                        width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Center(
                          child: new Text(
                            'Go back to Home',
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

       

          Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }

  Widget acceptedOrder(model) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // SizedBox(
          //   height: 50,
          // ),

          Spacer(
            flex: 5,
          ),

          Center(
            child: Text(
              "Order Status",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 25,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w800),
            ),
          ),

          Center(
            child: Text(
              model.orderData.orderedOn,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),

          // SizedBox(
          //   height: 80,
          // ),

          Spacer(
            flex: 8,
          ),

          Center(
            child: Image(
              width: 120,
              //height: 300,
              fit: BoxFit.cover,
              image: AssetImage("assets/images/4.png"),
              // image: AssetImage("assets/images/food-img-1.jpg"),
            ),
          ),

          // SizedBox(
          //   height: 80,
          // ),

          Spacer(
            flex: 8,
          ),

          Center(
            child: Text(
              "Order Confirmed",
              style: TextStyle(
                  color: Colors.green.withOpacity(0.9),
                  fontSize: 30,
                  fontWeight: FontWeight.w800),
            ),
          ),

          SizedBox(
            height: 5,
          ),


          Center(
            child: Container(
              width: 250,
              child: Text(
                "Your order has been confirmed.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),

          SizedBox(
            height: 5,
          ),

          // SizedBox(
          //   height: 30,
          // ),

          Spacer(
            flex: 3,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.watch_later,
                size: 25,
                color: Colors.green,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                model.orderData.preprationTime.toString() +"min.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),

          // SizedBox(
          //   height: 120,
          // ),

          
          Spacer(
            flex: 9,
          ),


           Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Material(
              color: Colors.red.withOpacity(0.85),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: (){
                  cancelOrder(model);
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Center(
                          child: 
                          cancelButton

                          ?
                          Container(
                            width: 40,
                            child:  SpinKitDoubleBounce(color: Colors.white),
                          )
                         
                          
                          :
                          
                           Text(
                            'CANCEL ORDER',
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),


          Spacer(
            flex: 3,
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: ()  {
                  Route route =
                    MaterialPageRoute(builder: (context) => HomeScreen());
                Navigator.push(context, route);

                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    border: new Border.all(
                        color: Color(0xfffd5f00),
                        style: BorderStyle.solid,
                        width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Center(
                          child: new Text(
                            'Go back to Home',
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

       

          Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }

  Widget pendingOrder(model) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // SizedBox(
          //   height: 50,
          // ),

          Spacer(
            flex: 5,
          ),

          Center(
            child: Text(
              "Order Status",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 25,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w800),
            ),
          ),

          Center(
            child: Text(
              model.orderData.orderedOn,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),

          // SizedBox(
          //   height: 80,
          // ),

          Spacer(
            flex: 8,
          ),

          Center(
            child: Image(
              width: 100,
              //height: 300,
              fit: BoxFit.cover,
              image: AssetImage("assets/images/1.png"),
              // image: AssetImage("assets/images/food-img-1.jpg"),
            ),
          ),

          // SizedBox(
          //   height: 80,
          // ),

          Spacer(
            flex: 8,
          ),

          Center(
            child: Text(
              "Confirming with Restaurant",
              style: TextStyle(
                  color: Colors.blue.withOpacity(0.9),
                  fontSize: 30,
                  fontWeight: FontWeight.w800),
            ),
          ),

          // SizedBox(
          //   height: 10,
          // ),

          Spacer(
            flex: 1,
          ),

          Center(
            child: Container(
              width: 250,
              child: Text(
                "Please kindly wait, while we are processing your order.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),

          // SizedBox(
          //   height: 30,
          // ),

          Spacer(
            flex: 3,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.watch_later,
                size: 25,
                color: Colors.green,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                model.orderData.preprationTime.toString() +"min.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),

         

          Spacer(
            flex: 9,
          ),


          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Material(
              color: Colors.red.withOpacity(0.85),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: (){
                  cancelOrder(model);
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Center(
                          child: 
                          cancelButton

                          ?
                          Container(
                            width: 40,
                            child:  SpinKitDoubleBounce(color: Colors.white),
                          )
                         
                          
                          :
                          
                           Text(
                            'CANCEL ORDER',
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Spacer(
            flex: 3,
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: ()  {
                  Route route =
                    MaterialPageRoute(builder: (context) => HomeScreen());
                Navigator.push(context, route);

                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    border: new Border.all(
                        color: Color(0xfffd5f00),
                        style: BorderStyle.solid,
                        width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Center(
                          child: new Text(
                            'Go back to Home',
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

       
       
         Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }






}
