import 'package:flutter_localization/flutter_localization.dart';

const List<MapLocale> LOCALES = [
MapLocale("en", LocaleData.EN),
MapLocale("uk", LocaleData.UK)
];

mixin LocaleData{
  static const String title = 'title';
  static const String search = 'search';
  static const String confirmDialog = 'confirmDialog';
  static const String yes = 'yes';
  static const String no = 'no';
  static const String tit = 'tit';
  static const String body = 'body';

 static const String temp = 'temp';
  static const String wind = 'wind';
   static const String humidity = 'humidity';
    static const String maxTemp = 'Max temp';
     static const String minTemp = 'minTemp';
      static const String windSpeed = 'windSpeed';
       static const String refresh = 'Refresh Data';

       static const String gtNotes = 'gtNotes';
       static const String gtWeather = 'gtWeather';




  static const Map<String, dynamic> EN = {
    title: 'Notes',
    search: 'Search notes',
    confirmDialog: 'Are you sure want to delete?', 
    yes: 'Yes',
    no: 'No',
    tit: 'Title',
    body: 'The content of your notes',
    temp: 'Temperature',
    wind: 'Wind',
    humidity: 'Humidity',
    maxTemp: 'Max temp',
    minTemp: 'Min temp',
    windSpeed: 'WindSpeed',
    refresh: 'Refresh Data',
    gtNotes: 'Go to Notes',
    gtWeather: 'Go to Weather'
  };
  static const Map<String, dynamic> UK = {
    title: 'Нотатки',
    search: 'Шукати нотатки' ,
    confirmDialog: 'Ви впевнені що хочете видалити цей запис?',
    yes: 'Так',
    no: 'Ні',
     tit: 'Заголовок',
    body: 'Зміст вашого запису',
    temp: 'Температура',
    wind: 'Вітер',
    humidity: 'Вологість',
    maxTemp: 'Макс темп',
    minTemp: 'Мін темп',
    windSpeed: 'СкорВітру',
    refresh: 'Обновити дані',
    gtNotes: 'Перейти до нотатків',
    gtWeather: 'Перейти до Погоди'
  };
}