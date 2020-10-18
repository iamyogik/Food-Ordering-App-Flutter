import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<Login> {
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    /* try {
      if (validateAndSave()) {
        FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
        print("Logged in $userID");
        widget.onSignedIn();
      } else {
        Fluttertoast.showToast(
            msg: "Email and Password are incorrect",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      print("error $e");
    }*/
  }

  void moveToRegister() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: loginPageComponents(),
      ),
    );
  }

  Center loginPageComponents() {
    return Center(
        child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: new Form(
                key: formKey,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                    new Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    new TextFormField(
                      decoration: new InputDecoration(
                          labelText: "Email",
                          contentPadding: const EdgeInsets.all(20.0),
                          labelStyle: TextStyle(color: Colors.white)),
                      validator: (value) =>
                          value.isEmpty ? "Email Required" : null,
                      onSaved: (value) => _email = value,
                    ),
                    new TextFormField(
                      decoration: new InputDecoration(
                          labelText: "Password",
                          contentPadding: const EdgeInsets.all(20.0),
                          labelStyle: TextStyle(color: Colors.white)),
                      validator: (value) =>
                          value.isEmpty ? "Password Required" : null,
                      onSaved: (value) => _password = value,
                      obscureText: true,
                    ),
                    new SizedBox(
                      height: 20,
                    ),
                    new OutlineButton(
                        padding: EdgeInsets.all(10.0),
                        child: new Text(
                          "Login",
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.white),
                        ),
                        onPressed: validateAndSubmit,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
                    new FlatButton(
                      padding: EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
                      child: new Text(
                        "New Account",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      onPressed: moveToRegister,
                      shape: RoundedRectangleBorder(
                          // side: BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(50)),
                    )
                  ],
                ))));
  }
}
