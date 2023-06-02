import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DirectionButton extends StatelessWidget {
  // INSTANCE VARIABLES
  final String buttonText;
  final String direction;
  final double opacity;
  final String portion;

  const DirectionButton({
    Key? key,
    required this.buttonText,
    required this.direction,
    required this.opacity,
    required this.portion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // STATE VARIABLES

    // RETURN THE WIDGETS
    return ElevatedButton(
      onPressed: () {
        if (direction == 'inyuma') {
          // GO BACK TO THE PREVIOUS PAGE
          Navigator.pop(context);
        } else if (direction == 'komeza') {
          // GO TO THE NEXT PAGE
          Navigator.pushNamed(context, '/iga-$portion');
        }
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(
          MediaQuery.of(context).size.width * 0.3,
          MediaQuery.of(context).size.height * 0.0,
        ),
        backgroundColor: const Color(0xFF00CCE5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ICON
          Visibility(
            visible: direction == 'backward' ? true : false,
            child: Opacity(
              opacity: opacity,
              child: SvgPicture.asset(
                direction == 'backward'
                    ? 'assets/images/backward.svg'
                    : 'assets/images/forward.svg',
                width: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
          ),
          Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.035,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),// ICON
          Visibility(
            visible: direction == 'backward' ? false : true,
            child: Opacity(
              opacity: opacity,
              child: SvgPicture.asset(
                direction == 'backward'
                    ? 'assets/images/backward.svg'
                    : 'assets/images/forward.svg',
                width: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
