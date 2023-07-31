import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heal/pages/home.dart';
import 'package:heal/pages/fidgets.dart';
import 'package:heal/tools/db.dart';
import 'dart:convert';

class JournalsPage extends StatefulWidget {
  const JournalsPage({Key? key}) : super(key: key);

  @override
  _JournalsPageState createState() => _JournalsPageState();
}

class _JournalsPageState extends State<JournalsPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: fetchDBJournals(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return const CircularProgressIndicator();
            } else {
              return Scaffold(
                  backgroundColor: const Color.fromRGBO(25, 25, 25, 1),
                  body: Stack(
                      children: <Widget>[
                        Positioned(
                            top: 0,
                            left: 0,
                            child: SizedBox(
                                height: 120,
                                width: 120,
                                child: SvgPicture.asset("assets/HEAL.svg")
                            )
                        ),
                        Positioned(
                            top: 50,
                            right: width * 0.05,
                            child: Text(
                                "Look Back At",
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800
                                )
                            )
                        ),
                        Positioned(
                            top: 75,
                            right: width * 0.05,
                            child: Text(
                                "Your Thoughts.",
                                style: GoogleFonts.inter(
                                    color: const Color.fromRGBO(215, 215, 255, 1),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400
                                )
                            )
                        ),
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
                                              TextSpan(
                                                  text: "Click ",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(215, 215, 255, 1)
                                                  )
                                              ),
                                              TextSpan(
                                                  text: "a journal to view journal writing."
                                              )
                                            ]
                                        )
                                    )
                                )
                            )
                        ),
                        Positioned(
                          top: height * 0.25,
                          left: width * 0.06,
                          child: SizedBox(
                            width: width * 0.88,
                            height: height * 0.5,
                            child: ListView.builder(
                              itemCount: snapshot.data[0]["journals"],
                              itemBuilder: (context, index) {
                                String journalData = snapshot.data[0]["journal${index + 1}"] as String;
                                return GestureDetector(
                                  onTap: () {
                                    _showBottomSheet(context, journalData);
                                  },
                                  child: SizedBox(
                                      height: height * 0.1,
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  10
                                              )
                                          ),
                                          color: const Color.fromRGBO(28, 28, 28, 1),
                                          child: Stack(
                                              children: <Widget>[
                                                Positioned(
                                                    left: (width * 0.9) * 0.05,
                                                    child: SizedBox(
                                                        width: (width * 0.9) * 0.70,
                                                        height: height * 0.1,
                                                        child: Stack(
                                                            children: [
                                                              Positioned(
                                                                  top: (height * 0.1) * 0.15,
                                                                  child: Text(
                                                                      capitalizeFirstLetter(jsonDecode(journalData)[0]),
                                                                      style: GoogleFonts.inter(
                                                                          color: const Color.fromRGBO(215, 215, 255, 1),
                                                                          fontSize: 15,
                                                                          fontWeight: FontWeight.w600
                                                                      )
                                                                  )
                                                              ),

                                                              Positioned(
                                                                  bottom: (height * 0.1) * 0.25,
                                                                  child: Text(
                                                                      jsonDecode(journalData)[2],
                                                                      style: GoogleFonts.inter(
                                                                        color: Colors.white,
                                                                        fontSize: 15,
                                                                      )
                                                                  )
                                                              ),
                                                            ]
                                                        )
                                                    )
                                                ),
                                              ]
                                          )
                                      )
                                  ),
                                );
                              }
                            )
                          )
                        ),
                        Positioned(
                            bottom: height * 0.0325,
                            left: width * 0.125,
                            child: Container(
                                width: width * 0.75,
                                height: height * 0.08,
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(32, 32, 32, 1),
                                    borderRadius: BorderRadius.all(Radius.circular((height * 0.08) / 2))
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                          color: Colors.white,
                                          icon: const FaIcon(FontAwesomeIcons.pencil, size: 15),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => const SoundsPage()
                                                )
                                            );
                                          }
                                      ),
                                      IconButton(
                                          color: Colors.white,
                                          icon: const FaIcon(FontAwesomeIcons.house, size: 15),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => const HomePage()
                                                )
                                            );
                                          }
                                      ),
                                      IconButton(
                                          color: const Color.fromRGBO(215, 215, 255, 1),
                                          icon: const FaIcon(FontAwesomeIcons.calendar, size: 15),
                                          onPressed: () {}
                                      )
                                    ]
                                )
                            )
                        )
                      ]
                  )
              );
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
                    )
                )
              )
            );
          }
        }
    );
  }
  Future fetchDBJournals() async {
    var dbData = readDB();
    return dbData;
  }
  void _showBottomSheet(BuildContext context, journalData) {
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.5,
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(25, 25, 25, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 20,
                  child: SizedBox(
                    width: width,
                    child: Center(
                      child: Text(
                        jsonDecode(journalData)[2],
                        style: GoogleFonts.inter(
                          color: const Color.fromRGBO(215, 215, 255, 1),
                          fontSize: 20
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 75,
                  left: width * 0.125,
                  child: SizedBox(
                    width: width * 0.75,
                    child: Text(
                      jsonDecode(journalData)[1],
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15
                      ),
                      textAlign: TextAlign.center,
                    )
                  )
                )
              ]
            ),
          ),
        );
      },
    );
  }
}

String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input; // Return the original string if it's null or empty
  }

  return input[0].toUpperCase() + input.substring(1);
}