// WIDGET FOR HOLDING TITLE WITH ICON AND TEXT
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GradientTitle extends StatelessWidget {

// INSTANCE VARIABLES
  final String title;
  final String icon;
  final double? marginTop;

// CONSTRUCTOR
  const GradientTitle({super.key, required this.title, required this.icon, this.marginTop});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.08,
        margin: EdgeInsets.only(left: 0, top: marginTop ?? 24),

        // STYLING
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),

          // THE GRADIENT
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.2677, 0.8325],
            colors: [
              Color(0xFF0500E5),
              Color(0xFF9D14DD),
            ],
          ),
        ),

        // CONTENT
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // HORIZONTAL SPACE
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),

            // SVG ICON
            icon != '' ? SvgPicture.asset(
              icon,
              height: MediaQuery.of(context).size.height * 0.03,
            ): Container(),

            // HORIZONTAL SPACE
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),

            // TEXT WIDGET
            Text(title,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.048,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.w400,
                )),
          ],
        ),
      ),
    );
  }
}
