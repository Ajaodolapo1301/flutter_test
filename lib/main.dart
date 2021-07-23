import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:morphosis_flutter_demo/locator.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/firebase_manager.dart';
import 'package:morphosis_flutter_demo/services/dialogServices.dart';
import 'package:morphosis_flutter_demo/services/navigationServices.dart';
import 'package:morphosis_flutter_demo/ui/screens/index.dart';
import 'package:morphosis_flutter_demo/ui/widgets/dialogManager.dart';
import 'package:morphosis_flutter_demo/ui/widgets/error_widget.dart';
import 'package:morphosis_flutter_demo/viewModel/baseModel.dart';
import 'package:morphosis_flutter_demo/viewModel/createAndEdit.dart';
import 'package:morphosis_flutter_demo/viewModel/newsViewModel.dart';
import 'package:morphosis_flutter_demo/viewModel/taskViewModel.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'non_ui/modal/news.dart';
const title = 'Morphosis Demo';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();


  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(NewsModelAdapter());

  await Hive.openBox("news");
  setupLocator();
  runZonedGuarded(() {
    runApp(
        MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => BaseModel()),
              ChangeNotifierProvider(create: (_) => TaskViewModel()),
              ChangeNotifierProvider(create: (_) => CreateTaskViewModel()),
              ChangeNotifierProvider(create: (_) => NewsState()),
            ],
            child: FirebaseApp(

            ))
    );
  }, (error, stackTrace) {
    print('runZonedGuarded: Caught error in my root zone.');
  });
}

class FirebaseApp extends StatefulWidget {
  @override
  _FirebaseAppState createState() => _FirebaseAppState();
}

class _FirebaseAppState extends State<FirebaseApp> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  Future<void> _initializeFlutterFire() async {
    // Wait for Firebase to initialize
    await FirebaseManager.shared.initialise();

    debugPrint("firebase initialized");

    // Pass all uncaught errors to Crashlytics.
    Function originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      // Forward to original handler.
      originalOnError(errorDetails);
    };
  }

  // Define an async function to initialize FlutterFire
  void initialize() async {
    if (_error) {
      setState(() {
        _error = false;
      });
    }

    try {
      await _initializeFlutterFire();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error || !_initialized) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        home: Scaffold(
          body: _error
              ? ErrorMessage(
                  message: "Problem initialising the app",
                  buttonTitle: "RETRY",
                  onTap: initialize,
                )
              : Container(),
        ),
      );
    }
    return App();
  }
}

class App extends StatelessWidget {
  ///TODO: Try to implement themeing and use it throughout the app
  /// For reference : https://flutter.dev/docs/cookbook/design/themes
  ///

  ///TODO: Restructure folders pr rearrange folders based on your need.
  ///TODO: Implement state management of your choice.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),

      navigatorKey: locator<NavigationService>().navigationKey,
      home: IndexPage(),
    );
  }
}
