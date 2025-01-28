import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyCloudData extends StatelessWidget {
  final List dailyData;


  const DailyCloudData( this.dailyData );


  @override
  Widget build(BuildContext context) {
    const TextStyle commonTextStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0);
    int sunsetInInt = (dailyData[0].sunset.toInt());
    int sunsetTime = sunsetInInt * 1000;

    return Text("Sunset: ${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(sunsetTime).toLocal())}", style: commonTextStyle);
  }
}
