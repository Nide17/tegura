// DATA FOR THE LIST VIEW
import 'package:flutter/material.dart';
import 'package:tegura/screens/iga/hagati/hagati.dart';

final List<Map<String, dynamic>> igaList = [
  {
    'icon': 'assets/images/video_icon.svg',
    'text': 'Amasomo ugezemo hagati',
    'route': 'hagati',
    'widget': MaterialPageRoute(builder: (context) => const Hagati()),
  },
  {
    'icon': 'assets/images/course_list.svg',
    'text': 'Amasomo wasoje kwiga',
    'route': 'wasoje',
    'widget': 'Wasoje()'
  },
  {
    'icon': 'assets/images/igazeti.svg',
    'text': 'Igazeti n\'ibimenyetso',
    'route': 'igazeti',
    'widget': 'Igazeti()'
  },
  {
    'icon': 'assets/images/amasuzumabumenyi.svg',
    'text': 'Amasuzumabumenyi yose',
    'route': 'amasuzumabumenyi',
    'widget': 'Amasuzumabumenyi()'
  },
  {
    'icon': 'assets/images/ibibazo_bibaza.svg',
    'text': 'Ibibazo abanyeshuri bibaza',
    'route': 'bibaza',
    'widget': 'Bibaza()'
  },
  {
    'icon': 'assets/images/baza_mwarimu.svg',
    'text': 'Baza mwarimu',
    'route': 'baza',
    'widget': 'Baza()'
  },
];
