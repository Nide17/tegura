import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:tegura/models/course_progress.dart';
import 'package:tegura/models/isomo.dart';
import 'package:tegura/models/profile.dart';
import 'package:tegura/models/user.dart';

import 'package:tegura/screens/auth/injira.dart';
import 'package:tegura/screens/auth/iyandikishe.dart';
import 'package:tegura/screens/auth/ur_student.dart';
import 'package:tegura/screens/auth/wibagiwe.dart';
import 'package:tegura/screens/ibiciro/ibiciro.dart';
import 'package:tegura/screens/iga/iga_landing.dart';

import 'package:tegura/firebase_services/isomo_progress.dart';
import 'package:tegura/firebase_services/auth.dart';
import 'package:tegura/firebase_services/profiledb.dart';
import 'package:tegura/firebase_services/isomodb.dart';
import 'package:tegura/utilities/loading_lightning.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// ENTRY POINT OF THE APP - MAIN FUNCTION
Future main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider<ConnectionStatus>(
      create: (_) => ConnectionStatus(), child: const TeguraApp()));
}

// TO NOTIFY ALL WIDGETS OF THE INTERNET CONNECTION STATUS
class ConnectionStatus extends ChangeNotifier {
  bool _isOnline = false;

  bool get isOnline => _isOnline;

  set isOnline(bool value) {
    if (_isOnline != value) {
      _isOnline = value;
      notifyListeners();
    }
  }
}

// MAIN APP WIDGET - STATELESS SINCE IT DOESN'T CHANGE
class TeguraApp extends StatefulWidget {
  const TeguraApp({super.key});
  @override
  State<TeguraApp> createState() => _TeguraAppState();
}

class _TeguraAppState extends State<TeguraApp> {
  // CHECK INTERNET CONNECTION
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  late ConnectionStatus _connectionStatus;

  @override
  void initState() {
    super.initState();
    _connectionStatus = ConnectionStatus();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((event) {
      _checkConnectivity();
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    bool isOnline = false;
    try {
      final ConnectivityResult connectivityResult =
          await _connectivity.checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        isOnline = true;
      }
    } catch (e) {
      isOnline = false;
    }

    _connectionStatus.isOnline = isOnline;
  }

  // BUILD METHOD
  @override
  Widget build(BuildContext context) {
    // RETURN THE APP
    return MultiProvider(
      providers: [
        // PROVIDE INTERNET CONNECTION STATUS
        ChangeNotifierProvider<ConnectionStatus>(
          create: (context) => _connectionStatus,
        ),
        // PROVIDE FIREBASE FIRESTORE INSTANCE - DB REFERENCE TO PROFILES COLLECTION
        StreamProvider<ProfileModel?>.value(
          // WHAT TO GIVE TO THE CHILDREN WIDGETS
          value: FirebaseAuth.instance.currentUser != null
              ? ProfileService()
                  .getCurrentProfile(FirebaseAuth.instance.currentUser!.uid)
              : null,

          initialData: null,

          catchError: (context, error) {
            return null;
          },
        ),

        // PROVIDE FIREBASE AUTH INSTANCE
        StreamProvider<UserModel?>.value(
          // WHAT TO GIVE TO THE CHILDREN WIDGETS
          value: AuthService().getUser,
          initialData: null,

          catchError: (context, error) {
            return null;
          },
        ),
        // PROVIDE FIREBASE FIRESTORE INSTANCE - DB REFERENCE TO PROFILES COLLECTION
        StreamProvider<List<IsomoModel?>?>.value(
          // WHAT TO GIVE TO THE CHILDREN WIDGETS
          value: IsomoService()
              .getAllAmasomo(FirebaseAuth.instance.currentUser?.uid),
          initialData: null,

          catchError: (context, error) {
            return [];
          },
        ),

        StreamProvider<List<CourseProgressModel?>?>.value(
          // WHAT TO GIVE TO THE CHILDREN WIDGETS
          value: CourseProgressService()
              .getUserProgresses(FirebaseAuth.instance.currentUser?.uid),
          initialData: null,

          catchError: (context, error) {
            return [];
          },
        ),
      ],
      child: MaterialApp(
        // REMOVE DEBUG BANNER
        debugShowCheckedModeBanner: false,

        // APP THEME
        theme: ThemeData(primarySwatch: Colors.blue),

        // HOME PAGE - LOADING FIRST
        home: const LoadingLightning(
          duration: 4,
        ),

        // ROUTES
        routes: {
          '/iga-landing': (context) => const IgaLanding(),
          '/ibiciro': (context) => const Ibiciro(),
          '/injira': (context) => const Injira(),
          '/iyandikishe': (context) => const Iyandikishe(),
          '/ur-student': (context) => const UrStudent(),
          '/wibagiwe': (context) => const Wibagiwe(),
        },
      ),
    );
  }
}
