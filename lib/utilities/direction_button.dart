import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tegura/firebase_services/pop_question_db.dart';
import 'package:tegura/models/course_progress.dart';
import 'package:tegura/models/ingingo.dart';
import 'package:tegura/models/isomo.dart';
import 'package:tegura/models/pop_question.dart';
import 'package:tegura/screens/iga/utils/pop_quiz.dart';
import 'package:tegura/firebase_services/isomo_progress.dart';

class DirectionButton extends StatefulWidget {
  final String buttonText;
  final String direction;
  final double opacity;
  final ValueChanged<int> changeSkipNumber;
  final Function scrollTop;
  final IsomoModel isomo;
  final int skip;
  final int increment;

  const DirectionButton({
    super.key,
    required this.buttonText,
    required this.direction,
    required this.opacity,
    required this.changeSkipNumber,
    required this.scrollTop,
    required this.isomo,
    required this.skip,
    required this.increment,
  });

  @override
  State<DirectionButton> createState() => _DirectionButtonState();
}

class _DirectionButtonState extends State<DirectionButton> {
  @override
  Widget build(BuildContext context) {
    
    final pageIngingos = Provider.of<List<IngingoModel>?>(context) ?? [];
    final courseProgress = Provider.of<CourseProgressModel?>(context);

    return MultiProvider(
      providers: [
        // POP QUESTIONS STREAM PROVIDER FOR THE CURRENT RANGE OF INGINGOS
        StreamProvider<List<PopQuestionModel>?>.value(
          value: PopQuestionService().getPopQuestionsByIngingoIDs(
              widget.isomo.id,
              List<int>.from(
                  pageIngingos.map((ing) => ing.id + widget.increment))),
          initialData: null,
          catchError: (context, error) {
            return [];
          },
        ),
      ],
      child: Consumer<List<PopQuestionModel>?>(
          builder: (context, popQuestions, child) {
            print('POP QUESTIONS: $popQuestions');
        // LIST OF INGINGOS STATE IDS
        List<int> currentIngingosIds = pageIngingos.map((e) => e.id).toList();

        // CHECK IF THE FIRST POP QUESTION ID IS IN THE LIST OF INGINGOS IDS
        bool isIngingosHavePopQuestions = currentIngingosIds.contains(
            popQuestions != null && popQuestions.isNotEmpty
                ? popQuestions[0].ingingoID
                : 0);
        return ElevatedButton(
          onPressed: () {
            // SCROLL TO THE TOP
            widget.scrollTop();

            // DECREASE SKIP STATE
            if (widget.direction == 'inyuma') {
              widget.changeSkipNumber(-5);
            }
            // IF THIS PAGE HAS POP QUESTIONS, THEN SHOW THEM FIRST BEFORE PROCEEDING TO THE NEXT PAGE
            else if (widget.direction == 'komeza') {
              if (popQuestions != null &&
                  popQuestions.isNotEmpty &&
                  isIngingosHavePopQuestions) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PopQuiz(
                      popQuestions: popQuestions,
                      isomo: widget.isomo,
                      coursechangeSkipNumber: widget.changeSkipNumber,
                    ),
                  ),
                );
              } else {
                widget.changeSkipNumber(5);
              }

              // UPDATE THE CURRENT INGINGO
              if (widget.skip > 0 &&
                  widget.skip <= courseProgress!.totalIngingos &&
                  pageIngingos.length + widget.skip >
                      courseProgress.currentIngingo) {
                CourseProgressService().updateUserCourseProgress(
                  courseProgress.userId,
                  widget.isomo.id,
                  widget.skip + pageIngingos.length,
                  courseProgress.totalIngingos,
                );
              }
            }
          },
          style: ElevatedButton.styleFrom(
            fixedSize: Size(
              MediaQuery.of(context).size.width * 0.3,
              MediaQuery.of(context).size.height * 0.0,
            ),
            backgroundColor: const Color(0xFF00CCE5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          ),
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ICON
                Visibility(
                  visible: widget.direction == 'inyuma' ? true : false,
                  child: Opacity(
                    opacity: widget.opacity,
                    child: SvgPicture.asset(
                      widget.direction == 'inyuma'
                          ? 'assets/images/backward.svg'
                          : 'assets/images/forward.svg',
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                ),
                Text(
                  widget.buttonText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      color: Colors.black),
                ), // ICON
                Visibility(
                  visible: widget.direction == 'inyuma' ? false : true,
                  child: Opacity(
                    opacity: widget.opacity,
                    child: SvgPicture.asset(
                      widget.direction == 'inyuma'
                          ? 'assets/images/backward.svg'
                          : 'assets/images/forward.svg',
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
