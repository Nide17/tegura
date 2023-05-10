// WIDGET FOR HOLDING TITLE WITH ICON AND TEXT
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GradientTitle extends StatelessWidget {
  const GradientTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      height: 36.0,
      margin: const EdgeInsets.only(left: 10, top: 36),

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
        children: <Widget>[
          // ADD 10.0 PIXELS OF SPACE
          const SizedBox(width: 24.0),
          // SVG ICON
          SvgPicture.asset(
            'assets/images/video_icon.svg',
            height: 24.0,
          ),
          // ADD 10.0 PIXELS OF SPACE
          const SizedBox(width: 12.0),
          // TEXT WIDGET
          const Text('Amasomo ugezemo hagati',
              style: TextStyle(
                fontSize: 18.0,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
