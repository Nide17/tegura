import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tegura/models/ingingo.dart';
import 'package:tegura/models/user.dart';
import 'package:tegura/screens/iga/content_details.dart';
import 'package:tegura/utilities/appbar.dart';
import 'package:tegura/utilities/direction_button.dart';
import 'package:tegura/services/ingingodb.dart';

class IgaContent extends StatefulWidget {
// INSTANCE VARIABLES
  final String isomoId;
  final String isomoTitle;
  final String isomoDescription;

  const IgaContent(
      {super.key,
      required this.isomoId,
      required this.isomoTitle,
      required this.isomoDescription});

  @override
  State<IgaContent> createState() => _IgaContentState();
}

class _IgaContentState extends State<IgaContent> {
  final int pageNumber = 1;

  final int? limit = 1;

  // BUILD METHOD TO BUILD THE UI OF THE APP
  @override
  Widget build(BuildContext context) {
    // GET THE USER
    final usr = Provider.of<UserModel?>(context);
    int skip = 0;

    // CALLBACK TO CHANGE THE SKIP STATE
    void changeSkip(int val) {
      setState(() {
        skip += val;
      });
    }

    // RETURN THE WIDGETS
    return MultiProvider(
      providers: [
        // STREAM PROVIDER FOR TOTAL INGINGOS FOR A PARTICULAR COURSE OR ISOMO
        StreamProvider<List<IngingoModel>?>.value(
          // WHAT TO GIVE TO THE CHILDREN WIDGETS
          value: skip >= 0
              ? IngingoService()
                  .getIngingosByIsomoIdPaginated(widget.isomoId, 2, skip)
              : const Stream<List<IngingoModel>?>.empty(),
          initialData: null,

          // CATCH ERRORS
          catchError: (context, error) {
            // PRINT THE ERROR
            if (kDebugMode) {
              print("Error in logged in for ingingos: $error");
              print(
                  "The err: ${IngingoService().getIngingosByIsomoIdPaginated(widget.isomoId, 2, skip)}");
            }
            // RETURN NULL
            return null;
          },
        ),
      ],
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),

          // APP BAR
          appBar: PreferredSize(
            preferredSize: MediaQuery.of(context).size * 0.07,
            child: const AppBarTegura(),
          ),

          // PAGE BODY
          body: ContentDetails(
            isomoDescription: widget.isomoDescription,
            isomoTitle: widget.isomoTitle,
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // 2. INYUMA BUTTON
                DirectionButton(
                  buttonText: 'inyuma',
                  direction: 'backward',
                  opacity: 1,
                  skip: skip,
                  // SET STATE TO CHANGE THE SKIP BY SUBTRACTING 2 ON EACH BACKWARD BUTTON PRESS
                  changeSkip: changeSkip,
                  isomoId: widget.isomoId,
                  isomoTitle: widget.isomoTitle,
                  isomoDescription: widget.isomoDescription!,
                ),

                CircularPercentIndicator(
                  radius: MediaQuery.of(context).size.width * 0.05,
                  lineWidth: MediaQuery.of(context).size.width * 0.01,
                  animation: true,
                  percent: 0.2,
                  center: Text(
                    '${(0.5 * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.butt,
                  progressColor: const Color(0xFF9D14DD),
                  backgroundColor: const Color(0xFFBCCCBF),
                ),

                // 3. KOMEZA BUTTON
                DirectionButton(
                  buttonText: 'komeza',
                  direction: 'forward',
                  opacity: 1,
                  skip: skip,
                  // SET STATE TO CHANGE THE SKIP BY ADDING 2 ON EACH FORWARD BUTTON PRESS
                  changeSkip: changeSkip,
                  isomoId: widget.isomoId,
                  isomoTitle: widget.isomoTitle,
                  isomoDescription: widget.isomoDescription,
                ),
              ],
            ),
          ) // 2. INYUMA BUTTON
          ),
    );
  }
}
