import 'package:flutter/material.dart';
import 'package:food_delivery_app_crio/ui/views/home.dart';
import 'package:food_delivery_app_crio/ui/views/menu.dart';
import 'package:food_delivery_app_crio/ui/views/order_confirmation.dart';
import 'package:food_delivery_app_crio/ui/views/spash.dart';
import './core/services/localstorage_service.dart';
import './core/viewmodels/login_model.dart';
import './locator.dart';
import 'ui/views/loginPage.dart';
import 'ui/widgets/custom_focus_node_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  try {
    await setupLocator();
    runApp(MyApp());
  } catch (error) {
    print('Locator setup has failed');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Menu(restaurantId: "5d07d72aaace2b00085bd71d",),
      // home: OrderConfirmationPage(orderId: "5d08072955d61889804b9de0",),
      // home: HomeScreen(),
      home: SplashScreen(),
    );
  }
}
