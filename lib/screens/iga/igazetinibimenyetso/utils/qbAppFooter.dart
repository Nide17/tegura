import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QBAppFooter extends StatelessWidget {
  const QBAppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.0091,
          ),
          margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.024,
          ),
          decoration: const BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
        Text(
          'For more info, Contact Us:',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.048,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.all(
            MediaQuery.of(context).size.height * 0.024,
          ),
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    _icons[index]['icon'],
                    height: MediaQuery.of(context).size.height * 0.028,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),
                  Text(
                    _icons[index]['link'],
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.042,
                      color: _icons[index]['link'].contains('@') ||
                              _icons[index]['link'].contains('www')
                          ? const Color.fromARGB(255, 0, 102, 185)
                          : Colors.black,

                      fontWeight: FontWeight.w900,
                      decoration: _icons[index]['link'].contains('@') ||
                              _icons[index]['link'].contains('www')
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: _icons.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '~We are Quiz Blog - Learning & Quizzing~',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.036,
              color: const Color(0xFF00A651),
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

// List of icons and their links or texts
List<Map<String, dynamic>> _icons = [
  {
    'icon': 'assets/images/whatsapp.svg',
    'link': '0780579067',
  },
  {
    'icon': 'assets/images/web.svg',
    'link': 'www.quizblog.rw',
  },
  {
    'icon': 'assets/images/email.svg',
    'link': 'quizblog.rw@gmail.com',
  },
  {
    'icon': 'assets/images/twitter.svg',
    'link': 'QuizblogRw',
  },
  {
    'icon': 'assets/images/instagram.svg',
    'link': 'quizblogrw',
  },
  {
    'icon': 'assets/images/linkedin.svg',
    'link': 'quiz-blog',
  },
  {
    'icon': 'assets/images/facebook.svg',
    'link': 'QuizblogRw',
  },
];
