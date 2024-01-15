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
import 'package:tegura/screens/iga/utils/tegura_alert.dart';
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
    setState(() => loading = true);

    if (FirebaseAuth.instance.currentUser != null) {
      PaymentModel? pymt = await PaymentService()
          .getUserLatestPytData(FirebaseAuth.instance.currentUser!.uid);

      setState(() {
        payment = pymt;
        loading = false;
      });

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
        : MultiProvider(
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
            child: Consumer<List<IsuzumaScoreModel>?>(
                builder: (context, amaUserScores, _) {
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
                                  : showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return TeguraAlert(
                                            errorTitle: 'Ntibyagenze neza',
                                            errorMsg: payment == null
                                                ? 'Nturishyura'
                                                : payment.isApproved == false
                                                    ? 'Ifatabuguzi ryawe ntiriremezwa'
                                                    : 'Ongera ugerageze!',
                                                    alertType: 'error');
                                      });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00CCE5),
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.03),
                            border: Border.all(
                              width: MediaQuery.of(context).size.width * 0.006,
                              color: const Color(0xFFFFBD59),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.01,
                                ),
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
                              Container(
                                color: const Color(0xFFFFBD59),
                                height:
                                    MediaQuery.of(context).size.height * 0.009,
                              ),
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
                          : Amanota(userScore: userScore)
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                ],
              );
            }),
          );
  }
}
