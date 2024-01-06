import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tegura/providers/quiz_score_provider.dart';

typedef ShowQnCallback = void Function(int index);

class IkibazoButton extends StatefulWidget {
  final String buttonText;
  final ShowQnCallback showQn;
  final int index;
  final bool isActive;

  const IkibazoButton({
    super.key,
    required this.buttonText,
    required this.showQn,
    required this.index,
    required this.isActive,
  });

  @override
  State<IkibazoButton> createState() => _IkibazoButtonState();
}

class _IkibazoButtonState extends State<IkibazoButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizScoreProvider>(
        builder: (context, scoreProviderModel, child) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.02),
        ),
        width: MediaQuery.of(context).size.width * 0.1,
        child: ElevatedButton(
          onPressed: () {
            widget.isActive ? null : widget.showQn(widget.index);
          },
          style: ElevatedButton.styleFrom(
            fixedSize: Size(
              MediaQuery.of(context).size.width * 0.2,
              MediaQuery.of(context).size.height * 0.0,
            ),
            backgroundColor: widget.isActive
                ? const Color.fromARGB(255, 0, 47, 142)
                : scoreProviderModel
                        .quizScore.questions[widget.index].isAnswered
                    ? const Color(0xFF00CCE5)
                    : const Color.fromARGB(255, 167, 170, 210),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(
                  color: Color(0xFFFFBD59), width: 2, style: BorderStyle.solid
              )
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          ),
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.buttonText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      color: scoreProviderModel.quizScore
                                  .questions[widget.index].isAnswered ||
                              widget.isActive
                          ? Colors.white
                          : Colors.black),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
