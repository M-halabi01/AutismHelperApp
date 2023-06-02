import 'package:cloud_firestore/cloud_firestore.dart';

class AboutUs {
  final String text;
  final String email;
  final String address;
  final String phoneNumber;

  AboutUs({
     this.text='',
     this.email='',
     this.phoneNumber='',
     this.address='',
  });


  factory AboutUs.fromMap(DocumentSnapshot data ) {
    return AboutUs(
        text: data['Text'],
        phoneNumber: data['MobilePhone'],
        email: data['Email'],
        address : data['address']
    );
  }


}