import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CtaAuthLink extends StatelessWidget {
  final String text1;
  final String text2;
  final String route;
  final Color color1;
  final Color color2;

  const CtaAuthLink(
      {super.key,
      required this.text1,
      required this.text2,
      required this.route,
      required this.color1,
      required this.color2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ROW
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text1,
              style: TextStyle(
                color: color1,
                fontSize: MediaQuery.of(context).size.width * 0.035,
              ),
            ),

            // INK WELL
            InkWell(
              onTap: () {
                FirebaseAuth.instance.currentUser != null &&
                        (route == 'injira' || route == 'iyandikishe')
                    ? Navigator.pop(context)
                    : Navigator.pushNamed(context, route);
              },
              child: Text(
                text2,
                style: TextStyle(
                  color: color2,
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),

        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
      ],
    );
  }
}
