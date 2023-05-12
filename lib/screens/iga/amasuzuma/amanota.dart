import 'package:flutter/material.dart';

class Amanota extends StatelessWidget {
  // INSTANCE VARIABLES
  final int score;
  final int maxScore;

  // CONSTRUCTOR
  const Amanota({super.key, required this.score, required this.maxScore});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.11,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 233, 232, 232),
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 6.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("$score/$maxScore"),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Text((score / maxScore) >= 0.6 ? "Watsinze" : "Watsinzwe",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: MediaQuery.of(context).size.width * 0.038,
                    color:
                        (score / maxScore) >= 0.6 ? Colors.green : Colors.red,
                  )),
            ],
          )),
    );
  }
}
