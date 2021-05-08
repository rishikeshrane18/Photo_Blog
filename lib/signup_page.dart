import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:restraunt_app/home_page.dart';

import 'login_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffkey = GlobalKey<ScaffoldState>();
  String mail,password,errorMessage;
  Future<void> signIn() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        await Firebase.initializeApp();
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: mail, password: password);
        Navigator.push(context, MaterialPageRoute(builder:(BuildContext context)=>LoginPage()));
      } catch (e) {
        print(e);

        setState((){
          errorMessage = e.toString();
        });
        final snackb = new SnackBar(
            backgroundColor: Colors.red,
            duration: new Duration(seconds: 6),
            content: new Text(
              errorMessage + " :(",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ));
        // ignore: deprecated_member_use
        scaffkey.currentState.showSnackBar(snackb);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffkey,
      backgroundColor: Color(0xffF48FB1),
      body: Center(
        child: Card(
          elevation: 20,
          child: Container(

            height: 400,
            width: 300,
            color: Colors.black,  
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(30),
                  ),
                  Card(
                    elevation: 20,
                    color: Colors.cyanAccent,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "EMAIL",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,width: 1),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) =>
                      val.contains("@") ? null : "Enter Valid Mail ID",
                      onSaved: (val) => mail = val,
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(5)),
                  Card(
                    elevation: 20,
                    color: Colors.cyanAccent,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "PASSWORD",
                      ),
                      keyboardType: TextInputType.name,
                      obscureText: true,
                      validator: (val) =>
                      val.length < 3 ? "Enter Bigger Password" : null,
                      onSaved: (val) => password = val,
                    ),
                  ),
                  new ElevatedButton(onPressed: signIn, child: Text("SIGN UP"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




























