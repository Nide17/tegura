import 'package:flutter/material.dart';
import 'package:tegura/models/course_progress.dart';
import 'package:tegura/models/isomo.dart';
import 'package:tegura/utilities/user_progress.dart';

class AmasomoProgress extends StatefulWidget {
  final String userId;
  final List<CourseProgressModel?>? progressesToShow;
  final List<IsomoModel?>? amasomo;
  final List<CourseProgressModel?>? progresses;

  const AmasomoProgress(
      {super.key,
      required this.userId,
      this.progressesToShow,
      this.amasomo,
      this.progresses});

  @override
  State<AmasomoProgress> createState() => _AmasomoProgressState();
}

class _AmasomoProgressState extends State<AmasomoProgress> {
  @override
  Widget build(BuildContext context) {
    List<CourseProgressModel?>? notFinishedProgresses;

    if (widget.progresses != null) {
      notFinishedProgresses = widget.progresses
          ?.where(
              (progress) => progress?.currentIngingo != progress?.totalIngingos)
          .toList();
    }

    if (widget.amasomo != null) {
      for (var isomo in widget.amasomo!) {
        if (widget.progresses != null) {
          if (!widget.progresses!
              .any((progress) => progress?.courseId == isomo!.id)) {
            notFinishedProgresses?.add(CourseProgressModel(
              courseId: isomo!.id,
              currentIngingo: 0,
              totalIngingos: 1,
              id: '',
              userId: widget.userId,
            ));
          }
        }
      }
    }

    if (widget.progressesToShow != null) {
      widget.progressesToShow?.sort(
          (a, b) => b!.progressPercentage.compareTo(a!.progressPercentage));
    }

    if (widget.progressesToShow != null) {
      widget.progressesToShow
          ?.sort((a, b) => a!.courseId.compareTo(b!.courseId));
    }

    if (widget.progressesToShow != null) {
      widget.progressesToShow
          ?.sort((a, b) => b!.totalIngingos.compareTo(a!.totalIngingos));
    }

    return Column(
      children: widget.progressesToShow?.map((progress) {
            final isomo = widget.amasomo
                ?.firstWhere((isomo) => isomo!.id == progress!.courseId,
                    orElse: () => IsomoModel(
                          title: '',
                          description: '',
                          conclusion: '',
                          id: 0,
                          introText: '',
                        ));

            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 10, 78, 197),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      width: MediaQuery.of(context).size.width * 0.005,
                      color: const Color(0xFFFFBD59),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.width * 0.04,
                      horizontal: MediaQuery.of(context).size.width * 0.01,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width *
                                  0.02,
                              vertical: MediaQuery.of(context).size.height *
                                  0.005),
                          child: Text(
                            isomo?.title ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              color: Colors.black,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                        Container(
                          color: const Color(0xFFFFBD59),
                          height: MediaQuery.of(context).size.height * 0.009,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            isomo?.description ?? '',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.034,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        UserProgress(
                          isomo: isomo ??
                              IsomoModel(
                                  conclusion: '',
                                  id: 0,
                                  description: '',
                                  introText: '',
                                  title: ''),
                          userId: widget.userId,
                          totalIngingos: progress!.totalIngingos,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.032,
                ),
              ],
            );
          }).toList() ??
          [],
    );
  }
}
