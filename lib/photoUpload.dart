import 'dart:io';
import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'home_page.dart';

class UploadPhotoPage extends StatefulWidget {
  @override
  _UploadPhotoPageState createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  File sampleImage;
  final formkey = new GlobalKey<FormState>();
  final picker = ImagePicker();
  String _myValue;
  String url;

  Future getImage() async {
    // File _image;
  //  bool _isImageThere = false;
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    print('hello1');
    setState(() {
      if (pickedFile != null) {
        sampleImage = File(pickedFile.path);
       // _isImageThere = !_isImageThere;
        print('hello2');
      } else {
        print('No image selected.');
      }
    });
  }

  bool validateAndSave() {
   // final form = formkey.currentState;
    print('hello4');
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      print('hello daksh');
      return true;
      print('hello daksh');
    } else {
      return false;
    }
    print('hello daksh');
  }

  void uploadStatusImage() async {
    if (validateAndSave()) {
      print('hello5');
      final Reference storageRef =
          FirebaseStorage.instance.ref().child("POST IMAGES");

      var timeKey = new DateTime.now();

      final UploadTask uploadTask =
          storageRef.child(timeKey.toString() + ".jpg").putFile(sampleImage);
      print('hello3');
      var imageUrl = await (await uploadTask).ref.getDownloadURL();
      url = imageUrl.toString();

      goToHomePage();
      saveToDatabase(url);
    }
  }

  void saveToDatabase(url) {
    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d, YYY');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference reference = FirebaseDatabase.instance.reference();

    var data = {
      "image": url,
      "description": _myValue,
      "date": date,
      "time": time,
    };

    reference.child("Posts").push().set(data);
  }

  void goToHomePage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new Drawer(),
      appBar: new AppBar(
        title: new Text("UPLOAD PHOTO"),
      ),
      body: Center(
        child: sampleImage == null ? Text("SELECT AN IMAGE") : enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'ADD IMAGE',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget enableUpload() {
    return Container(
      child: new Form(
        key: formkey,
        child: Column(
          children: <Widget>[
            Image.file(sampleImage, height: 300, width: 600),
            // SizedBox(
            //   height: 15,
            // ),
            TextFormField(
              decoration: new InputDecoration(labelText: 'DESCRIPTION'),
              validator: (value) {
                return value.isEmpty ? 'DESCRIPTION IS EMPTY' : null;
              },
              onSaved: (value) {
                return _myValue = value;
              },
            ),
            // SizedBox(
            //   height: 15,
            // ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                elevation: 20,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(
                'ADD NEW A POST',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: uploadStatusImage,
            ),
          ],
        ),
      ),
    );
  }
}

// Reference storageRef = FirebaseStorage.instance.ref("User Profile Photos");
//
// Future<void> uploadFile() async {
//   UploadTask task = storageRef.child(user.uid + "hill").putFile(_image);
//   DatabaseReference databaseRef = FirebaseDatabase.instance.reference().child("Users").child(user.uid);
//
