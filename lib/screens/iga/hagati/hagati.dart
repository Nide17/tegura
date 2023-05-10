import 'package:flutter/material.dart';
import 'package:tegura/screens/ibiciro/reba_ibiciro_button.dart';
import 'package:tegura/screens/iga/gradient_title.dart';
import 'package:tegura/screens/iga/hagati/progress_circle.dart';
import 'package:tegura/screens/my_appbar.dart';

class Hagati extends StatefulWidget {
  const Hagati({Key? key}) : super(key: key);

  @override
  _HagatiState createState() => _HagatiState();
}

class _HagatiState extends State<Hagati> {
  // BUILD METHOD TO BUILD THE UI OF THE APP
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF5B8BDF),

        // APP BAR
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(58.0),
          child: AppBarTegura(),
        ),

        // PAGE BODY
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[

              // 1. GRADIENT TITLE
              GradientTitle(),

              // 2. ADD 10.0 PIXELS OF SPACE
              SizedBox(height: 16.0),

              // 3. ELLIPSE WITH SPACES IN THE STROKE
              ProgressCircle()

            ]
          ),
        ),

        // BOTTOM NAVIGATION BAR
        bottomNavigationBar: const RebaIbiciro());
  }
}
