import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:weather_app/localization/locales.dart';
import 'package:weather_app/welcome_screen/welcome_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   
   await Hive.initFlutter();
   await Hive.openBox('notesBox');
  runApp( const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final FlutterLocalization localization = FlutterLocalization.instance;

@override
  void initState() {
    configureLocalization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true
      ),
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
        home: const WelcomeScreen(),
    );
  }

void configureLocalization(){
        localization.init(mapLocales: LOCALES, initLanguageCode: "en");
        localization.onTranslatedLanguage = onTranslatedLanguage;
  }

  void onTranslatedLanguage(Locale? locale){
    setState(() {
      
    });
  }
}

