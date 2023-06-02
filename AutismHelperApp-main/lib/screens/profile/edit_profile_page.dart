
import 'dart:io';
import 'package:autism_helper_project/screens/common_widgets/app_bar_design.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../models/user.dart';
import '../../services/database.dart';
import '../common_widgets/profile_picture.dart';


class EditProfilePage extends StatefulWidget {
   const EditProfilePage({Key? key, required this.user, required this.database}) : super(key: key);


  final User1 user;
  final Database database;



  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  late User1 user;

  late String imageUrl;
  UploadTask? task;
  PlatformFile? pickedFile;

  final TextEditingController nameController = TextEditingController();

  String get name => nameController.text;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    user = widget.user;
    imageUrl =  widget.user.userProfilePictureUrl;
    return Scaffold(
        appBar: AppBarDesign(
          aTitle: Center(
            child: Text(
              'Edit Profile Page',
              style: GoogleFonts.abel(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          aLeading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context,user);
              }),
          user: widget.user,

        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      ProfilePicture(
                        pictureSize: 130,
                        pictureRadius: 200,
                        pictureUrl: imageUrl,
                      ),
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: CircleAvatar(
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white70,
                              size: 23,
                            ),
                            onPressed: () => yourChoice(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    user.name,
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 7),
                    child: const Text('Name :'),
                  ),
                  buildNameField(),
                  const SizedBox(height: 15),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 7),
                    child: const Text('Email :'),
                  ),
                  buildEmailField(),
                  const SizedBox(height: 15),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 7),
                    child: const Text('Password :'),
                  ),
                  buildPasswordField(context),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 130,
                        height: 40,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )),
                            ),
                            onPressed: () {
                              Navigator.pop(context,user);
                            },
                            child: const Text(
                              "CANCEL",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      const SizedBox(width: 70),
                      SizedBox(
                        width: 130,
                        height: 40,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )),
                            ),
                            onPressed: () {
                              saveEntries();
                              Navigator.pop(context,user);
                            },
                            child: const Text(
                              "SAVE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Padding buildNameField() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: TextFormField(
        controller: nameController
          ..text = user.name,
        decoration: const InputDecoration(
          fillColor: Colors.white,
          border: UnderlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(fontSize: 20),
        ),
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Padding buildEmailField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        enabled: false,
        controller: TextEditingController()
          ..text = user.email,
        onChanged: (text) => {},
        decoration: const InputDecoration(
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(fontSize: 20),
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Padding buildPasswordField(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: TextButton(onPressed: () async {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: user.email);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password Reset Email Sent , Check Spam Folder Please")));
      },
      child: const Text('Change Your Password'),
      ),
    );
  }

  void saveEntries() {
    user.name = name;
    widget.database.updateUserdata(user);
    setState((){});

  }

  void yourChoice(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () => Navigator.of(context).pop(selectImage(ImageSource.camera)) ,
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
                onTap: () => Navigator.of(context).pop(selectImage(ImageSource.gallery)),
              )
            ]
        )
    );
  }

  Future selectImage(ImageSource source) async {
    String imageUrl="";
    try {

      var newImage = await ImagePicker().pickImage(source: source);//getting picture from phone

      var imageFile = File(newImage!.path);

      String fileName = basename(imageFile.path);

      Reference storageRef = FirebaseStorage.instance.ref().child("UsersProfilePhoto/$fileName");

      UploadTask uploadTask = storageRef.putFile(imageFile);


      await uploadTask.whenComplete( () async {
        var url = await storageRef.getDownloadURL();
        imageUrl = url.toString();
      // ignore: body_might_complete_normally_catch_error
      }).catchError( (onError) {
        if (kDebugMode) {  print(onError);   }
      });


      widget.user.userProfilePictureUrl = imageUrl;
      widget.database.updateUserImage(widget.user);
      setState((){});


    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
    }
  }
}











