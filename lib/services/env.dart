import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'OPENWEATHER_KEY', obfuscate: true)
  static final String openWeatherApiKey = _Env.openWeatherApiKey;
}