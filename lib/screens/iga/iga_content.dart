import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tegura/models/ingingo.dart';
import 'package:tegura/models/user.dart';
import 'package:tegura/screens/iga/content_details.dart';
import 'package:tegura/screens/utilities/appbar.dart';
import 'package:tegura/screens/utilities/direction_button.dart';
import 'package:tegura/screens/utilities/progress_circle.dart';
import 'package:tegura/services/ingingodb.dart';

class IgaContent extends StatelessWidget {
// INSTANCE VARIABLES
  final String isomoId;
  final String isomoTitle;
  final String? isomoDescription;
  final int pageNumber = 1;
  final int? limit = 1;
  final int? skip = 1;

  // CONSTRUCTOR
  const IgaContent(
      {super.key,
      required this.isomoId,
      required this.isomoTitle,
      required this.isomoDescription});

  // BUILD METHOD TO BUILD THE UI OF THE APP
  @override
  Widget build(BuildContext context) {
    // GET THE USER
    final usr = Provider.of<UserModel?>(context);

    // RETURN THE WIDGETS
    return MultiProvider(
      providers: [
        // STREAM PROVIDER FOR TOTAL INGINGOS FOR A PARTICULAR COURSE OR ISOMO
        StreamProvider<List<IngingoModel>?>.value(
          // WHAT TO GIVE TO THE CHILDREN WIDGETS
          value: skip != null
              ? IngingoService()
                  .getIngingosByIsomoIdPaginated(isomoId, 2, skip!)
              : const Stream<List<IngingoModel>?>.empty(),
          initialData: null,

          // CATCH ERRORS
          catchError: (context, error) {
            // PRINT THE ERROR
            if (kDebugMode) {
              print("Error in logged in for ingingos: $error");
              print(
                  "The err: ${IngingoService().getIngingosByIsomoIdPaginated(isomoId, 2, skip!)}");
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
            isomoDescription: isomoDescription,
            isomoTitle: isomoTitle,
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Row(
          
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // 2. INYUMA BUTTON
                const DirectionButton(
                    buttonText: 'inyuma',
                    direction: 'backward',
                    opacity: 1,
                    portion: '1-2'),
          
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
                const DirectionButton(
                    buttonText: 'komeza',
                    direction: 'forward',
                    opacity: 1,
                    portion: '1-2'),
              ],
            ),
          ) // 2. INYUMA BUTTON
          ),
    );
  }
}
