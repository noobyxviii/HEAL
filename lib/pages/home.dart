import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:heal/pages/journal.dart';
import 'package:heal/pages/journals.dart';
import 'package:heal/pages/fidgets.dart';
import 'package:heal/tools/db.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: _setup(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.data[1] == true) {
                return Scaffold(
                  backgroundColor: Color.fromRGBO(25, 25, 25, 1),
                  body: Stack(
                    children: <Widget> [
                      Positioned(
                          top: height * 0.25,
                          left: (width * 0.5) - 60,
                          child: SizedBox(
                              height: 120,
                              width: 120,
                              child: SvgPicture.asset("assets/HEAL.svg")
                          )
                      ),
                      Positioned(
                        top: height * 0.4,
                        child: SizedBox(
                          width: width,
                          child: Center(
                            child: Text(
                              "Privacy Based Mood Journal",
                              style: GoogleFonts.inter(
                                color: Color.fromRGBO(50, 50, 50, 1),
                                fontSize: 15
                              )
                            ),
                          ),
                        )
                      ),
                      Positioned(
                          top: height * 0.7825,
                          left: (width * 0.5) - 50,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => const HomePage()));
                                },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(215, 215, 255, 1),
                                  minimumSize: const Size(100, 50),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(25)))),
                              child: Text("Lets Go!",
                                  style: GoogleFonts.inter(
                                      color: const Color.fromRGBO(25, 25, 25, 1),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)))),
                    ]
                  )
                );
              }
              return Scaffold(
                  backgroundColor: const Color.fromRGBO(25, 25, 25, 1),
                  body: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: SizedBox(
                            height: 120,
                            width: 120,
                            child: SvgPicture.asset("assets/HEAL.svg"))),
                    Positioned(
                        top: 50,
                        right: width * 0.05,
                        child: Text("Welcome Back!",
                            style: GoogleFonts.inter(
                                color: Color.fromRGBO(215, 215, 255, 1),
                                fontSize: 15,
                                fontWeight: FontWeight.w800))),
                    Positioned(
                        top: height * 0.2,
                        child: SizedBox(
                            width: width,
                            child: Center(
                                child: RichText(
                                    text: const TextSpan(
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                        children: <TextSpan>[
                                  TextSpan(text: "How are you"),
                                  TextSpan(
                                      text: " feeling ",
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              215, 215, 255, 1))),
                                  TextSpan(text: "today?")
                                ]))))),
                    Positioned(
                        top: height * 0.25,
                        child: SizedBox(
                            width: width,
                            height: height * 0.6,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  left: width * 0.06,
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const JournalPage(
                                                        code: "great")));
                                      },
                                      child: Container(
                                          width: width * 0.41,
                                          height: (height * 0.6) * 0.59,
                                          decoration: const BoxDecoration(
                                              color:
                                                  Color.fromRGBO(28, 28, 28, 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          child: const Icon(
                                              FontAwesomeIcons.faceLaugh,
                                              size: 50,
                                              color: Colors.white)))),
                              Positioned(
                                  left: width * 0.06,
                                  top: (height * 0.6) * 0.65,
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const JournalPage(
                                                        code: "okay")));
                                      },
                                      child: Container(
                                          width: width * 0.41,
                                          height: (height * 0.6) * 0.35,
                                          decoration: const BoxDecoration(
                                              color:
                                                  Color.fromRGBO(28, 28, 28, 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          child: const Icon(
                                              FontAwesomeIcons.faceMeh,
                                              size: 50,
                                              color: Colors.white)))),
                              Positioned(
                                  left: width * 0.53,
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const JournalPage(
                                                        code: "good")));
                                      },
                                      child: Container(
                                          width: width * 0.41,
                                          height: (height * 0.6) * 0.4,
                                          decoration: const BoxDecoration(
                                              color:
                                                  Color.fromRGBO(28, 28, 28, 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          child: const Icon(
                                              FontAwesomeIcons.faceSmile,
                                              size: 50,
                                              color: Colors.white)))),
                              Positioned(
                                  left: width * 0.53,
                                  top: (height * 0.6) * 0.46,
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const JournalPage(
                                                        code: "bad")));
                                      },
                                      child: Container(
                                          width: width * 0.41,
                                          height: (height * 0.6) * 0.54,
                                          decoration: const BoxDecoration(
                                              color:
                                                  Color.fromRGBO(28, 28, 28, 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          child: const Icon(
                                              FontAwesomeIcons.faceSadTear,
                                              size: 50,
                                              color: Colors.white))))
                            ]))),
                    Positioned(
                        bottom: height * 0.0325,
                        left: width * 0.125,
                        child: Container(
                            width: width * 0.75,
                            height: height * 0.08,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(32, 32, 32, 1),
                                borderRadius: BorderRadius.all(
                                    Radius.circular((height * 0.08) / 2))),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                      color: Colors.white,
                                      icon: const FaIcon(
                                          FontAwesomeIcons.pencil,
                                          size: 15),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SoundsPage()));
                                      }),
                                  IconButton(
                                      color: const Color.fromRGBO(
                                          215, 215, 255, 1),
                                      icon: const FaIcon(FontAwesomeIcons.house,
                                          size: 15),
                                      onPressed: () {}),
                                  IconButton(
                                      color: Colors.white,
                                      icon: const FaIcon(
                                          FontAwesomeIcons.calendar,
                                          size: 15),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const JournalsPage()));
                                      })
                                ])))
                  ]));
            }
          } else {
            return Scaffold(
                backgroundColor: const Color.fromRGBO(25, 25, 25, 1),
                body: Center(
                    child: SizedBox(
                        height: (width * 0.9) * 0.15,
                        width: (width * 0.9) * 0.15,
                        child: const CircularProgressIndicator(
                          color: Color.fromRGBO(215, 215, 255, 1),
                        ))));
          }
        });
  }
}

Future _setup() async {
  String databasesPath = await getDatabasesPath();
  String path = join(databasesPath, "appData.db");
  Database database = await openDatabase(path, version: 1, onCreate: _onCreate);
  List<Map<String, Object?>> dbResult =
      await database.rawQuery("SELECT * FROM USER");
  bool firstOpen = false;
  if (dbResult[0]["new"] == 1) {
    firstOpen = true;
    updateDB("new", 0);
  }
  var data = await readDB();
  return [data, firstOpen];
}

void _onCreate(Database database, int version) async {
  await database.execute("""CREATE TABLE IF NOT EXISTS USER(
      new INTEGER,
      journals INTEGER
    )
    """);
  await database.insert("USER",
      {"new": 1, "journals": 0});
}
