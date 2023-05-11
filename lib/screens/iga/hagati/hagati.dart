import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tegura/models/user.dart';
import 'package:tegura/screens/ibiciro/reba_ibiciro_button.dart';
import 'package:tegura/screens/iga/gradient_title.dart';
import 'package:tegura/screens/iga/hagati/hagati_logged_in.dart';
import 'package:tegura/screens/iga/hagati/hagati_not_logged_in.dart';
import 'package:tegura/screens/iga/hagati/progress_circle.dart';
import 'package:tegura/screens/my_appbar.dart';

class Hagati extends StatefulWidget {
  const Hagati({Key? key}) : super(key: key);

  @override
  _HagatiState createState() => _HagatiState();
}

class _HagatiState extends State<Hagati> {
  
  // BUILD METHOD TO BUILD THE UI OF THE APP
  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<UserModel?>(context);
    // const usr = null;
    // print(usr?.uid);

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
          const GradientTitle(),

          // 2. ADD 10.0 PIXELS OF SPACE
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),

          // 3. ELLIPSE WITH SPACES IN THE STROKE
          ProgressCircle(
            percent: usr != null ? 0.5 : 0.0,
            progress: usr != null
                ? 'Ugeze kukigero cya 50% wiga!'
                : 'Nturatangira kwiga!',
            usr: usr,
          ),

          if (usr != null)
            const HagatiLoggedIn()
          else
            const HagatiNotLoggedIn(),
        ]),

        // BOTTOM NAVIGATION BAR
        bottomNavigationBar: const RebaIbiciro());
  }
}
