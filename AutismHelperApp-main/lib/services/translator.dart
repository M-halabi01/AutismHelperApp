

import '../models/picture.dart';

class Translator {
  int firstAlbumId = -1;
  int secondAlbumId =  -1;

  late Picture firstPicture ;
  late Picture secondPicture ;

  String sentence = "";


  void addPicture(Picture picture) {

    if(firstAlbumId == -1 && secondAlbumId == -1) {
        firstAlbumId = int.parse(picture.albumID);
        firstPicture = picture;
        addFirstPicture();
      }

    else if(firstAlbumId != -1 && secondAlbumId == -1) {
        secondAlbumId = int.parse(picture.albumID);
        secondPicture = picture;
        addSecondPicture(picture);
      }

    else if(firstAlbumId != -1 && secondAlbumId != -1) {
      firstAlbumId = int.parse(picture.albumID);
      firstPicture = picture;
      secondAlbumId = -1;
      addFirstPicture();
    }

  }


  void addFirstPicture() {
    if(firstAlbumId == 0)
    {
      sentence = "I want to see ${firstPicture.pictureLabel}";
    }
    else if(firstAlbumId == 1)
    {
      sentence = "I feel ${firstPicture.pictureLabel}";
    }
    else if(firstAlbumId == 2)
    {
      sentence = "I want to go ${firstPicture.pictureLabel}";
    }
    else if(firstAlbumId == 3)
    {
      sentence = "I want to play ${firstPicture.pictureLabel}";
    }
    else if(firstAlbumId == 4)
    {
      sentence = "I want to drink ${firstPicture.pictureLabel}";
    }
    else if(firstAlbumId == 5)
    {
      sentence = "I want to eat ${firstPicture.pictureLabel}";
    }
  }

  void addSecondPicture(Picture picture) {
    if(firstAlbumId == 0)
    {
      ifTheFirstAlbumIs0();
    }
    else if(firstAlbumId == 1)
    {
      ifTheFirstAlbumIs1();
    }
    else if(firstAlbumId == 2)
    {
      ifTheFirstAlbumIs2();
    }
    else if(firstAlbumId == 3)
    {
      ifTheFirstAlbumIs3();
    }
    else if(firstAlbumId == 4)
    {
      ifTheFirstAlbumIs4();
    }
    else if(firstAlbumId == 5)
    {
      ifTheFirstAlbumIs5();
    }
  }

  void ifTheFirstAlbumIs0() {
    if(secondAlbumId == 0)
    {
      sentence = "${firstPicture.pictureLabel} want to see ${secondPicture.pictureLabel}";
    }
    else if(secondAlbumId == 1)
    {
      sentence = "${firstPicture.pictureLabel} feel ${secondPicture.pictureLabel}";
    }
    else if(secondAlbumId == 2)
    {
      sentence = "i want to go ${secondPicture.pictureLabel} with ${firstPicture.pictureLabel}";
    }
    else if(secondAlbumId == 3)
    {
      sentence = "i want to play ${secondPicture.pictureLabel} with ${firstPicture.pictureLabel}";
    }
    else if(secondAlbumId == 4)
    {
      sentence = "i want to drink ${secondPicture.pictureLabel} with ${firstPicture.pictureLabel}";
    }
    else if(secondAlbumId == 5)
    {
      sentence = "i want to eat ${secondPicture.pictureLabel} with ${firstPicture.pictureLabel}";
    }
  }

  void ifTheFirstAlbumIs1() {
    if(secondAlbumId == 0) {
      sentence = "${secondPicture.pictureLabel} feel ${firstPicture.pictureLabel}";
    }
    else if(secondAlbumId == 2) {
      sentence = "I feel ${firstPicture.pictureLabel} in the ${secondPicture.pictureLabel}";
    }
    else {
      firstAlbumId = secondAlbumId;
      secondAlbumId = -1;
      firstPicture = secondPicture;
      addFirstPicture();
    }
  }

  void ifTheFirstAlbumIs2() {
    if(secondAlbumId == 0) {
      sentence = "i want to go ${firstPicture.pictureLabel} with ${secondPicture.pictureLabel}";
    }
    else if(secondAlbumId == 1) {
      sentence = "I feel ${secondPicture.pictureLabel} in the ${firstPicture.pictureLabel}";
    }
    else if(secondAlbumId == 4) {
      sentence = "i want to drink ${secondPicture.pictureLabel} in the ${firstPicture.pictureLabel}";
    }
    else if(secondAlbumId == 5) {
      sentence = "i want to eat ${secondPicture.pictureLabel} in the ${firstPicture.pictureLabel}";
    }
    else {
      firstAlbumId = secondAlbumId;
      secondAlbumId = -1;
      firstPicture = secondPicture;
      addFirstPicture();
    }
  }

  void ifTheFirstAlbumIs3() {
    if(secondAlbumId == 0) {
      sentence = "i want to play ${firstPicture.pictureLabel} with ${secondPicture.pictureLabel}";
    }
    else {
      firstAlbumId = secondAlbumId;
      secondAlbumId = -1;
      firstPicture = secondPicture;
      addFirstPicture();
    }
  }

  void ifTheFirstAlbumIs4() {
    if(secondAlbumId == 0) {
      sentence = "i want to drink ${firstPicture.pictureLabel} with ${secondPicture.pictureLabel}";
    }
    else if(secondAlbumId == 2) {
      sentence = "i want to drink ${firstPicture.pictureLabel} in the ${secondPicture.pictureLabel}";
    }

    else {
      firstAlbumId = secondAlbumId;
      secondAlbumId = -1;
      firstPicture = secondPicture;
      addFirstPicture();
    }
  }


  void ifTheFirstAlbumIs5() {
    if(secondAlbumId == 0) {
      sentence = "i want to eat ${firstPicture.pictureLabel} with ${secondPicture.pictureLabel}";
    }
    else if(secondAlbumId == 2) {
      sentence = "i want to eat ${firstPicture.pictureLabel} in the ${secondPicture.pictureLabel}";
    }
    else {
      firstAlbumId = secondAlbumId;
      secondAlbumId = -1;
      firstPicture = secondPicture;
      addFirstPicture();
    }
  }


}