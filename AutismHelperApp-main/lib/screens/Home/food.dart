import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  FlutterTts flutterTts = FlutterTts();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Learn Words',
              style: GoogleFonts.abel(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: buildContent());
  }

  Padding buildContent() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
            childAspectRatio: 3 / 2),
        children: [
          ElevatedButton(
              onPressed: () {
                flutterTts.speak(
                  "burger",
                );
              },
              child: Image.asset(
                "images/burger.jpg",
              )),
          ElevatedButton(
              onPressed: () {
                flutterTts.speak(
                  "hotdog",
                );
              },
              child: Image.asset(
                "images/hotdog.jpg",
              )),
        ],
      ),
    );
  }
}
