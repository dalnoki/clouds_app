class Daily {
  int sunset;

  Daily({
   required this.sunset });

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      sunset: json['sunset'],
    );
  }
}

class Hourly {
  // TODO change dynamic
  dynamic dt; // Timestamp (Unix time, UTC time zone)
  dynamic temp;
  dynamic feelsLike; // Changed from dynamic to double for type safety
  int clouds; //Cloudiness, %
  dynamic visibility; // Average visibility in metres, max 10 km
  List<Weather>? weather;
  dynamic pop; // Probability of precipitation, between 0 and 1

  Hourly({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.clouds,
    required this.visibility,
    this.weather,
    required this.pop,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return Hourly(
      dt: json['dt'],
      temp: json['temp'],
      feelsLike: json['feels_like'],
      clouds: json['clouds'],
      visibility: json['visibility'],
      weather: (json['weather'] as List<dynamic>?)
          ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      pop: (json['pop']).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'temp': temp,
      'feels_like': feelsLike,
      'clouds': clouds,
      'visibility': visibility,
      'weather': weather?.map((e) => e.toJson()).toList(),
      'pop': pop,
    };
  }
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'] as int,
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }
}

class CityLocation {
  double lat;
  double lon;

  CityLocation({
    required this.lat, required this.lon });

  factory CityLocation.fromJson(Map<String, dynamic> json) {
    return CityLocation(
        lat: json['lat'],
        lon: json['lon']
    );
  }
}


