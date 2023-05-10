import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tegura/models/user.dart';

class ProgressCircle extends StatelessWidget {
  // PROPERTIES
  double percent = 0.0;
  String progress = "";
  UserModel? usr;

  // CONSTRUCTOR - TO GET THE PERCENT, AUTH STATUS
  ProgressCircle(
      {super.key,
      required this.percent,
      required this.progress,
      required this.usr});

  // BUILD METHOD TO BUILD THE UI OF THE APP
  @override
  Widget build(BuildContext context) {
    print("User:$usr");

    return Center(
      child: Column(
        children: [
          SizedBox(
            height: usr != null ? 100 : 160,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. TEXT OUTPUT
                if (usr != null)
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(progress,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20.0,
                        )),
                  )
                else
                  Container(),

                // 2. CIRCULAR PERCENT INDICATOR
                SizedBox(
                  child: CircularPercentIndicator(
                    radius: 40.0,
                    lineWidth: 14.0,
                    animation: true,
                    percent: percent,
                    center: Text(
                      '${(percent * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 18.0),
                    ),
                    circularStrokeCap: CircularStrokeCap.butt,
                    progressColor: const Color(0xFF9D14DD),
                    backgroundColor: const Color(0xFF89D998),
                    footer: usr == null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              progress,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18.0,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          )
                        : null,
                  ),
                ),
              ],
            ),
          ),

          // 3. ADD 8.0 PIXELS OF SPACE
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
