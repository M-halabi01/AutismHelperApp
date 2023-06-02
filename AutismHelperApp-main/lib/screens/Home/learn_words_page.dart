import 'package:autism_helper_project/screens/Home/food.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LearnWordsPage extends StatefulWidget {
  const LearnWordsPage({Key? key}) : super(key: key);

  @override
  State<LearnWordsPage> createState() => _LearnWordsPageState();
}

class _LearnWordsPageState extends State<LearnWordsPage> {
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
                Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) =>const FoodPage()));
              },
              child: Image.asset(
                "images/food.jpg",
              )),
          ElevatedButton(
              onPressed: () {},
              child: Image.asset(
                "images/motions.jpg",
              )),
          ElevatedButton(
              onPressed: () {},
              child: Image.asset(
                "images/emotions.jpg",
              )),
          ElevatedButton(
              onPressed: () {},
              child: Image.asset(
                "images/vegtables.jpg",
              )),
          ElevatedButton(
              onPressed: () {},
              child: Image.asset(
                "images/fruits.jpg",
              )),
          ElevatedButton(
              onPressed: () {},
              child: Image.asset(
                "images/colors.jpg",
              )),
          ElevatedButton(
              onPressed: () {},
              child: Image.asset(
                "images/animals.jpg",
              )),
          ElevatedButton(
              onPressed: () {},
              child: Image.asset(
                "images/shapes.jpg",
              )),
        ],
      ),
    );
  }
}
