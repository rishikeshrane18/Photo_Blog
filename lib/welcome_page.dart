import 'package:flutter/material.dart';
import 'package:restraunt_app/login_page.dart';
import 'package:restraunt_app/signup_page.dart';

class WelcomePage extends StatelessWidget {
  Widget Button(@required String name,context){
    return Container(
      padding: EdgeInsets.all(20),
      height: 100,
      width: 330,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          elevation: 20,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: () {
          if(name == "LOGIN PAGE"){
            Navigator.push(context, MaterialPageRoute(builder:(BuildContext context)=>LoginPage()));
          }else if(name =="REGISTER PAGE"){
            Navigator.push(context, MaterialPageRoute(builder:(BuildContext context)=>SignupPage()));
          }
        },
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        children: [
          Expanded(
              child: Container(
            color: Colors.white,
            child: Center(
              child: Image.asset('images/logo.PNG'),
            ),
          )),
          Expanded(
              child: Container(
              color: Colors.pink,
              child: Column(
               children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "WELCOME TO WAFFLE WORLD",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                 Button("LOGIN PAGE",context),
                 Button("REGISTER PAGE",context),
              ],
            ),
          ),

          ),

        ],
      ),
    );
  }
}
