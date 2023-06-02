import 'package:autism_helper_project/screens/Home/drag_game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'match_game.dart';

class PuzzleGames extends StatelessWidget {
  const PuzzleGames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Center(
            child: Text(
              'Puzzle Games',
              style: GoogleFonts.abel(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          )),
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 320,
                        width: 300,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => const DragGame()));
                            },
                            child: Image.asset(
                              "images/drag.jpg",
                            )),
                      ),
                      const Text(
                        "Drag Game",
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 320,
                        width: 300,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => const MatchGame()));
                            },
                            child: Image.asset(
                              "images/match.jpg",
                            )),
                      ),
                      const Text(
                        "Match Game",
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
