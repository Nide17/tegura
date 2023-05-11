import 'package:flutter/material.dart';
import 'package:tegura/screens/iga/hagati/user_progress.dart';

class HagatiLoggedIn extends StatelessWidget {
  const HagatiLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        UserProgress(
          title: 'IBYAPA BYO KUMIHANDA',
          description:
              'Ibyapa byo kumuhanda bigira uruhare runini mukurinda umutekano mumihanda yacu...',
          percent: 0.75,
        ),

        // 8.0 PIXELS OF SPACE
        const SizedBox(height: 8.0),

        UserProgress(
          title: 'IBIMENYETSO BYO MUMUHANDA',
          description:
              'Ibimenyetso byo mumuhanda ni imirongo cyangwa inyuguti bishushanyije mumuhanda...',
          percent: 0.3,
        ),
        
        // 8.0 PIXELS OF SPACE
        const SizedBox(height: 8.0),

        UserProgress(
          title: 'IMPANUKA',
          description:
              'Hari amategeko yihariye ajyena uko umuyobozi agomba kwitwara mubihe by\'impanuka...',
          percent: 0.0,
        ),
      ],
    );
  }
}
