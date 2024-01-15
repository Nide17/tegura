import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tegura/models/course_progress.dart';
import 'package:tegura/models/isomo.dart';
import 'package:tegura/models/pop_question.dart';
import 'package:tegura/screens/iga/utils/custom_radio_button.dart';
import 'package:tegura/screens/iga/utils/gradient_title.dart';
import 'package:tegura/providers/quiz_score_provider.dart';
import 'package:tegura/firebase_services/isomo_progress.dart';
import 'package:tegura/utilities/ikibazo_button.dart';
import 'package:transparent_image/transparent_image.dart';

typedef ShowQnCallback = void Function(int index);
typedef SetSetSelectedOption = void Function(OptionPopQn? option);

class IsuzumeDetails extends StatefulWidget {
  final IsomoModel isomo;
  final String userID;
  final CourseProgressModel? courseProgress;
  final int qnIndex;
  final bool isCurrentCorrect;
  final ShowQnCallback showQn;
  final int selectedOption;
  final SetSetSelectedOption setSelectedOption;

  const IsuzumeDetails({
    super.key,
    required this.isomo,
    required this.userID,
    this.courseProgress,
    required this.qnIndex,
    required this.isCurrentCorrect,
    required this.showQn,
    required this.selectedOption,
    required this.setSelectedOption,
  });

  @override
  State<IsuzumeDetails> createState() => _IsuzumeDetailsState();
}

class _IsuzumeDetailsState extends State<IsuzumeDetails> {
  @override
  Widget build(BuildContext context) {
    final QuizScoreProvider scoreProviderModel =
        Provider.of<QuizScoreProvider>(context);

    // GET THE POP QUESTIONS
    final List<ScoreQuestion> scorePopQns =
        scoreProviderModel.quizScore.questions;

    // GET THE POP QUESTIONS LENGTH
    final scorePopQnsLength = scoreProviderModel.quizScore.questions.length;

    return Consumer<QuizScoreProvider>(
        builder: (context, scoreProviderModel, child) {
      return Container(
        padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
        decoration: const BoxDecoration(
          color: Color(0xFFD9D9D9),
        ),
        child: Column(children: [
          GradientTitle(
              title: widget.isomo.title,
              icon: 'assets/images/amasuzumabumenyi.svg',
              marginTop: 8.0,
              parentWidget: 'isuzume'),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Expanded(
              child: scorePopQnsLength == 0
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text('Nta bibazo byabonetse!'),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.008,
                              ),
                              child: Wrap(
                                  spacing: 10.0,
                                  direction: Axis.horizontal,
                                  children: List.generate(
                                    scorePopQnsLength,
                                    (index) => IkibazoButton(
                                      isActive: index == widget.qnIndex
                                          ? true
                                          : false,
                                      showQn: widget.showQn,
                                      qnIndex: index,
                                    ),
                                  ))),
                        ),

                        // SHOW THE QUESTION AND OPTIONS
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.04,
                              vertical:
                                  MediaQuery.of(context).size.height * 0.03,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    scorePopQns[widget.qnIndex]
                                            .popQuestion
                                            .title ??
                                        '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),

                                  // DISPLAY NETWORK IMAGE IF ANY
                                  scorePopQns[widget.qnIndex]
                                                  .popQuestion
                                                  .imageUrl ==
                                              null ||
                                          scorePopQns[widget.qnIndex]
                                                  .popQuestion
                                                  .imageUrl ==
                                              ''
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.16,
                                          child: Container(
                                            padding: const EdgeInsets.all(4.0),
                                            margin: const EdgeInsets.only(
                                                top: 10.0),
                                            decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              border: Border.fromBorderSide(
                                                BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  width: 1,
                                                  style: BorderStyle.solid,
                                                ),
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  offset: Offset(0, 1),
                                                  blurRadius: 1,
                                                ),
                                              ],
                                            ),
                                            child: FadeInImage.memoryNetwork(
                                              placeholder: kTransparentImage,
                                              image: scorePopQns[widget.qnIndex]
                                                  .popQuestion
                                                  .imageUrl!,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1,
                                            ),
                                          ),
                                        ),

                                  // SHOW THE DESCRIPTION IF THE QUESTION IS ANSWERED
                                  const SizedBox(height: 10.0),
                                  Column(
                                    children: scoreProviderModel
                                        .quizScore
                                        .questions[widget.qnIndex]
                                        .popQuestion
                                        .options
                                        .map<Widget>((option) {
                                      return CustomRadioButton(
                                        option: option,
                                        choosenOption: scoreProviderModel
                                            .quizScore
                                            .questions[widget.qnIndex]
                                            .choosenOption,
                                        isAnswered: scoreProviderModel
                                            .quizScore
                                            .questions[widget.qnIndex]
                                            .isAnswered,
                                        isAnswerCorrect: scoreProviderModel
                                            .quizScore
                                            .questions[widget.qnIndex]
                                            .isAnswerCorrect,
                                        isThisCorrect: widget.isCurrentCorrect,
                                        scoreProviderModel: scoreProviderModel,
                                        isSelected: option.id ==
                                            widget.selectedOption,
                                        currentQuestion:
                                            scorePopQns[widget.qnIndex]
                                                .popQuestion,

                                        // FUNCTION PROPERTIES
                                        onChanged: (value) {
                                          widget.setSelectedOption(option);

                                          // SET IS ANSWERED TO TRUE FOR THE CURRENT QUESTION IN THE SCORE OBJECT
                                          scoreProviderModel.quizScore
                                              .changeIsAnsweredStatus(
                                                  scorePopQns[widget.qnIndex]
                                                      .popQuestion
                                                      .id,
                                                  true);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
          ElevatedButton(
            onPressed: () {
              CourseProgressService().updateUserCourseProgress(
                widget.courseProgress != null
                    ? widget.courseProgress!.userId
                    : widget.userID,
                widget.courseProgress != null
                    ? widget.courseProgress!.courseId
                    : 0,
                0,
                widget.courseProgress != null
                    ? widget.courseProgress!.totalIngingos
                    : 1,
              );
              // GO BACK TO THE COURSE PAGE
              Navigator.pop(context);
            },
            child: const Text('Ongera utangire iri somo!'),
          ),
        ]),
      );
    });
  }
}
