import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tegura/models/course_progress.dart';
import 'package:tegura/models/ingingo.dart';
import 'package:tegura/models/isomo.dart';
import 'package:tegura/models/pop_question.dart';
import 'package:tegura/models/user.dart';
import 'package:tegura/firebase_services/isomo_progress.dart';
import 'package:tegura/firebase_services/pop_question_db.dart';
import 'package:tegura/screens/iga/utils/error_alert.dart';
import 'package:tegura/utilities/app_bar.dart';
import 'package:tegura/utilities/direction_button.dart';
import 'package:tegura/firebase_services/ingingodb.dart';
import 'package:tegura/screens/iga/utils/circle_progress.dart';
import 'package:tegura/screens/iga/utils/content_details.dart';
import 'package:tegura/utilities/loading_widget.dart';

class IgaContent extends StatefulWidget {
  final IsomoModel isomo;
  final dynamic courseProgress;

  const IgaContent(
      {super.key, required this.isomo, required this.courseProgress});

  @override
  State<IgaContent> createState() => _IgaContentState();
}

class _IgaContentState extends State<IgaContent> {
  int _skip = 0;
  int _increment = 0;
  final ScrollController _scrollController =
      ScrollController(); // SCROLL CONTROLLER FOR THE LISTVIEW

  // SET THE SKIP TO THE CURRENT INGINGO IF IT IS NOT NULL
  @override
  void initState() {
    super.initState();
    _skip = widget.courseProgress != null &&
            widget.courseProgress.currentIngingo !=
                widget.courseProgress.totalIngingos
        ? widget.courseProgress.currentIngingo
        : 0;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  // CALLBACK TO CHANGE THE SKIP NUMBER
  void changeSkipNumber(int number) {
    setState(() {
      _skip = _skip + number;
      if (_skip < 0) {
        _skip = 0;
        Navigator.pop(context);
      }

      // SET THE ADD VALUE DEPENDING ON THE DIRECTION
      if (number > 0) {
        _increment = 5;
      } else {
        _increment = -5;
      }
    });
  }

  List<IngingoModel?>? ingingosState = [];

  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<UserModel?>(context);
    const int ingingosPageLimit = 5;

    return MultiProvider(
      providers: [
        // STREAM PROVIDER FOR THE INGINGOS - PROVIDES A STREAM OF INGINGOS TO CHILDREN WIDGETS
        StreamProvider<List<IngingoModel>?>.value(
          value: _skip >= 0
              ? IngingoService().getIngingosByIsomoIdPaginated(
                  widget.isomo.id, ingingosPageLimit, _skip)
              : const Stream<List<IngingoModel>?>.empty(),
          initialData: null,
          catchError: (context, error) {
            return [];
          },
        ),

        // DB REFERENCE TO COURSE PROGRESS COLLECTION
        StreamProvider<CourseProgressModel?>.value(
          value: CourseProgressService().getProgress(usr?.uid, widget.isomo.id),
          initialData: null,
          catchError: (context, error) {
            return null;
          },
        ),

        // STREAM PROVIDER FOR POP QUESTIONS
        StreamProvider<List<PopQuestionModel>?>.value(
          value: PopQuestionService().getPopQuestionsByIngingoIDs(
              widget.isomo.id,
              List<int>.from(
                  ingingosState!.map((ing) => ing!.id + _increment))),
          initialData: null,
          catchError: (context, error) {
            return [];
          },
        ),
      ],

      // CCONSUMERS - USED TO GET THE DATA FROM THE STREAM PROVIDERS
      child: Consumer<CourseProgressModel?>(
        // CONSUMER 1: COURSE PROGRESS
        builder: (context, progress, _) {
          final int totalIngingos = progress != null
              ? progress.totalIngingos
              : widget.courseProgress.totalIngingos;
          final int currentIngingo = progress != null
              ? progress.currentIngingo
              : widget.courseProgress.currentIngingo;
          return Consumer<List<IngingoModel>?>(
            // CONSUMER 2: INGINGOS LIST FOR THE ISOMO
            builder: (context, ingingos, _) {
              ingingosState = ingingos;
              // CONSUMER 3: POP QUESTIONS LIST CURRENT INGINGOS
              return Consumer<List<PopQuestionModel>?>(
                builder: (context, popQuestions, _) {
                  if (kDebugMode) {
                    if (popQuestions != null) {
                      for (var pq in popQuestions) {
                        print("Pop question id here: ${pq.id}");
                      }
                    } else {
                      print("Pop questions ARE null");
                    }
                  }
                  return ingingos == null
                      ? const Scaffold(
                          body: LoadingWidget(),
                        )
                      : ingingos.isEmpty
                          ? Scaffold(
                              body: ErrorAlert(
                                errorTitle: currentIngingo >= totalIngingos
                                    ? 'Isomo rirarangiye!'
                                    : 'Iri somo ntiribonetse!',
                                errorMsg: currentIngingo >= totalIngingos
                                    ? 'Wasoje neza ingingo zose zigize iri somo!'
                                    : 'Iri somo ntangingo zo kwiga rifite!',
                                firstButtonTitle: 'Funga',
                                firstButtonFunction: () {
                                  Navigator.pop(context);
                                },
                              ),
                            )
                          : Scaffold(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              appBar: const PreferredSize(
                                preferredSize: Size.fromHeight(58.0),
                                child: AppBarTegura(),
                              ),
                              body: ContentDetails(
                                  isomo: widget.isomo,
                                  controller: _scrollController),
                              bottomNavigationBar: Container(
                                margin: EdgeInsets.zero,
                                padding: EdgeInsets.zero,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFFFBD59),
                                      offset: Offset(0, -1),
                                      blurRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Center(
                                      child: Text(
                                        widget.isomo.title,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          color: const Color(0xFF9D14DD),
                                          fontWeight: FontWeight.w900,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              const Color(0xFF0500E5),
                                          decorationThickness: 4.0,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        // 2. INYUMA BUTTON
                                        DirectionButton(
                                            buttonText: 'inyuma',
                                            direction: 'inyuma',
                                            opacity: 1,
                                            skip: _skip,
                                            changeSkipNumber: changeSkipNumber,
                                            scrollTop: _scrollToTop,
                                            isomo: widget.isomo),

                                        // 1. PERCENTAGE INDICATOR
                                        const CircleProgress(),

                                        // 3. KOMEZA BUTTON
                                        DirectionButton(
                                            buttonText: 'komeza',
                                            direction: 'komeza',
                                            opacity: 1,
                                            skip: _skip,
                                            changeSkipNumber: changeSkipNumber,
                                            scrollTop: _scrollToTop,
                                            isomo: widget.isomo),
                                      ],
                                    ),
                                  ],
                                ),
                              ));
                },
              );
            },
          );
        },
      ),
    );
  }
}
