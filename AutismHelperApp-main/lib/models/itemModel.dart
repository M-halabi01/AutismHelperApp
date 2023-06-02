
// ignore_for_file: file_names
class ItemModel {
  final String name;
  final String img;
  final String value;
  bool accepting;
  ItemModel(
      {required this.name,
      required this.value,
      required this.img,
      this.accepting = false});
}
