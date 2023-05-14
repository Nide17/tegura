import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tegura/models/user.dart';
import 'package:tegura/screens/ibiciro/reba_ibiciro_button.dart';
import 'package:tegura/screens/iga/bibaza/faq.dart';
import 'package:tegura/screens/iga/gradient_title.dart';
import 'package:tegura/screens/my_appbar.dart';

class Bibaza extends StatefulWidget {
  const Bibaza({Key? key}) : super(key: key);

  @override
  BibazaState createState() => BibazaState();
}

class BibazaState extends State<Bibaza> {
  // STATE
  final List<Map<String, dynamic>> ibibazoBibaza = [
      {
      'question': 'Ese iyi App yagufasha gutsinda?',
      'answer': 'Yego, kuko intego yambere yacu nukukwigisha ukabimenya ndetse tunagutegura gutsindira provisoire.',
      'qIcon': 'assets/images/question.svg',
      'aIcon': 'assets/images/answer.svg',
    },
    {
        'question': 'Habaho ubwoko bungahe bw\'ibyapa?',
        'answer': 'Ubwoko bw\'ibyapa ni butanu (5).\n 1. Ibyapa biburira\n 2. Ibyapa byo gutambuka mbere\n 3. Ibyapa bibuza\n 4. Ibyapa bitegeka\n 5.Ibyapa ndanga cg biyobora',
        'qIcon': 'assets/images/question.svg',
        'aIcon': 'assets/images/answer.svg',
    }
  ];

  // BUILD METHOD TO BUILD THE UI OF THE APP
  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<UserModel?>(context);
    // const usr = null;
    if (kDebugMode) {
      print(usr?.uid);
    }

    return Scaffold(
        backgroundColor: const Color(0xFF5B8BDF),

        // APP BAR
        appBar: PreferredSize(
          preferredSize: MediaQuery.of(context).size * 0.07,
          child: const AppBarTegura(),
        ),

        // PAGE BODY
        body: ListView(children: <Widget>[
          // 1. GRADIENT TITLE
          GradientTitle(
              title: 'Ibibazo abanyeshuri bibaza',
              icon: 'assets/images/ibibazo_bibaza.svg'),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),

          // TEXT WIDGET TO DISPLAY THE TEXT
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0,
                8.0), // Add 16.0 pixels of padding to all sides
            child: Text(
              "Ibi ni ibibazo abanyeshuli bibaza ndetse n'ibyo batubaza cyane.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // 2. BORDER
          Container(
            color: const Color(0xFF000000),
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          // FAQS
          for (var i = 0; i < ibibazoBibaza.length; i++)
            Faq(
                question: ibibazoBibaza[i]['question'],
                answer: ibibazoBibaza[i]['answer'],
                qIcon: ibibazoBibaza[i]['qIcon'],
                aIcon: ibibazoBibaza[i]['aIcon']),
        ]),

        // BOTTOM NAVIGATION BAR
        bottomNavigationBar: const RebaIbiciro());
  }
}
