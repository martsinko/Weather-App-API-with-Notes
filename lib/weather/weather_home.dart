import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/constrants/app_colors.dart';
import 'package:weather_app/constrants/app_dimensions.dart';
import '../localization/locales.dart';
import 'models/weather_model.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  Future<Weather> fetchWeather() async {
    final resp = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=52.2297&lon=21.0122&appid=09a9b1352ad43e3d8fbc96f25de6d159"));

    if (resp.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(resp.body);

      return Weather.fromJson(json);
    } else {
      throw Exception('Failed to load data...');
    }
  }

  late Future<Weather> myWeather;

  @override
  void initState() {
    super.initState();
    myWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundNotesColor,
      body: Padding(
        padding:  EdgeInsets.only(
          left: screenWidth / leftPadding,
          right: screenWidth / rightPadding,
          top:  screenHeight / topPadding,
          ),
        child: Stack(
          children: [
            SafeArea(
              top: true,
              child: Column(
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      IconButton(onPressed: (){
                         Navigator.of(context).pop();
                      }, icon:  Icon(Icons.arrow_back, color: white,)),
                      const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    ],
                  ),
                   SizedBox(
                    height: screenHeight / sizedBox2,
                  ),
                  FutureBuilder<Weather>(
                    future: myWeather,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data!.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                             SizedBox(
                              height: screenHeight / sizedBox3,
                            ),
                            Text(
                              snapshot.data!.weather[0]['description'].toString(),
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                                fontSize: 22,
                                letterSpacing: 1.3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                             SizedBox(
                              height: screenHeight /sizedBox1,
                            ),
                            Text(
                              DateFormat('d MMMM, y')
                                  .format(snapshot.data!.date),
                              style: const  TextStyle(
                                color: Colors.white,
                              ),
                            ),
                             SizedBox(height: screenHeight / sizedBox4),
                            Container(
                              height: screenHeight * 0.3,
                              width: screenWidth * 0.6,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/cloud.png',
                                ),
                              )),
                            ),
                             SizedBox(
                              height: screenHeight / sizedBox4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(   
                                  children: [
                                     Text(
                                     LocaleData.temp.getString(context), //'Temperature',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                    ),
                                     SizedBox(
                                      height:  screenHeight * height,
                                    ),
                                    Text(
                                      '${((snapshot.data!.main['temp'] - 32 * 5) / 9).toStringAsFixed(2)} C',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                   Text(
                                      LocaleData.maxTemp.getString(context),//'Max temp',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                    ),
                                     SizedBox(
                                      height: screenHeight * height,
                                    ),
                                    Text(
                                      '${snapshot.data!.maxTemperature}K',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  ],
                                ),
                                 SizedBox(
                                  width: screenWidth * width,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                     Text(
                                      LocaleData.wind.getString(context),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                    ),
                                     SizedBox(
                                      height:  screenHeight * height,
                                    ),
                                    Text(
                                      '${snapshot.data!.wind['speed']} km/h',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                     Text(
                                      LocaleData.minTemp.getString(context),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                    ),
                                     SizedBox(
                                      height:  screenHeight * height,
                                    ),
                                    Text(
                                      '${snapshot.data!.minTemperature}K',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  ],
                                ),
                                 SizedBox(
                                  width: screenWidth * width,
                                ),
                                Column(
                                  children: [
                                     Text(
                                      LocaleData.humidity.getString(context),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                    ),
                                     SizedBox(
                                      height:  screenHeight * height,
                                    ),
                                    Text(
                                      '${snapshot.data!.humidity}%',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                   Text(
                                      LocaleData.windSpeed.getString(context),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                     SizedBox(
                                      height:  screenHeight * height,
                                    ),
                                    Text(
                                      '${snapshot.data!.windSpeed}m/s',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  ],
                                ),
                                
                              ],
                            ),
                             SizedBox(
                              height: screenHeight / 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                 setState(() {
                            myWeather = fetchWeather();
                          });
                              },
                              child: Text(LocaleData.refresh.getString(context), style: TextStyle(color: white, fontSize: 17),),
                              style: ElevatedButton.styleFrom(
                                
                                backgroundColor: black,
                                minimumSize: Size(
                                  MediaQuery.of(context).size.width / 1.1,
                                  50,
                                ),
                              ),
                            )
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return const Text('Failed to load data...');
                      } else {
                        return const CircularProgressIndicator(
                          color: Colors.white,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
