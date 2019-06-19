import 'package:food_delivery_app_crio/core/viewmodels/menu_model.dart';
import 'package:food_delivery_app_crio/core/viewmodels/order_confirmation.dart';
import 'package:get_it/get_it.dart';
import './core/services/localstorage_service.dart';
import 'core/viewmodels/login_model.dart';
import 'core/viewmodels/home_model.dart';
import 'core/services/api.dart';


GetIt locator = GetIt();

Future setupLocator() async{
  locator.registerFactory(() => LoginModel());

  
  var instance = await LocalStorageService.getInstance(); 
  locator.registerSingleton<LocalStorageService>(instance);

  
  
  locator.registerLazySingleton(() => Api());


  locator.registerFactory(() => HomeModel());

  
  locator.registerFactory(() => MenuModel());

  
  locator.registerFactory(() => OrderModel());

  
}