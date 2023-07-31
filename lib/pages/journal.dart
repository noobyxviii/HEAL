import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heal/pages/home.dart';
import 'package:heal/pages/journals.dart';
import 'package:heal/pages/fidgets.dart';
import 'package:heal/tools/db.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({Key? key, required this.code}) : super(key: key);
  final String code;

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  final TextEditingController _journalController = TextEditingController();

  @override
  void dispose() {
    _journalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Map<String, List<String>> msgValues = {
      "great": ["Great!", "We're happy for you!"],
      "good": ["Nice!", "A few steps away from amazing!"],
      "okay": ["Oh no!", "We hope you get better soon!"],
      "bad": ["Oh no!", "We hope you get better soon!"]
    };
    String code = widget.code;
    return Scaffold(
        backgroundColor: const Color.fromRGBO(25, 25, 25, 1),
        body: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  height: 120,
                  width: 120,
                  color: Colors.red,
                  child: SvgPicture.asset("assets/HEAL.svg"))),
          Positioned(
              top: 50,
              right: width * 0.05,
              child: Text("Reflect On",
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800))),
          Positioned(
              top: 75,
              right: width * 0.05,
              child: Text("Your Thoughts",
                  style: GoogleFonts.inter(
                      color: const Color.fromRGBO(215, 215, 255, 1),
                      fontSize: 15,
                      fontWeight: FontWeight.w400))),
          Positioned(
              top: height * 0.2,
              child: SizedBox(
                  width: width,
                  child: Center(
                      child: RichText(
                          text: TextSpan(
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                              children: <TextSpan>[
                        TextSpan(
                            text: "${msgValues[code]![0]} ",
                            style: const TextStyle(
                                color: Color.fromRGBO(215, 215, 255, 1))),
                        TextSpan(text: msgValues[code]![1])
                      ]))))),
          Positioned(
              top: height * 0.25,
              left: width * 0.05,
              child: Container(
                  width: width * 0.9,
                  height: height * 0.5,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(28, 28, 28, 1),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: TextField(
                      controller: _journalController,
                      style:
                          GoogleFonts.inter(color: Colors.white, fontSize: 15),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Start Journaling Here...",
                          hintStyle: GoogleFonts.inter(
                              color: const Color.fromRGBO(50, 50, 50, 1),
                              fontSize: 15),
                          contentPadding: const EdgeInsets.all(25))))),
          Positioned(
              top: height * 0.7825,
              left: (width * 0.5) - 50,
              child: ElevatedButton(
                  onPressed: () {
                    addJournal(code, _journalController.text,
                        getCurrentTimeFormatted());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EntryCompletePage()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(215, 215, 255, 1),
                      minimumSize: const Size(100, 50),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)))),
                  child: Text("Save",
                      style: GoogleFonts.inter(
                          color: const Color.fromRGBO(25, 25, 25, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.bold)))),
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                            color: Colors.white,
                            icon: const FaIcon(FontAwesomeIcons.pencil,
                                size: 15),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SoundsPage()));
                            }),
                        IconButton(
                            color: Colors.white,
                            icon: const FaIcon(FontAwesomeIcons.house, size: 15),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            }),
                        IconButton(
                            color: Colors.white,
                            icon: const FaIcon(FontAwesomeIcons.calendar,
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
}

class EntryCompletePage extends StatelessWidget {
  const EntryCompletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color.fromRGBO(25, 25, 25, 1),
        body: Stack(children: <Widget>[
          Positioned(
              top: height * 0.25,
              left: (width * 0.5) - 60,
              child: SizedBox(
                  height: 120,
                  width: 120,
                  child: SvgPicture.asset("assets/HEAL.svg"))),
          Positioned(
              top: height * 0.4,
              left: width * 0.125,
              child: SizedBox(
                  width: width * 0.75,
                  child: Center(
                      child: Text(
                          "Your mood entry has been saved! Press the buttons below to go back!",
                          style: GoogleFonts.inter(
                            color: const Color.fromRGBO(50, 50, 50, 1),
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center)))),
          Positioned(
              top: height * 0.6,
              left: (width * 0.5) - 50,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                      minimumSize: const Size(100, 50),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)))),
                  child: Text("Home",
                      style: GoogleFonts.inter(
                          color: const Color.fromRGBO(25, 25, 25, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.bold)))),
        ]));
  }
}

String getCurrentTimeFormatted() {
  DateTime now = DateTime.now();

  String dayOfWeek = getDayOfWeek(now.weekday);
  String month = getMonth(now.month);

  String formattedTime =
      '$dayOfWeek, $month ${now.day}, ${now.year} ${_formatTwoDigits(now.hour)}:${_formatTwoDigits(now.minute)}';
  return formattedTime;
}

String getDayOfWeek(int weekday) {
  List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  return days[weekday - 1];
}

String getMonth(int month) {
  List<String> months = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  return months[month];
}

String _formatTwoDigits(int number) {
  return number.toString().padLeft(2, '0');
}
