

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restraunt_app/login_page.dart';
import 'package:restraunt_app/photoUpload.dart';

import 'Posts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Posts> postsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference postRef = FirebaseDatabase.instance.reference().child("Posts");

    postRef.once().then((DataSnapshot snap)
    {
      var Keys = snap.value.keys;
      var Data = snap.value;

      postsList.clear();

      for(var indivisualKey in Keys){
        Posts posts =  new Posts(
          Data[indivisualKey]['image'],
          Data[indivisualKey]['description'],
          Data[indivisualKey]['date'],
          Data[indivisualKey]['time'],
        );
        postsList.add(posts);
      }
      setState(() {
        print('Length : $postsList.length');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          'PhoTo-'
        ),
      ),
      body: new Container(
          child: postsList.length == 0 ? new Text('NO POST IS THERE'): new ListView.builder(
            itemCount: postsList.length,
            itemBuilder: (_, index){
              return postUI(postsList[index].image,postsList[index].description,postsList[index].date,postsList[index].time);
            },
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
                icon: new Icon(
                  Icons.add_a_photo,
                ),
                iconSize: 50,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => UploadPhotoPage()));
                },
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
                onPressed: _logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget postUI(String image,String description,String date,String time){

    return new Card(
      elevation: 20,
      margin: EdgeInsets.all(20.0),

      child: new Container(
        padding: EdgeInsets.all(14.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
            Row(
              children:<Widget> [
                new Text(
                  date,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                new Text(
                  time,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 10,),
            new Image.network(image,fit: BoxFit.cover,),
            SizedBox(height: 10,),

            new Text(description,
            style: Theme.of(context).textTheme.subtitle1),

          ],
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
  runApp(new MaterialApp(
    home: new LoginPage(),
  ));
}

final FirebaseAuth auth = FirebaseAuth.instance;

void inputData() {
  final User user = auth.currentUser;
  final uid = user.uid;
  print("hello" + uid);
  // here you write the codes to input the data into firestore
}
