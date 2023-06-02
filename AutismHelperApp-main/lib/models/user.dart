import 'package:autism_helper_project/models/picture.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User1 {
   String userId;
   String name;
   String email;
   String userProfilePictureUrl;
   List<Picture> pictures;

  User1({
    this.name = '',
    this.email = '',
    this.userId = '',
    this.userProfilePictureUrl = '',
    this.pictures = const [],
  });


  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Email': email,
      'IDD' : userId,
      'ProfilePictureURL': userProfilePictureUrl,
    };
  }

   Map<String, dynamic> imageToMap() {
     return {
       'ProfilePictureURL': userProfilePictureUrl,
     };
   }



  factory User1.fromMap(DocumentSnapshot data ) {
    return User1(
        name: data['Name'],
        userProfilePictureUrl: data['ProfilePictureURL'],
        email: data['Email'],
        userId : data['IDD']
    );
  }

}
