import 'dart:convert';
import 'package:food_delivery_app_crio/core/models/restaurant_model.dart';
import 'package:food_delivery_app_crio/core/services/api.dart';
import 'package:food_delivery_app_crio/core/viewmodels/base_model.dart';
import 'package:food_delivery_app_crio/locator.dart';




class HomeModel extends BaseModel{
  Api _api = locator<Api>();

  // final JsonDecoder _decoder = new JsonDecoder();

  List<RestaurantData> _homeDataJson;


  get homeDataJson => _homeDataJson;

  set homeDataJson(a){
    _homeDataJson = a;
  }

  dynamic getRestaurantData() async{
    
    setViewState(ViewState.Busy);

    //await Future.delayed(Duration(seconds: 3));

    var response = await _api.get("/qeats/restaurants?latitude=28.50&longitude=70.50&token=wearegoingtorockit");

    //print(response);

    if (response['success']) {
      var restaurantData = List<RestaurantData>();
      for (var data in response['data']) {
        restaurantData.add(RestaurantData.fromJson(data));
      }
      homeDataJson = restaurantData;
      //print(restaurantData);
    }

    setViewState(ViewState.Idle);
    return true;

  }


}

