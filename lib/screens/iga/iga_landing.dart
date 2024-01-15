import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tegura/main.dart';
import 'package:tegura/models/isomo.dart';
import 'package:tegura/screens/ibiciro/reba_ibiciro_button.dart';
import 'package:tegura/utilities/app_bar.dart';
import 'package:tegura/screens/iga/iga_data.dart';
import 'package:tegura/utilities/no_internet.dart';

class IgaLanding extends StatefulWidget {
  const IgaLanding({super.key});

  @override
  State<IgaLanding> createState() => _IgaLandingState();
}

class _IgaLandingState extends State<IgaLanding> {
  @override
  Widget build(BuildContext context) {
    final conn = Provider.of<ConnectionStatus>(context);

    bool everDisconnected = false;

    if (conn.isOnline == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              textAlign: TextAlign.center,
              'Nta internet mufite!.',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 255, 8, 0),
            duration: Duration(seconds: 3),
          ),
        );
      });
      everDisconnected = true;
    }

    if (conn.isOnline == true && everDisconnected == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Internet yagarutse!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 0, 255, 85),
            duration: Duration(seconds: 3),
          ),
        );
      });
    }

    return MultiProvider(
      providers: [
        StreamProvider<List<IsomoModel?>?>.value(
          value: null,
          initialData: null,

          catchError: (context, error) {
            return [];
          },
        ),
      ],
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 71, 103, 158),
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(58.0),
            child: AppBarTegura(),
          ),
          body:
              conn.isOnline == false
                  ? const NoInternet()
                  : ListView(
                      children: igaList.asMap().entries.map((entry) {
                        final bool isFirst = entry.key == 0;
                        final bool isLast = entry.key == igaList.length - 1;
                        final double height = isFirst
                            ? MediaQuery.of(context).size.height * 0.06
                            : MediaQuery.of(context).size.height * 0.025;
                        final Map<String, dynamic> item = entry.value;

                        return Column(
                          children: <Widget>[
                            SizedBox(height: height),
                            Container(
                              width: MediaQuery.of(context).size.width * .9,
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.012,
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.025,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00CCE5),
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  width: 2.0,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 54, 54, 54),
                                    offset: Offset(1, 3),
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              item['screen']));
                                },
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.025,
                                    ),
                                    SvgPicture.asset(
                                      item['icon'],
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.025,
                                    ),
                                    Text(item['text'],
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.045,
                                          color: const Color(0xFF000000),
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            if (isLast)
                              Column(children: <Widget>[
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                Container(
                                  color: const Color(0xFF000000),
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                              ])
                          ],
                        );
                      }).toList(),
                    ),
          bottomNavigationBar: const RebaIbiciro()),
    );
  }
}
