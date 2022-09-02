import 'package:http/http.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class WorldTime{

  String location;
  String time="Initial value";
  String flag;
  String url;

  bool isDayTime=false; // true or false if it's day or night


  WorldTime({required this.location, required this.flag, required this.url});


  Future<void> getTime() async {

    try{
      // make request
      Response response= await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data= jsonDecode(response.body);
      // print(data);

      //get properties from data
      String datetime=data['datetime'];
      String offset=data['utc_offset'].substring(1,3);

      //print(datetime);
      print(offset);

      //create dateTime object
      DateTime now= DateTime.parse(datetime);
      now=now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false ;

      // set the time property
      time=DateFormat.jm().format(now);

    }catch(e){
      print('Caught error $e');
      time='could not get time data';
    }

  }

}


