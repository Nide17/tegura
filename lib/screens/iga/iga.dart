import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tegura/screens/ibiciro/reba_ibiciro_button.dart';
import 'package:tegura/screens/my_appbar.dart'; // APP BAR
import 'package:tegura/screens/iga/iga_data.dart'; // DATA FOR THE IGA PAGE

class Iga extends StatefulWidget {
  const Iga({Key? key}) : super(key: key);

  @override
  _IgaState createState() => _IgaState();
}

class _IgaState extends State<Iga> {
  // BUILD METHOD TO BUILD THE UI OF THE APP
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF5B8BDF),

        // APP BAR
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(58.0),
          child: AppBarTegura(),
        ),

        // PAGE BODY
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            // CHILDREN OF THE COLUMN WIDGET
            children: igaList.asMap().entries.map((entry) {
              final bool isFirst = entry.key == 0;
              final bool isLast = entry.key == igaList.length - 1;
              final double height = isFirst ? 36.0 : 16.0;
              final Map<String, dynamic> item = entry.value;

              return Column(
                children: <Widget>[
                  // 1. ADD 10.0 PIXELS OF SPACE
                  SizedBox(height: height),

                  // 2. BUTTON CONTAINER WIDGET
                  Container(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 48.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00CCE5),
                      borderRadius: BorderRadius.circular(30.0),
                    ),

                    // GestureDetector WIDGET, ROW WITH ICON AND TEXT - BUTTON
                    child: GestureDetector(
                      // NAVIGATE TO THE IBICIRO PAGE
                      onTap: () {
                        Navigator.push(context, item['widget']);
                      },
                      child: Row(
                        children: <Widget>[
                          // ADD 10.0 PIXELS OF SPACE
                          const SizedBox(width: 24.0),
                          // SVG ICON
                          SvgPicture.asset(
                            item['icon'],
                            height: 22.0,
                          ),
                          // ADD 10.0 PIXELS OF SPACE
                          const SizedBox(width: 8.0),
                          // TEXT WIDGET
                          Text(item['text'],
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                  ),
                  // 3. ADD BOTTOM BORDER IF LAST ITEM
                  if (isLast)
                    Column(children: <Widget>[
                      // ADD 10.0 PIXELS OF SPACE
                      const SizedBox(height: 16.0),
                      // BOTTOM BORDER
                      Container(
                        color: const Color(0xFF000000),
                        height: 8.0,
                      ),

                      // ADD 10.0 PIXELS OF SPACE
                      const SizedBox(height: 48.0),
                    ])
                ],
              );
            }).toList(),
          ),
        ),
        bottomNavigationBar: const RebaIbiciro());
  }
}
