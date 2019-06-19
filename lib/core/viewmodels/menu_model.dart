import 'package:food_delivery_app_crio/core/models/menu_model.dart';
import 'package:food_delivery_app_crio/core/services/api.dart';
import 'package:food_delivery_app_crio/core/viewmodels/base_model.dart';
import 'package:food_delivery_app_crio/locator.dart';



class MenuModel extends BaseModel{
  Api _api = locator<Api>();

  Map<String, MenuData> _orderData = Map<String, MenuData>();

  List<MenuData> _menuData;

  String errorMessage;

  get menuData => _menuData;

  set menuData(m){
    _menuData = m;
  }


  dynamic newOrder() async{
    setViewState(ViewState.Busy);
    await Future.delayed(Duration(seconds: 2));
    setViewState(ViewState.Idle);
  }


  addOrder(MenuData data){
    if(_orderData[data.sId] != null){
      // data.total_items++;
      _orderData[data.sId].total_items++;
    }else{
      _orderData[data.sId] = data;
      _orderData[data.sId].total_items = 1;
    }

    notifyListeners();
    // print(_orderData.length);
  }

  removeOrder(MenuData data){
    if(_orderData[data.sId] != null){
      // data.total_items++;
      if(_orderData[data.sId].total_items == 1){
        _orderData.remove(data.sId);
      }else{
        _orderData[data.sId].total_items--;
      }
    }else{
      //_orderData[data.sId] = data;
    }

    notifyListeners();

  }


  getItemCount(data){
    if(_orderData[data.sId] == null){
      return 0;
    }else{
      return _orderData[data.sId].total_items;
    }
  }
  
  getCart() => _orderData;



  dynamic getMenuData(restaurantId) async{

    setViewState(ViewState.Busy);


    var response = await _api.get("/qeats/restaurant/${restaurantId}/menu?token=wearegoingtorockit");

    print(response);

    if (response['success']) {
      var menuDataList = List<MenuData>();
      for (var data in response['data']) {
        menuDataList.add(MenuData.fromJson(data));
      }
      menuData = menuDataList;
      print(menuData);
    }

    setViewState(ViewState.Idle);
    return true;

  }


  Future<dynamic> sendNewOrder(jsonData) async{

    Map<String, String> requestHeaders = {
       'Content-type': 'application/json',
       'Accept': 'application/json',
     };

     var response = await _api.post("/qeats/orders?token=wearegoingtorockit", body: jsonData, headers: requestHeaders);

    // print(response);
    
    return response;
  }




}