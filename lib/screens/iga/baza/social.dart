// WIDGET FOR HOLDING TITLE WITH ICON AND TEXT
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tegura/screens/iga/baza/social_data.dart';

class Social extends StatelessWidget {
  const Social({super.key});

  @override
  Widget build(BuildContext context) {
    // RETURN EACH SOCIAL MEDIA USING THE CENTER WIDGET
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      // STYLING
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 4.0,
          color: const Color(0xFFFFBD59),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 43, 43, 43),
            offset: Offset(
              5.0,
              5.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ), //BoxShadow
          BoxShadow(
            color: Color.fromARGB(255, 71, 103, 158),
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
      ),
      child: Column(
        children: [
          // SOCIAL MEDIA LIST
          for (var i = 0; i < socialData.length; i++)

            // EACH SOCIAL MEDIA
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: <Widget>[
                  // HORIZONTAL SPACE
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),

                  // SVG ICON
                  SvgPicture.asset(
                    socialData[i]['icon'] ?? '',
                    height: MediaQuery.of(context).size.height * 0.05,
                    colorFilter: const ColorFilter.mode(
                        Color.fromARGB(255, 255, 255, 255), BlendMode.srcIn),
                  ),

                  // HORIZONTAL SPACE
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),

                  // TEXT WIDGET
                  // Text((socialData[i]['title'] ?? '') + ': ' + (socialData[i]['details'] ?? ''),
                  Text('  ${socialData[i]['details']}',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
