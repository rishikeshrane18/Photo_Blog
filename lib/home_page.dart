import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restraunt_app/login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: Text( "HELLO BOI",
          style: TextStyle(
            fontSize: 50,
          ),
        ),
      ),
      bottomNavigationBar: new BottomAppBar(
        color: Color(0xffe53935),
        child: new Container(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.add_a_photo,),
                iconSize: 50,
                color: Colors.white,
                onPressed:null,
              ),
              new IconButton(
                icon: new Icon(Icons.home_outlined),
                iconSize: 50,
                color: Colors.white,
                onPressed: () => HomePage(),
              ),
              new IconButton(
                icon: new Icon(Icons.logout),
                iconSize: 50,
                color: Colors.white,
                onPressed:  _logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


void _logout() {
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    var user = FirebaseAuth.instance.currentUser;
  }
  //print('$user');
  runApp(
      new MaterialApp(
        home: new LoginPage(),
      )

  );
}

final FirebaseAuth auth = FirebaseAuth.instance;

void inputData() {
  final User user = auth.currentUser;
  final uid = user.uid;
  print("hello"+uid);
  // here you write the codes to input the data into firestore
}
