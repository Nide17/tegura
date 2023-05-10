import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class UserProgress extends StatelessWidget {
  // INSTANCE VARIABLES
  double percent = 0.0;
  String title = "";
  String description = "";

  UserProgress({super.key, required this.percent, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: const Color(0xFF2C64C6),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children: [

            // TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 4.0),
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16.0,
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            // BOTTOM BORDER OF THE ABOVE SECTION
            Container(
              color: const Color(0xFFFFBD59),
              height: 6.0,
            ),

            // 8.0 PIXELS OF SPACE
            const SizedBox(height: 8.0),

            // DESCRIPTION
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                description,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                ),
              ),
            ),

            // 8.0 PIXELS OF SPACE
            const SizedBox(height: 8.0),

            // PROGRESS BAR WITH CTA BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // PROGRESS BAR
                LinearPercentIndicator(
                  width: 150,
                  animation: true,
                  lineHeight: 16.0,
                  animationDuration: 2500,
                  percent: percent,
                  center: Text(
                    '${(percent * 100).toStringAsFixed(0)}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                  barRadius: const Radius.circular(16.0),
                  backgroundColor: const Color(0xFF494F56),
                  progressColor: percent > 0.5
                      ? const Color(0xFF00A651)
                      : const Color(0xFFFF3131),
                ),

                // CTA BUTTON
                if (percent != 1.0) GestureDetector(
                  // NAVIGATE TO IGA
                  onTap: () {
                    Navigator.pushNamed(context, '/iga');
                  },
                  child: Container(
                    width: 100.0,
                    height: 18.0,
                    decoration: BoxDecoration(
                      color: const Color(0XFF00CCE5),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Center(
                      child: Text(
                        (percent == 0.0) ? "TANGIRA" : "KOMEZA",
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
