
class Picture {
  String id;
  String pictureLabel;
  String pictureUrl;
  String albumID;
  String userID;


   Picture({
     this.id = "",
     this.pictureLabel = "",
     this.pictureUrl = "",
     this.albumID = "",
     this.userID ="",
  });


  Map<String, dynamic> toMap() {
    return {
      'Label': pictureLabel,
      'AlbumID' : albumID,
      'UserID' : userID,
      'URL': pictureUrl,
    };
  }

  factory Picture.fromMap( Map<String,dynamic> data) {
    return Picture(
        id: data['IDD'],
        pictureLabel: data['Label'],
        pictureUrl: data['URL'],
        albumID: data['AlbumID'],
        userID: data['UserID']
    );
  }



}
