import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:food_delivery_app_crio/core/models/menu_model.dart';
import 'package:food_delivery_app_crio/ui/views/order_confirmation.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app_crio/core/viewmodels/base_model.dart';
import 'package:food_delivery_app_crio/core/viewmodels/menu_model.dart';
import 'package:food_delivery_app_crio/ui/views/base_view.dart';
import 'package:food_delivery_app_crio/ui/widgets/appBar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Menu extends StatefulWidget {
  final String restaurantId;
  Menu({this.restaurantId});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool orderNowButton = false;

  dynamic sendNewOrder(model, context) async {
    setState(() {
      orderNowButton = true;
    });

    Map<String, MenuData> _cart = model.getCart();

    String jsonStr = """{
                "userId":"dummy",
                "restaurantId": "${widget.restaurantId}",
                "items": [] 
                
                }""";

    var result = json.decode(jsonStr);

    _cart.forEach((k, v) {
      result['items'].add({"_id": v.sId, "quantity": v.total_items});
    });

    var response = await model.sendNewOrder(json.encode(result));
    print(response);

    if (response["success"]) {
      // print("yes");
      Route route = MaterialPageRoute(
          builder: (context) =>
              OrderConfirmationPage(orderId: response['data']['_id']));
      Navigator.push(context, route);
    } else {
      // print("no");
      final snackBar = SnackBar(
          content: Text("Could not place the order. Please try again later."));
      Scaffold.of(context).showSnackBar(snackBar);
    }

    setState(() {
      orderNowButton = false;
    });

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<MenuModel>(onModelReady: (model) {
      model.getMenuData(widget.restaurantId);
    }, builder: (context, model, child) {
      // print(model.getCart().length);

      return Scaffold(
        appBar: appBar(context, backAvailable: true),
        backgroundColor: Colors.white,
        body: model.state == ViewState.Busy
            ? Center(
                child: SpinKitChasingDots(color: Color(0xfffd5f00)),
              )
            : SafeArea(
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        //Search Bar
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextField(
                            style: TextStyle(fontSize: 18),

                            //controller: _textFieldController,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(15, 17, 15, 15),
                              prefixIcon: Icon(
                                Icons.search,
                              ),

                              //Add th Hint text here.
                              hintText: "Search for Cuisine",
                              hintStyle: TextStyle(fontSize: 18),

                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1.5),
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.4),
                                    width: 1.5),
                              ),
                            ),
                          ),
                        ),

                        //Menu Cards
                        Expanded(
                          child: ListView(
                              padding: const EdgeInsets.all(8.0),
                              children: <Widget>[
                                for (var data in model.menuData)
                                  MenuItemCard(data: data),


                                SizedBox(
                                  height: 80,
                                ),
                              ]),
                        ),
                      ],
                    ),
                    model.getCart().length == 0
                        ? Container()
                        : Positioned(
                            bottom: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              color: Colors.white,
                              child: Center(
                                child: RaisedButton(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0)),
                                  padding: EdgeInsets.fromLTRB(35, 15, 35, 15),
                                  onPressed: () async {
                                    if(!orderNowButton){
                                      await sendNewOrder(model, context);
                                    }
                                    
                                  },
                                  color: Color(0xffFD792B),
                                  child: orderNowButton
                                      ? 
                                      
                                      Container(
                                          width: 100,
                                          height: 22,
                                          alignment: Alignment.center,
                                          child: SpinKitDoubleBounce(color: Colors.white),
                                        )


                                      : 
                                      
                                      Container(
                                          width: 100,
                                          height: 22,
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Order Now",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              ),
      );
    });
  }
}

class MenuItemCard extends StatefulWidget {
  final MenuData data;
  MenuItemCard({this.data});

  @override
  _MenuItemCardState createState() => _MenuItemCardState();
}

class _MenuItemCardState extends State<MenuItemCard> {
  addItemCount(model) {
    setState(() {
      model.addOrder(widget.data);
    });
  }

  reduceItemCount(model) {
    setState(() {
      model.removeOrder(widget.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MenuModel>(context);
    return GestureDetector(
      onTap: () {
        // if(model.state == ViewState.Idle){
        //   // model.newOrder();
        // }
      },
      child: Container(
        foregroundDecoration: widget.data.isAvailable
            ? BoxDecoration()
            : BoxDecoration(
                color: Colors.grey,
                backgroundBlendMode: BlendMode.saturation,
              ),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: <Widget>[
              // Menu item image
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                child: FadeInImage.assetNetwork(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 200,
                  fit: BoxFit.cover,
                  placeholder: "assets/images/food-load-7.gif",
                  image: widget.data.imageUrl,
                ),
              ),

              //Menu Item Details
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                //color: Colors.red,
                width: MediaQuery.of(context).size.width * 0.5,
                height: 200,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Menu Item name

                    Spacer(
                      flex: 1,
                    ),

                    Text(
                      widget.data.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),

                    Text(
                      widget.data.description,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),

                    Spacer(
                      flex: 2,
                    ),

                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 5,
                      runSpacing: 5,
                      children: <Widget>[
                        for (var attr in widget.data.attributes)
                          Container(
                            padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Text(
                              attr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                      ],
                    ),

                    Spacer(
                      flex: 3,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.watch_later,
                          color: Colors.green,
                          size: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                          child: Text(
                            widget.data.preprationTime.toString() + "min.",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        )
                      ],
                    ),

                    Spacer(
                      flex: 1,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "₹ " + widget.data.price.toString(),
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),



                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Colors.red.withOpacity(0.85),
                            color: Color(0xfffd5f00).withOpacity(0.85),
                          ),
                          //padding: EdgeInsets.fromLTRB(10,5,10,5),
                          width: 130,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  if (widget.data.isAvailable) {
                                    reduceItemCount(model);
                                  }
                                },
                                child: Container(
                                  width: 40,
                                  padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                                  child: Icon(
                                    Icons.remove,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              model.getItemCount(widget.data) == 0
                                  ? Text(
                                      "ADD",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    )
                                  : Text(
                                      model
                                          .getItemCount(widget.data)
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                              GestureDetector(
                                onTap: () {
                                  if (widget.data.isAvailable) {
                                    addItemCount(model);
                                  }
                                },
                                child: Container(
                                  width: 40,
                                  // color: Colors.white,
                                  padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                                  child: Icon(
                                    Icons.add,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Spacer(
                      flex: 1,
                    ),
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
