import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:weather_app/constrants/app_colors.dart';
import 'package:weather_app/constrants/app_strings.dart';
import 'package:weather_app/notes/home_notes.dart';
import 'package:weather_app/weather/weather_home.dart';

import '../localization/locales.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
late FlutterLocalization _flutterLocalization;
late String _currentLocale;

@override
void initState(){
super.initState();
_flutterLocalization = FlutterLocalization.instance;
_currentLocale = _flutterLocalization.currentLocale!.languageCode;
print(_currentLocale);
}

  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF676BD0),
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(lang, style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic
              ),),
                DropdownButton(
                  value:  _currentLocale,
                  items: [
                  DropdownMenuItem(
                  value: "en",
                  child: Text(eng),),
                  DropdownMenuItem(
                  value: "uk",
                  child: Text(ukr),),

                  ],   
                  onChanged: (value){
                _setLocale(value);
                    }, ),

              Container(
                height:  250,
                width: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(
                      'assets/images/pngegg.png',
                    ),
                  ),
                ),
              ),
               SizedBox(height: screenHeight / 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotesHome()),
                  );
                },
                child: Text(LocaleData.gtNotes.getString(context), style: TextStyle(
                  color: black,
                  fontSize: 16
                ),),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                ),
              ),
               SizedBox(height: screenHeight / 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WeatherHomePage()),
                  );
                },
                child:  Text(LocaleData.gtWeather.getString(context), style: TextStyle(
                  color: black,
                  fontSize: 16
                ),),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _setLocale(String? value){
  if(value == null) return;
  if(value == "uk"){
    _flutterLocalization.translate("uk"); 
  } else if(value == "en"){
    _flutterLocalization.translate("en");
    } else{
      return;
      }
      setState(() {
        _currentLocale = value;
        });
           }
              }   

