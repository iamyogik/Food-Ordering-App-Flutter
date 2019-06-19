import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/painting.dart';
import 'package:food_delivery_app_crio/core/viewmodels/base_model.dart';
import 'package:food_delivery_app_crio/core/viewmodels/home_model.dart';
import 'package:food_delivery_app_crio/ui/views/menu.dart';
import 'package:food_delivery_app_crio/ui/widgets/appBar.dart';
// import '../../core/viewmodels/base_model.dart';
import './base_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(onModelReady: (model) {
      model.getRestaurantData();
    }, builder: (context, model, child) {
      //print(model.homeDataJson);

      return Scaffold(
        appBar: appBar(context),
        backgroundColor: Colors.white,
        body: model.state == ViewState.Busy
            ? Center(
                // child: CircularProgressIndicator(),
                child: SpinKitChasingDots(color: Color(0xfffd5f00)),
              )
            : SafeArea(
                child: Column(
                  children: <Widget>[
                    //Search Bar
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        style: TextStyle(fontSize: 18),

                        //controller: _textFieldController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(15, 17, 15, 15),
                          prefixIcon: Icon(
                            Icons.search,
                          ),

                          //Add th Hint text here.
                          hintText: "Search for Restaurants, Cuisine",
                          hintStyle: TextStyle(fontSize: 18),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.4),
                                width: 1.5),
                          ),
                        ),
                      ),
                    ),

                    //Restaurant Cards

                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(8.0),
                        children: <Widget>[
                          

                           //strings.map((item) => new Text(item)).toList()
                          for(var data in model.homeDataJson )
                            restaurantCard(context, data),
                          

                          // model.homeDataJson.map((data){
                          //   return restaurantCard();
                          // }).toList(),
                          
                      
                       
                        ],
                      ),
                    )
                  ],
                ),
              ),
      );
    });
  }

final _random = new Random();

int next(int min, int max) => min + _random.nextInt(max - min);



  Widget restaurantCard(context, data) {

    return GestureDetector(
        onTap: (){
          if(data.acceptingOrders){
            Route route =
              MaterialPageRoute(builder: (context) => Menu(restaurantId: data.sId,));
          Navigator.push(context, route);
          // print(data.sId);
          }
        },

        child: Container(
          
          foregroundDecoration: 
          data.acceptingOrders ?
          BoxDecoration()
          :
          BoxDecoration(
              color: Colors.grey,
              backgroundBlendMode: BlendMode.saturation,
            ),
          child: Card(
            
            shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10.0),
                   ),
            //elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Card Image
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  child: FadeInImage.assetNetwork(
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    placeholder: "assets/images/food-load-7.gif",
                    image: data.imageUrl,
                  ),
                  // child: Image(
                  //   width: double.infinity,
                  //   height: 200,
                  //   fit: BoxFit.cover,
                  //   // image: AssetImage("assets/images/food-img-1.jpg"),
                  //   // image: AssetImage("assets/images/food-img-1.jpg"),
                  // ),
                ),

                //SizedBox(height: 20,),

                // Restaurant Name
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 20, 20),
                  child: Text(
                    data.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),

                // Restaurant Details

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Color(0xffFFD700),
                            size: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                            child: Text(
                              (next(42,47)/10).toString(),
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.watch_later,
                            color: Colors.blue,
                            size: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                            child: Text(
                              data.opensAt + " - " + data.closesAt,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          for( var i = 0 ; i <= next(0,3); i++ )
                            Icon(
                              Icons.monetization_on,
                              color: Colors.green,
                              size: 20,
                            ),
                          
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                          //   child: Text(
                          //     "Free",
                          //     style: TextStyle(
                          //         fontSize: 17,
                          //         fontWeight: FontWeight.w700,
                          //         color: Colors.black.withOpacity(0.5)),
                          //   ),
                          // )
                        ],
                      ),

                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: <Widget>[
                      //     Icon(
                      //       Icons.location_on,
                      //       color: Colors.blue,
                      //       size: 20,
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                      //       child: Text(
                      //         "Potheri",
                      //         style: TextStyle(
                      //             fontSize: 17,
                      //             fontWeight: FontWeight.w700,
                      //             color: Colors.black.withOpacity(0.5)),
                      //       ),
                      //     )
                      //   ],
                      // ),


                    ],
                  ),
                )
              ],
            ),
          ),
        ),
    );
  

  }




}
