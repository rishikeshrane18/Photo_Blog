import 'dart:io';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotoPage extends StatefulWidget {
  @override
  _UploadPhotoPageState createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {

  File sampleImage;
  final formkey = new GlobalKey<FormState>();
  final picker = ImagePicker();

  Future getImage() async {
    // File _image;
    bool _isImageThere = false;
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        sampleImage = File(pickedFile.path);
        _isImageThere = !_isImageThere;
      } else {
        print('No image selected.');
      }
    });
    // Reference storageRef = FirebaseStorage.instance.ref("User Profile Photos");
    //
    // Future<void> uploadFile() async {
    //   UploadTask task = storageRef.child(user.uid + "hill").putFile(_image);
    //   DatabaseReference databaseRef = FirebaseDatabase.instance.reference().child("Users").child(user.uid);
    //
    //   task.whenComplete(() => task.snapshot.ref.getDownloadURL().then((value) => {
    //     print("Done: $value"),
    //     databaseRef.update({"Profile": value}),
    //     setState(() {
    //       _isImageThere = !_isImageThere;
    //     })
    //   }));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("UPLOAD PHOTO"),

      ),
      body: Center(
        child: sampleImage==null? Text("SELECT AN IMAGE"): enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'ADD IMAGE',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget enableUpload(){
      return new Form(
          key: formkey,

        child: Column(
          children:<Widget> [
            Image.file(sampleImage,height: 300,width: 600),
            SizedBox(height: 15,)
          ],
        ),
      );
  }

}
