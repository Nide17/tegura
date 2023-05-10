import 'package:flutter/material.dart';

class HagatiNotLoggedIn extends StatelessWidget {
  const HagatiNotLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 4. TEXT Injira niba wariyandikishije cyangwa wiyandikishe utangire kwiga!
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: const Text(
            'Injira niba wariyandikishije cyangwa wiyandikishe utangire kwiga!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 22.0,
              color: Colors.white,
            ),
          ),
        ),

        // 5. ADD 10.0 PIXELS OF SPACE
        const SizedBox(height: 32.0),

        // 6. BUTTONS FOR INJIRA & IYANDIKISHE
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 6.1. INJIRA
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/injira');
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(152, 50),
                  backgroundColor: const Color(0xFF00CCE5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12.0),
                ),
                child: const Text(
                  'Injira',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),

              // 6.2. IYANDIKISHE
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/iyandikishe');
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(152, 50),
                  backgroundColor: const Color(0xFF00CCE5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12.0),
                ),
                child: const Text(
                  'Iyandikishe',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
