// WIDGET FOR HOLDING THE APPBAR
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tegura/models/user.dart';

class AppBarTegura extends StatelessWidget {
  const AppBarTegura({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // GET PROVIDER USER
    final usr = Provider.of<UserModel?>(context);

    return AppBar(
      backgroundColor: const Color(0xFF5B8BDF),
      // BOTTOM BORDER OF THE APP BAR
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(18.0),
        child: Container(
          color: const Color(0xFFFFBD59),
          height: 8.0,
        ),
      ),
      title: Row(
        children: <Widget>[
          // ARRAY OF WIDGETS - ROW
          SvgPicture.asset(
            'assets/images/car.svg',
            height: 45.0,
          ),
          const SizedBox(width: 10.0), // ADD 10.0 PIXELS OF SPACE
          const Text('Tegura.rw', // TEXT WIDGET
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w900,
                  fontSize: 24.0)),
        ],
      ),

      // USER PROFILE ICON BUTTON - RIGHT SIDE OF THE APP BAR
      // CHECK IF USER IS LOGGED IN OR NOT BEFORE
      actions: <Widget>[
        // IF USER IS LOGGED IN
        if (usr != null)
          IconButton(
            // USE CUSTOM ICON - SVG
            icon: SvgPicture.asset(
              'assets/images/avatar.svg',
              height: 45.0,
            ),
            onPressed: () {
              // DO: VIEW PROFILE, LOGOUT, ETC.
            },
          ),
      ],
    );
  }
}
