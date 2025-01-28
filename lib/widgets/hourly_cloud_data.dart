import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourlyCloudData extends StatelessWidget {
  final List hourlyData;
  final int index;

  String capitalizeFirstLetter(String word) {
    if (word.isEmpty) {
      return word; // Return empty string if input is empty
    }
    return word[0].toUpperCase() + word.substring(1);
  }

  const HourlyCloudData(this.hourlyData, this.index);

  @override
  Widget build(BuildContext context) {
    String capitalizedDescription = capitalizeFirstLetter(hourlyData[index].weather[0].description);
    const TextStyle commonTextStyle = TextStyle(color: Colors.black);
    const TextStyle titleTextStyle =
        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);
    int currentTimeInInt = (hourlyData[index].dt.toInt());
    int hourlyTime = currentTimeInInt * 1000;

    return Column(
      children: [
        Text(
          capitalizedDescription,
          style: titleTextStyle,
        ),
        Text(
          "Time: ${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(hourlyTime.toInt()).toLocal())}",
          style: commonTextStyle,
        ),
        Text(
          "Cloudiness: ${hourlyData[index].clouds}%",
          style: commonTextStyle,
        ),
        Text(
          "Visibility: ${(hourlyData[index].visibility) / 1000}m",
          style: commonTextStyle,
        ),
        Text(
          "Temperature: ${hourlyData[index].temp.toInt()}°C",
          style: commonTextStyle,
        ),
        Text(
          "Temperature feels like: ${hourlyData[index].feelsLike.toInt()}°C",
          style: commonTextStyle,
        ),
        Text(
          "Probability of precipitation: ${hourlyData[index].pop.toInt()}/10",
          style: commonTextStyle,
        ),
        Image.network(
          'http://openweathermap.org/img/w/${hourlyData[index].weather[0].icon}.png',
          fit: BoxFit.contain,
          width: 70.0, // Set the desired width
          height: 70.0,
        ),
      ],
    );
  }
}
