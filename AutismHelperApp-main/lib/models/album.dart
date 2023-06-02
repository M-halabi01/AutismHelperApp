import 'package:autism_helper_project/models/picture.dart';

//enum Group { me, person, game, feelings, food, drink, place }

class Album {
  Album({
    required this.label,
    required this.url,
    required this.albumColor,
    required this.id,
    this.pictures = const [],  });




  final String label;
  final String url;
  final int albumColor;
  final String id;

  final List<Picture> pictures;

  factory Album.fromMap(Map<String,dynamic> data) {
    return Album(
      id: data['IDD'],
        label: data['Label'],
        url: data['URL'],
        albumColor: int.parse(data['Color'])
    );
  }



}


