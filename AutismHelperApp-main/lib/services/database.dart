import 'dart:core';

import 'package:autism_helper_project/models/contact_us.dart';
import 'package:autism_helper_project/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/picture.dart';
import 'api_path.dart';
import 'firestore_service.dart';

abstract class Database {

  Future<void> setUserData(User1 user);
  Future<void> setPicture(Picture picture);
  Future<void> setContactUs(ContactUs contactUs);

  Future<void> deletePicture(Picture picture);


  Future<void> updateUserImage(User1 user);
  Future<void> updateUserdata(User1 user);
  Future<void> updateImage(Picture picture);

  DocumentReference<Map<String, dynamic>> getAboutUsData();
  DocumentReference<Map<String, dynamic>> getUser();
  Stream<dynamic> readPicture();
  Stream<dynamic> readAlbums();

}
class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid}) : assert(uid != null);

  final String? uid;
  final _service = FirestoreService.instance;

  String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

  @override
  Future<void> setUserData(User1 user) async => _service.setData(
    path: APIPath.users(),
    data: user.toMap(),
  );


  @override
  Future<void> setPicture(Picture picture) async => _service.setData(
    path: APIPath.picture(),
    data: picture.toMap(),
  );

  @override
  Future<void> deletePicture(Picture picture) async => _service.deleteData(
    path: '${APIPath.picture()}/${picture.id}',
  );



  @override
  Future<void> updateUserImage(User1 user) async => _service.updateDoc(
    path: APIPath.users(),
    docID: user.userId,
    data: user.imageToMap(),
  );

  @override
  Future<void> updateImage(Picture picture) async => _service.updateDoc(
    path: APIPath.picture(),
    docID: picture.id,
    data: picture.toMap(),
  );

  @override
  Future<void> updateUserdata(User1 user) async => _service.updateDoc(
    path: APIPath.users(),
    docID: user.userId,
    data: user.toMap(),
  );



  @override
  Future<void> setContactUs(ContactUs contactUs) async => _service.setData(
    path: APIPath.contactUS(),
    data: contactUs.toMap(),
  );

  @override
  Stream<dynamic> readAlbums() => _service.collectionStream(
    path: APIPath.albums(),
  );

  @override
  Stream<dynamic> readPicture() => _service.collectionStream(
    path: APIPath.picture(),
  );


  @override
  DocumentReference<Map<String, dynamic>> getUser() => _service.getDoc(
      path: APIPath.users(),
      documentID: uid!
  );


  @override
  DocumentReference<Map<String, dynamic>> getAboutUsData() => _service.getDoc(
      path: APIPath.aboutUS(),
      documentID: '0'
  );






}
