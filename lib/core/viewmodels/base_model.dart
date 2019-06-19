import 'package:flutter/widgets.dart';
import '../enums/viewstate.dart';

enum ViewState{Idle, Busy}

class BaseModel extends ChangeNotifier {
  
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setViewState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

}