import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import 'package:autism_helper_project/models/user.dart';
import 'package:autism_helper_project/screens/Home/my_images.dart';
import 'package:autism_helper_project/screens/common_widgets/app_bar_design.dart';
import 'package:autism_helper_project/services/translator.dart';

import '../../Services/auth.dart';
import '../../models/album.dart';
import '../../models/picture.dart';
import '../../services/database.dart';
import '../albums_screens/album_page.dart';
import '../common_widgets/buttons/raised_button.dart';
import '../common_widgets/show_alert_dialog.dart';
import 'puzzle_games.dart';
import 'learn_words_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterTts flutterTts = FlutterTts();

  //var _icon = Icons.toggle_off_outlined;
  User1 user = User1(
      userId: '000',
      name: 'User',
      userProfilePictureUrl:
          'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80');

  late Database database = Provider.of<Database>(
    context,
    listen: false,
  );
  late DocumentReference<Map<String, dynamic>> userData = database.getUser();
  bool isDone = false;
  Translator translator = Translator();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    userData.get().then((DocumentSnapshot data) {
      if (data.exists) {
        user = User1.fromMap(data);
        if (!isDone) {
          setState(() {});
          isDone = true;
        }
      }
    });
    return Scaffold(
      appBar: AppBarDesign(
        aTitle: Center(child: Image.asset('images/title.jpg', scale: 18)),
        aLeading: menu(),
        user: user,
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    final Database database = Provider.of<Database>(
      context,
      listen: false,
    );
    final Stream<QuerySnapshot> albumStream =
        database.readAlbums() as Stream<QuerySnapshot>;
    return StreamBuilder<QuerySnapshot>(
        stream: albumStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
              ),
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                Album album = Album.fromMap(data);
                return SizedBox(
                  width: 150,
                  child: CustomRaisedButton(
                    onPressed: () => selectImage(album),
                    color: Color(album.albumColor),
                    child: Image.network(
                      album.url,
                      width: 150,
                      height: 150,
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        });
  }

  PopupMenuButton menu() {
    setState(() {});
    return PopupMenuButton(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 4.0,
        ),
        elevation: 20,
        offset: const Offset(0, 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        icon: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: Text("My Images"),
              ),
              const PopupMenuItem(
                value: 1,
                child: Text("Learn Words"), //Learn words
              ),
              const PopupMenuItem(
                value: 2,
                child: Text("Puzzle Games"), //Puzzle games
              ),
              const PopupMenuItem(
                value: 3,
                child: Text("Sign Out"),
              ),
            ],
        onSelected: (result) {
          if (result == 0) {
            if (user.userId != '000') {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) =>
                      MyImages(user: user, database: database)));
            } else {
              showAlertDialog(
                context,
                title: 'Warning!',
                content: 'You need to sign up to add photo',
                defaultActionText: 'OK',
                cancelActionText: '',
              );
            }
          }
          if (result == 1) {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => const LearnWordsPage()));
          } else if (result == 2) {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) =>  const PuzzleGames()));
          } else if (result == 3) {
            _confirmSignOut();
          }
        });
  }

  Future<void> _confirmSignOut() async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Sign out',
      content: 'Are you sure that you want to Sign out?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Sign out',
    );
    if (didRequestSignOut == true) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      _signOut();
    }
  }

  Future<void> _signOut() async {
    final AuthBase? auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth?.signOut();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          if (kDebugMode) {
            print("Anonymous auth hasn't been enabled for this project.");
          }
          break;
        default:
          if (kDebugMode) {
            print("Unknown error.");
          }
      }
    }
  }

  /*IconButton buildDarkModeButton() {
    return IconButton(
      icon: Icon(
        _icon,
        color: Colors.black,
        size: 50,
      ),
      onPressed: () {
        setState(() {
          if (_icon == Icons.toggle_off_outlined) {
            _icon = Icons.toggle_on_outlined;
            //themeChange.darkTheme = true;
          } else {
            _icon = Icons.toggle_off_outlined;
            //themeChange.darkTheme = false;
          }
        });
      },
    );
  }

   */ //darkModeButton

  selectImage(Album album) async {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    Picture picture = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              AlbumPage(user: user, album: album, database: database),
          fullscreenDialog: true,
        ));

    translator.addPicture(picture);

    Future speak() async {
      await flutterTts.speak(translator.sentence);
    }
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
      onVisible: () {
        speak();
      },
      content: Text(translator.sentence),
      actions: [
        TextButton(
          child: const Text('Dismiss'),
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          },
        ),
      ],
      leading: IconButton(
        icon: const Icon(Icons.volume_up),
        onPressed: () => speak(),
      ),
      backgroundColor: Colors.white,
    ));
  }
}
