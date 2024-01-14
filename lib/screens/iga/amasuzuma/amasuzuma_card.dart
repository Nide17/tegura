import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tegura/firebase_services/isuzuma_score_db.dart';
import 'package:tegura/firebase_services/payment_db.dart';
import 'package:tegura/models/isuzuma.dart';
import 'package:tegura/models/isuzuma_score.dart';
import 'package:tegura/models/payment.dart';
import 'package:tegura/models/user.dart';
import 'package:tegura/screens/auth/iyandikishe.dart';
import 'package:tegura/screens/iga/amasuzuma/amanota.dart';
import 'package:tegura/screens/iga/utils/error_alert.dart';
import 'package:tegura/screens/iga/amasuzuma/isuzuma_overview.dart';
import 'package:tegura/utilities/spinner.dart';

class AmasuzumaCard extends StatefulWidget {
  final IsuzumaModel isuzuma;

  const AmasuzumaCard({super.key, required this.isuzuma});

  @override
  State<AmasuzumaCard> createState() => _AmasuzumaCardState();
}

class _AmasuzumaCardState extends State<AmasuzumaCard> {
  dynamic payment;
  bool loading = false;

  Future<bool> _isPaymentApproved() async {
    // SET THE LOADING STATE TO TRUE
    setState(() => loading = true);

    if (FirebaseAuth.instance.currentUser != null) {
      PaymentModel? pymt = await PaymentService()
          .getUserLatestPytData(FirebaseAuth.instance.currentUser!.uid);

      setState(() {
        payment = pymt;
        loading = false;
      });

      // IF THE USER HAS A PAYMENT PLAN APPROVED
      if (pymt != null && pymt.isApproved == true) {
        return true;
      } else {
        return false;
      }
    } else {
      loading = false;
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _isPaymentApproved();
  }

  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<UserModel?>(context);

    return loading
        ? const Spinner()
        :

        // PROVIDE THE SCORES BY USER
        MultiProvider(
            providers: [
              StreamProvider<List<IsuzumaScoreModel>?>.value(
                value: usr != null
                    ? IsuzumaScoreService().getScoresByTakerID(usr.uid)
                    : null,
                initialData: null,
                catchError: (context, error) {
                  return [];
                },
              ),
            ],

            // CONSUMER TO LISTEN TO THE SCORES BY USER AND ISUZUMA
            child: Consumer<List<IsuzumaScoreModel>?>(
                builder: (context, amaUserScores, _) {
              // GET THE SCORE OF THE USER FOR THE CURRENT ISUZUMA
              IsuzumaScoreModel? userScore;
              if (amaUserScores != null) {
                for (var i = 0; i < amaUserScores.length; i++) {
                  if (amaUserScores[i].isuzumaID == widget.isuzuma.id) {
                    userScore = amaUserScores[i];
                    break;
                  }
                }
              }
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          usr == null
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Iyandikishe(
                                          message:
                                              'Banza wiyandikishe, wishyure ubone aya masuzumabumenyi yose!')))
                              : payment != null && payment.isApproved == true
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => IsuzumaOverview(
                                                isuzuma: widget.isuzuma,
                                              )),
                                    )
                                  :
                                  // SHOW ALERT DIALOG
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ErrorAlert(
                                            errorTitle: 'Ntibyagenze neza',
                                            errorMsg: payment == null
                                                ? 'Nturishyura'
                                                : payment.isApproved == false
                                                    ? 'Ifatabuguzi ryawe ntiriremezwa'
                                                    : 'Ongera ugerageze!');
                                      });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00CCE5),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              width: 2.0,
                              color: const Color(0xFFFFBD59),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // TITLE
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  widget.isuzuma.title.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035,
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                  ),
                                ),
                              ),

                              // BOTTOM BORDER OF THE ABOVE SECTION
                              Container(
                                color: const Color(0xFFFFBD59),
                                height:
                                    MediaQuery.of(context).size.height * 0.009,
                              ),

                              // PNG ICON
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 6.0,
                                ),
                                child: Image.asset(
                                  'assets/images/isuzuma.png',
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      usr == null
                          ? Text(
                              '/${widget.isuzuma.questions.length}',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.08,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : userScore != null
                              ? Amanota(
                                  score: userScore.marks,
                                  maxScore: userScore.totalMarks,
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
            }),
          );
  }
}
