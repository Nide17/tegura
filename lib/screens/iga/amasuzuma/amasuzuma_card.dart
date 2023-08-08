import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tegura/models/score.dart';
import 'package:tegura/models/user.dart';
import 'package:tegura/screens/iga/amasuzuma/amanota.dart';
import 'package:tegura/screens/iga/iga_card.dart';
import 'package:tegura/screens/iga/igazeti/igazeti_book.dart';

class AmasuzumaCard extends StatelessWidget {
  final String title;
  final String isuzumaID;
  final List<IsuzumaScoreModel>? amasuzumabumenyiScores;

  const AmasuzumaCard({
    Key? key,
    required this.title,
    required this.isuzumaID,
    required this.amasuzumabumenyiScores,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<UserModel?>(context);

    // FIND A SCORE WHERE THE TAKER ID IS THE CURRENT USER ID AND THE ISUZUMA ID IS THE CURRENT ISUZUMA ID
    final score = amasuzumabumenyiScores!.isNotEmpty
        ? amasuzumabumenyiScores!.firstWhere((element) =>
            element.takerID == usr!.uid && element.isuzumaID == isuzumaID)
        : null;

    return Column(
      children: [
        // CARDS ROW FOR IGAZETI, AND IBYAPA - FLEX 50%
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IgaCard(
              title: title,
              icon: 'assets/images/isuzuma.png',
              screen: const IgazetiBook(),
            ),
            score != null
                ? Amanota(
                    score: score.marks,
                    maxScore: score.totalMarks,
                  )
                : const Text(
                    'Nturarikora!',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ],
        ),

        // 3. VERTICAL SPACE
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
      ],
    );
  }
}
