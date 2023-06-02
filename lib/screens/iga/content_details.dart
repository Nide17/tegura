import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tegura/models/ingingo.dart';
import 'package:tegura/screens/iga/gradient_title.dart';
import 'package:tegura/screens/utilities/direction_button.dart';

class ContentDetails extends StatelessWidget {
// INSTANCE VARIABLES
  final String? isomoDescription;
  final String isomoTitle;
  final int pageNumber = 1;
  final int? limit = 1;
  final int? skip = 1;


  // CONSTRUCTOR
  const ContentDetails({super.key, required this.isomoDescription, required this.isomoTitle});

  // BUILD METHOD TO BUILD THE UI OF THE APP
  @override
  Widget build(BuildContext context) {
    // RETURN THE WIDGETS
    return ListView(children: <Widget>[
              // 1. GRADIENT TITLE
      Container(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
        decoration: const BoxDecoration(
          color: Color(0xFF5B8BDF),
        ),
        child: GradientTitle(title: isomoTitle, icon: '', marginTop: 8.0),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          // 2. INYUMA BUTTON
          DirectionButton(buttonText: 'inyuma', direction: 'backward', opacity: 1, portion: '1-2'),
          // 3. KOMEZA BUTTON
          DirectionButton(buttonText: 'komeza', direction: 'forward', opacity: 1, portion: '1-2'),

        ],
      ),
      // 3. INGINGO LIST
      Column(
        children: <Widget>[
          // 3.1. INGINGO LIST
          Container(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9),
            ),
            child: Consumer<List<IngingoModel>?>(
              builder: (context, ingingoList, child) {
                return const Text("data");
                // if (ingingoList == null) {
                //   return const Center(
                //     child: CircularProgressIndicator(),
                //   );
                // } else {
                //   return ListView.builder(
                //     shrinkWrap: true,
                //     physics: const NeverScrollableScrollPhysics(),
                //     itemCount: ingingoList.length,
                //     itemBuilder: (context, index) {
                //       return Container(
                //         padding: const EdgeInsets.fromLTRB(
                //             0.0, 0.0, 0.0, 8.0),
                //         decoration: const BoxDecoration(
                //           color: Color(0xFFD9D9D9),
                //         ),
                //         child: ListTile(
                //           title: Text(
                //             ingingoList[index].ingingoTitle,
                //             style: const TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 18.0,
                //             ),
                //           ),
                //           subtitle: Text(
                //             ingingoList[index].ingingoDescription,
                //             style: const TextStyle(
                //               fontSize: 16.0,
                //             ),
                //           ),
                //         ),
                //       );
                //     },
                //   );
                // }
              },
            ),
          ),
        ],
      ),      
    ]);
  }
}
