import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heal/pages/home.dart';
import 'package:heal/pages/journals.dart';

class SoundsPage extends StatefulWidget {
  const SoundsPage({Key? key}) : super(key: key);

  @override
  _SoundsPageState createState() => _SoundsPageState();
}

class _SoundsPageState extends State<SoundsPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
              child: Text("Relax",
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800))),
          Positioned(
              top: 75,
              right: width * 0.05,
              child: Text("Yourself.",
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
                          text: const TextSpan(
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                              children: <TextSpan>[
                        TextSpan(
                            text: "Draw ",
                            style: TextStyle(
                                color: Color.fromRGBO(215, 215, 255, 1))),
                        TextSpan(text: "your stress away.")
                      ]))))),
          FingerPainter(),
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
                      children: [
                        IconButton(
                            color: const Color.fromRGBO(215, 215, 255, 1),
                            icon: const FaIcon(FontAwesomeIcons.pencil,
                                size: 15),
                            onPressed: () {}),
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

class FingerPainter extends StatefulWidget {
  @override
  _FingerPainterState createState() => _FingerPainterState();
}

class _FingerPainterState extends State<FingerPainter> {
  List<Offset> _points = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          RenderBox renderBox = context.findRenderObject() as RenderBox;
          Offset localPosition =
              renderBox.globalToLocal(details.globalPosition);
          _points = List.from(_points)..add(localPosition);
        });
      },
      onPanEnd: (details) {
        setState(() {});
      },
      child: CustomPaint(
        painter: _Painter(points: _points),
        size: Size.infinite,
      ),
    );
  }
}

class _Painter extends CustomPainter {
  final List<Offset> points;

  _Painter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromRGBO(215, 215, 255, 1)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6.0;

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) {
    return oldDelegate.points != points;
  }
}
