import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tegura/models/ingingo.dart';
import 'package:tegura/screens/iga/gradient_title.dart';
import 'package:tegura/utilities/direction_button.dart';

class ContentDetails extends StatelessWidget {
// INSTANCE VARIABLES
  final String? isomoDescription;
  final String isomoTitle;
  final int pageNumber = 1;
  final int? limit = 1;
  final int? skip = 1;

  // CONSTRUCTOR
  const ContentDetails(
      {super.key, required this.isomoDescription, required this.isomoTitle});

  // BUILD METHOD TO BUILD THE UI OF THE APP
  @override
  Widget build(BuildContext context) {
    // PROVIDERS
    // GET THE INGINGOS
    final ingingos = Provider.of<List<IngingoModel>?>(context);
    // print("Trying to get ingingos...");

    // print("Ingingos: $ingingos");

    // RETURN THE WIDGETS
    return Column(children: <Widget>[
      // 1. GRADIENT TITLE
      Container(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: const BoxDecoration(
          color: Color(0xFF5B8BDF),
        ),
        child: GradientTitle(title: isomoTitle, icon: '', marginTop: 8.0),
      ),
      // 3. INGINGO LIST
      Container(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
          decoration: const BoxDecoration(
            color: Color(0xFFD9D9D9),
          ),
          // 68% OF THE SCREEN HEIGHT
          height: MediaQuery.of(context).size.height * 0.68,
          child: ListView(
            children:
                ingingos?.map((ingingo) => Text('${ingingo.text}')).toList() ??
                    [],
          )),
    ]);
  }
}
