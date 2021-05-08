import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restraunt_app/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffkey = GlobalKey<ScaffoldState>();
  String mail, password, errorMessage;

  /*final FirebaseAuth auth = FirebaseAuth.instance;

  Future <String> getCurrentUser()async{
    Firebase user = await auth.currentUser();
    return user.uid;
  }*/

  Future<void> signIn() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        await Firebase.initializeApp();
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: mail, password: password);
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      } catch (e) {
        print(e);

        setState(() {
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
              new ElevatedButton(onPressed: signIn, child: Text("LOGIN"))
            ],
          ),
        ),
      ),
    );
  }
}
