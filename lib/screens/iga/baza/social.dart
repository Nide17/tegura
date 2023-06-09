// WIDGET FOR HOLDING TITLE WITH ICON AND TEXT
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tegura/screens/iga/baza/social_data.dart';

class Social extends StatelessWidget {
  const Social({super.key});

  @override
  Widget build(BuildContext context) {
    // LIST OF SOCIAL MEDIA DETAILS

    // RETURN EACH SOCIAL MEDIA USING THE CENTER WIDGET
    return Column(

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
                ),
          
                // HORIZONTAL SPACE
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
          
                // TEXT WIDGET
                Text((socialData[i]['title'] ?? '') + ': ' + (socialData[i]['details'] ?? ''),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
      ],
    );
  }
}
