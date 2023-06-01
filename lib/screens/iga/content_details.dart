import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tegura/models/ingingo.dart';
import 'package:tegura/screens/iga/gradient_title.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: ListView(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 6.1. INJIRA
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/inyuma');
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 8.0),
              ),
              child: Text(
                'Inyuma',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),

            // 6.2. IYANDIKISHE
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/komeza');
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
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                    vertical: MediaQuery.of(context).size.height * 0.016),
              ),
              child: Text(
                'Komeza',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ],
        ),
        // 1. GRADIENT TITLE
        Container(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
          decoration: const BoxDecoration(
            color: Color(0xFF5B8BDF),
          ),
          child: GradientTitle(title: isomoTitle, icon: '', marginTop: 8.0),
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
                  // IF THE INGINGO LIST IS NULL
                  if (ingingoList == null) {
                    // RETURN A CIRCULAR PROGRESS INDICATOR
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // IF THE INGINGO LIST IS NOT NULL
                  else {
                    // RETURN THE LIST OF INGINGOS
                    // return ListView.builder(
                    //   // SHRINK WRAP THE LIST VIEW
                    //   shrinkWrap: true,
                    //   // NUMBER OF ITEMS IN THE LIST
                    //   itemCount: ingingoList.length,
                    //   // ITEM BUILDER
                    //   itemBuilder: (context, index) {
                    //     // RETURN THE INGINGO LIST ITEM
                    //     // return IngingoListItem(
                    //     //   ingingo: ingingoList[index],
                    //     //   isLast: index == ingingoList.length - 1,
                    //     // );
                    //     return const Text("Ingingos");
                    //   },
                    // );
                    return const Text("Ingingos");
                  }
                },
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
