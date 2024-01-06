import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tegura/models/course_progress.dart';
import 'package:tegura/models/isomo.dart';
import 'package:tegura/models/pop_question.dart';
import 'package:tegura/models/user.dart';
import 'package:tegura/screens/iga/utils/error_alert.dart';
import 'package:tegura/screens/iga/utils/isuzume_details.dart';
import 'package:tegura/providers/quiz_score_provider.dart';
import 'package:tegura/firebase_services/pop_question_db.dart';
import 'package:tegura/utilities/app_bar.dart';
import 'package:tegura/utilities/direction_button_isuzume.dart';
import 'package:tegura/utilities/loading_widget.dart';

class IsuzumeContent extends StatefulWidget {
  final IsomoModel isomo;
  final CourseProgressModel? courseProgress;
  const IsuzumeContent({super.key, required this.isomo, this.courseProgress});

  @override
  State<IsuzumeContent> createState() => _IsuzumeContentState();
}

class _IsuzumeContentState extends State<IsuzumeContent> {
  int qnIndex = 0;
  bool isCurrentCorrect = false;
  int selectedOption = -1;

  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<UserModel?>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuizScoreProvider(),
        ),
        // STREAM PROVIDER FOR POP QUESTIONS
        StreamProvider<List<PopQuestionModel>?>.value(
          // WHAT TO GIVE TO THE CHILDREN WIDGETS
          value: PopQuestionService().getPopQuestionsByIsomoID(
              widget.isomo.id), // GET THE POP QUESTIONS
          initialData: null,

          catchError: (context, error) {
            return [];
          },
        ),
      ],
      child: Consumer<QuizScoreProvider>(
        builder: (context, scoreProviderModel, child) {
          return Consumer<List<PopQuestionModel>?>(
            builder: (context, popQuestions, _) {
              if (popQuestions == null) {
                return const LoadingWidget();
              }

              // SET Total Marks, Marks, User ID, Isomo ID
              scoreProviderModel.quizScore.setUserID(usr!.uid);
              scoreProviderModel.quizScore.setIsomoID(widget.isomo.id);

              // CREATE THE QUESTIONS IN QUIZ SCORE - IF THEY DON'T EXIST
              for (var popQuestion in popQuestions) {
                // Check if the question already exists in quizScore
                bool questionExists = scoreProviderModel.quizScore.questions
                    .any((scoreQuestion) =>
                        scoreQuestion.getPopQuestion().id == popQuestion.id);

                // Add the question to quizScore if it doesn't exist
                if (!questionExists) {
                  scoreProviderModel.quizScore.addQuestion(
                    ScoreQuestion(
                      isAnswered: false,
                      isAnswerCorrect: null,
                      popQuestion: popQuestion,
                    ),
                  );
                }
              }

              // CALLBACK FOR FORWARD BUTTON
              void forward() {
                if (qnIndex >=
                    scoreProviderModel.quizScore.questions.length - 1) {
                  const ErrorAlert(
                    errorTitle: 'Ikibazo cyanyuma!',
                    errorMsg: 'Ibibazo byose byasubije!',
                  );
                } else {
                  setState(() {
                    qnIndex = qnIndex + 1;

                    // RESET THE SELECTED OPTION
                    selectedOption = -1;

                    // RESET THE CORRECTNESS OF THE ANSWER
                    isCurrentCorrect = false;
                  });
                }
              }

              // CALLBACK FOR BACKWARD BUTTON
              void backward() {
                if (qnIndex < 1) {
                } else {
                  setState(() {
                    qnIndex = qnIndex - 1;

                    // RESET THE SELECTED OPTION
                    selectedOption = -1;

                    // RESET THE CORRECTNESS OF THE ANSWER
                    isCurrentCorrect = false;
                  });
                }
              }

              // RETURN THE WIDGETS
              return WillPopScope(
                onWillPop: () async {
                  if (!scoreProviderModel.quizScore.isAllAnswered() ||
                      isCurrentCorrect == false) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ErrorAlert(
                          errorTitle: 'Subiza byose',
                          errorMsg: 'Ushaka gusohoka udasubije ibibazo byose?',
                          firstButtonTitle: 'OYA',
                          secondButtonTitle: 'YEGO',
                          firstButtonFunction: () {
                            Navigator.of(context).pop();
                          },
                          secondButtonFunction: () {
                            Navigator.of(context).pop();
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                    return false;
                  }
                  return true;
                },
                child: Scaffold(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),

                  // APP BAR
                  appBar: const PreferredSize(
                    preferredSize: Size.fromHeight(58.0),
                    child: AppBarTegura(),
                  ),
                  // PAGE BODY
                  body: IsuzumeDetails(
                    isomo: widget.isomo,
                    userID: usr.uid,
                    courseProgress: widget.courseProgress,
                    qnIndex: qnIndex,
                    selectedOption: selectedOption,
                    isCurrentCorrect: isCurrentCorrect,
                    setSelectedOption: setSelectedOption,
                    showQn: showQn,
                  ),

                  bottomNavigationBar: popQuestions.isEmpty ||
                          scoreProviderModel.quizScore
                                  .getIsAtleastOneAnswered() ==
                              false
                      ? const SizedBox.shrink()
                      : Container(
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.024),
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 72, 255, 0),
                                offset: Offset(0, -1),
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // IF ALL QUESTIONS ARE NOT ANSWERED, ALERT THE USER TO CONFIRM
                                  if (!scoreProviderModel.quizScore
                                          .isAllAnswered() ||
                                      isCurrentCorrect == false) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ErrorAlert(
                                          errorTitle: 'Subiza byose',
                                          errorMsg:
                                              'Ushaka gusohoka udasubije ibibazo byose?',
                                          firstButtonTitle: 'OYA',
                                          secondButtonTitle: 'YEGO',
                                          firstButtonFunction: () {
                                            Navigator.of(context).pop();
                                          },
                                          secondButtonFunction: () {
                                            Navigator.of(context).pop();
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    );
                                    return;
                                  }

                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ErrorAlert(
                                          errorTitle: 'Isuzumabumenyi',
                                          errorMsg:
                                              'Wasoje kwisuzuma!',
                                          firstButtonTitle: 'Inyuma',
                                          firstButtonFunction: () {
                                                    Navigator.of(context).pop();
                                                    Navigator.pop(context);
                                          },
                                        );
                                      });
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Soza kwisuzuma',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03),
                                ),
                              ),
                              // 2. INYUMA BUTTON
                              Row(
                                children: [
                                  DirectionButtonIsuzume(
                                    buttonText: 'inyuma',
                                    direction: 'inyuma',
                                    opacity: 1,
                                    backward: backward,
                                    lastQn: popQuestions.length - 1,
                                    currQnID: qnIndex,
                                    isDisabled: qnIndex < 1,
                                  ),

                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.04),

                                  // 3. KOMEZA BUTTON
                                  DirectionButtonIsuzume(
                                    buttonText: 'komeza',
                                    direction: 'komeza',
                                    opacity: 1,
                                    forward: forward,
                                    lastQn: popQuestions.length - 1,
                                    currQnID: qnIndex,
                                    isDisabled:
                                        qnIndex >= popQuestions.length - 1 ||
                                            isCurrentCorrect == false,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void showQn(int index) {
    setState(() {
      qnIndex = index;
      selectedOption = -1;
      isCurrentCorrect = false;
    });
  }

// SET THE SELECTED OPTION AND THE CORRECTNESS OF THE ANSWER
  void setSelectedOption(Map<String, dynamic>? option) {
    if (option == null) {
      setState(() {
        selectedOption = -1;
        isCurrentCorrect = false;
      });
      return;
    }
    setState(() {
      selectedOption = option['id'];
      isCurrentCorrect = option['isCorrect'];
    });
  }
}
