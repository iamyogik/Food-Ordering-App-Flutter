import 'package:flutter/material.dart';





class CustomFocusNodeHandler extends StatefulWidget {
  final Widget Function(BuildContext buildContext, FocusNode focusNode, bool isFocused, Color borderColor) builder;
  String errorMsg;

  CustomFocusNodeHandler({Key key, this.builder, this.errorMsg}) : super(key: key);
  
  @override
  _CustomFocusNodeHandlerState createState() => _CustomFocusNodeHandlerState();
}

class _CustomFocusNodeHandlerState extends State<CustomFocusNodeHandler> {


  FocusNode _focusNode = new FocusNode();
  bool _isFocused = false;
  Color borderColor;

  @override
  void initState(){
      super.initState();

      
      _focusNode.addListener(_focusNodeListener);
  }

  void _focusNodeListener(){
    if (_focusNode.hasFocus){
      setState(() {
        _isFocused = true; 
      });
    } else {
      setState(() {
        _isFocused = false; 
      });
    }
}

  @override
  Widget build(BuildContext context) {

    if(widget.errorMsg == ""){
      if(_isFocused == true){
        borderColor = Colors.black;
      }else{
        borderColor = Colors.black.withOpacity(0.5);
      }
    }else{
      borderColor = Colors.red;
    }

   

    return Column(
      children: <Widget>[

       widget.builder(context, _focusNode, _isFocused, borderColor),

      widget.errorMsg == "" ?

      Container() 
      
      :


      Container(
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.topLeft,
          child: Text(
            widget.errorMsg,
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

        ),

    ],
    );
  }
}
