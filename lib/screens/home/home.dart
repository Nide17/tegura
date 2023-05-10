import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tegura/screens/my_appbar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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

          // CHILDREN OF THE COLUMN WIDGET
          children: [
            const SizedBox(height: 16),

            // TEXT WIDGET TO DISPLAY THE TEXT
            const Text(
              "Mwiriwe neza!",
              style: TextStyle(
                fontSize: 23.0,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // TEXT WIDGET TO DISPLAY THE TEXT
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0,
                  8.0), // Add 16.0 pixels of padding to all sides
              child: Text(
                "Iga amategeko y'umuhanda utavunitse kandi udahenzwe!",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // BOTTOM BORDER OF THE ABOVE SECTION
            Container(
              color: const Color.fromARGB(255, 0, 0, 0),
              height: 8.0,
            ),
            // TEXT WIDGET TO DISPLAY THE TEXT
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0,
                  8.0), // Add 16.0 pixels of padding to all sides
              child: Text(
                "Amasomo ateguwe muburyo bufasha umunyeshuri gusobanukirwa neza amategeko y'umuhanda ndetse agategurwa kuzakora ikizamini cya provisoire agatsinda ntankomyi!",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // BOTTOM BORDER OF THE ABOVE SECTION
            Container(
              color: const Color.fromARGB(255, 0, 0, 0),
              height: 8.0,
            ),

            // TEXT WIDGET TO DISPLAY THE TEXT
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0,
                  8.0), // Add 16.0 pixels of padding to all sides
              child: Text(
                "Kanda aha utangire kwiga",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // DOWN ARROW ICON SVG
            SvgPicture.asset(
              'assets/images/down_arrow.svg',
              height: 44.0,
            ),
            const SizedBox(height: 8),

            // IGA ROUNDED GREEN BUTTON WITH YELLOW TEXT
            GestureDetector(
              // NAVIGATE TO IGA
              onTap: () {
                Navigator.pushNamed(context, '/iga');
              },
              child: Container(
                width: 180.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: const Color(0XFF00A651),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: const Center(
                  child: Text(
                    "IGA",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFFFFBD59),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // TEXT WIDGET TO DISPLAY THE TEXT
            const Text(
              "Kanda aha ubone ibiciro byo kwiga",
              style: TextStyle(
                fontSize: 18.0,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // DOWN ARROW ICON SVG
            SvgPicture.asset(
              'assets/images/down_arrow.svg',
              height: 44.0,
            ),
            const SizedBox(height: 8),

            // IGA ROUNDED GREEN BUTTON WITH YELLOW TEXT
            GestureDetector(
              // NAVIGATE TO THE IBICIRO PAGE
              onTap: () {
                Navigator.pushNamed(context, '/ibiciro');
              },
              child: Container(
                width: 180.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: const Color(0XFF00A651),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: const Center(
                  child: Text(
                    "IBICIRO",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFFFFBD59),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
