import 'package:flutter/material.dart';
import 'package:food_delivery_app_crio/core/models/order_model.dart';
import 'package:food_delivery_app_crio/core/services/api.dart';
import 'package:food_delivery_app_crio/core/viewmodels/base_model.dart';
import 'package:food_delivery_app_crio/locator.dart';



class OrderModel extends BaseModel{
  Api _api = locator<Api>();

  OrderData _orderData = OrderData();

  get orderData => _orderData;

  set orderData(OrderData o){
    _orderData = o;
    notifyListeners();
  }



  dynamic getOrderData(orderId) async{
    setViewState(ViewState.Busy);

    var response = await _api.get("/qeats/order/${orderId}?token=wearegoingtorockit");

    
    if (response['success']) {

      //print(response);

      OrderData order = OrderData.fromJson(response['data']);

      orderData = order;
    }else{
      print("Error");
    }

    setViewState(ViewState.Idle);
    return true;
  }



  dynamic refreshOrderData(orderId) async{
    //print("refreshing");
    var response = await _api.get("/qeats/order/${orderId}?token=wearegoingtorockit");


    if (response['success']) {
      var order = OrderData.fromJson(response['data']);

      orderData = order;
    }

    return true;
  }


  dynamic cancelOrder(orderId) async{

    var response = await _api.get("/qeats/order/${orderId}/cancel-order?token=wearegoingtorockit");

    if (response['success']) {
      orderData.status = "CANCELLED";
      notifyListeners();
      //orderData = order;
      // getOrderData(orderId)
    }
    return true;

  }


}



