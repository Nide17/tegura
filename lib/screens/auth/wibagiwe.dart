import "package:flutter/material.dart";
import 'package:tegura/utilities/cta_button.dart';
import 'package:tegura/utilities/cta_link.dart';
import 'package:tegura/utilities/default_input.dart';
import 'package:tegura/utilities/description.dart';
import 'package:tegura/screens/iga/utils/gradient_title.dart';
import 'package:tegura/utilities/app_bar.dart';
import 'package:tegura/firebase_services/auth.dart';

class Wibagiwe extends StatefulWidget {
  const Wibagiwe({super.key});

  @override
  State<Wibagiwe> createState() => _WibagiweState();
}

// STATE FOR THE SIGN IN PAGE - STATEFUL
class _WibagiweState extends State<Wibagiwe> {
  // AUTH SERVICE INSTANCE
  final AuthService _authInstance = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String output = '';

  @override
  Widget build(BuildContext context) {
    // IF THE USER IS LOGGED IN, POP THE CURRENT PAGE
    if (_authInstance.currentUser() != null) {
      Navigator.popUntil(context, (route) => route.isFirst);
    }

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 71, 103, 158),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(58.0),
          child: AppBarTegura(),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff14e4ff), Color(0xFF5B8BDF)],
              stops: [0.01, 0.6],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: ListView(
            children: [
              const GradientTitle(
                  title: 'WIBAGIWE IJAMBOBANGA?',
                  icon: 'assets/images/wibagiwe.svg'),

              // 2. DESCRIPTION
              const Description(
                  text:
                      'Andika nimero zawe za telephone wohereze niba wibagiwe ijambobanga ryawe, tugufashe kubona irindi.'),

              // CENTERED IMAGE
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/padlock.png',
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                  ]),

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: 0.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // EMAIL INPUT
                      DefaultInput(
                        placeholder: 'Imeyili',
                        validation: 'Injiza imeyili yawe hano!',
                        // ON CHANGED
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),

                      // CTA BUTTON
                      CtaButton(
                        text: 'Bona ijambobanga rishya',

                        // ON PRESSED
                        onPressed: () async {
                          // VALIDATE FORM
                          if (_formKey.currentState!.validate()) {
                            dynamic resetResult =
                                await _authInstance.resetPassword(email);

                            if (resetResult == null) {
                              setState(() {
                                output =
                                    'Ntibigenze neza, rebako imeyili ariyo!';
                              });
                            } else {
                              setState(() {
                                output =
                                    'Reba amabwiriza kuri email yawe, ubundi winjire!';
                              });

                              // GO TO SIGN IN PAGE
                              if (context.mounted) {
                                Navigator.pushNamed(context, '/injira');
                              }
                            }

                            // SHOW SNACKBAR IF OUTPUT IS NOT EMPTY
                            if (output.isNotEmpty && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(output),
                                  duration: const Duration(seconds: 10),
                                  backgroundColor: const Color(0xFFFFBD59),
                                ),
                              );
                            }
                          } else {
                            print('Not validated');
                          }
                        },
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),

                      // CTA LINK
                      const CtaAuthLink(
                        text1: 'Niba wariyandikishije, ',
                        text2: 'injira',
                        color1: Color.fromARGB(255, 255, 255, 255),
                        color2: Color.fromARGB(255, 0, 27, 116),
                        route: '/injira',
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),

                      // CTA LINK
                      const CtaAuthLink(
                        text1: 'Niba utariyandikisha, ',
                        color1: Color.fromARGB(255, 0, 27, 116),
                        color2: Color.fromARGB(255, 255, 255, 255),
                        text2: 'iyandikishe',
                        route: '/iyandikishe',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
