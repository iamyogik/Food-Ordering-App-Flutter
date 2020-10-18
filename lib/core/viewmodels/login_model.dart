import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/localstorage_service.dart';
import './base_model.dart';
import '../../ui/views/loginPage.dart';
import '../../locator.dart';

class LoginModel extends BaseModel {

  final LocalStorageService storageService = locator<LocalStorageService>();

  String errorMessage;

  
  // Future<dynamic> facebookLogin() async{
  //   setViewState(ViewState.Busy);
  //   var response = await _authenticationService.facebookLogin();
  //   setViewState(ViewState.Idle);

  
  //   Route route;

  //   if (response['success']) {
  //     // Check if the user requires onboarding, Then create route for onboarding and if not then take him to home page
  //     route = MaterialPageRoute(builder: (context) => _basicSetupServices.getStartScreen());
  //     return route;
  //   } else {
  //     errorMessage = response['message'];
  //     // print(errorMessage);
  //     return route;
  //   }
 
  // }


  // Future<Route> googleLogin() async{
  //   setViewState(ViewState.Busy);
  //   var response = await _authenticationService.googleLogin();
  //   setViewState(ViewState.Idle);

  //   Route route;

  //   if (response['success']) {
  //     // Check if the user requires onboarding, Then create route for onboarding and if not then take him to home page
  //     route = MaterialPageRoute(builder: (context) => _basicSetupServices.getStartScreen());
  //     return route;
  //   } else {
  //     errorMessage = response['message'];
  //     // print(errorMessage);
  //     return route;
  //   }
 
  // }




  // Future<Route> loginUsingEmail(String email, String password) async {
  //   setViewState(ViewState.Busy);
  //   var response =  await _authenticationService.loginUsingEmail(email, password);
  //   setViewState(ViewState.Idle);

  //   Route route;

  //   if (response['success']) {
  //     // Check if the user requires onboarding, Then create route for onboarding and if not then take him to home page
  //     route = MaterialPageRoute(builder: (context) => _basicSetupServices.getStartScreen());
  //     return route;
  //   } else {
  //     errorMessage = response['message'];
  //     // print(errorMessage);
  //     return route;
  //   }
  // }


  // Future<Route> signupUsingEmail(String name, String email, String password) async{
  //   setViewState(ViewState.Busy);
  //   var response =  await _authenticationService.signupUsingEmail(name, email, password);
  //   setViewState(ViewState.Idle);

  //   Route route;

  //   if (response['success']) {
  //     // Check if the user requires onboarding, Then create route for onboarding and if not then take him to home page
  //     route = MaterialPageRoute(builder: (context) => _basicSetupServices.getStartScreen());
  //     return route;
  //   }else{
  //     errorMessage = response['message'];
  //     // print(errorMessage);
  //     return route;
  //   }



  // }



}
