import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', useConstantCase: true, obfuscate: true)
final class Env {
  
  @EnviedField(varName: 'WEATHER')
  static final String WEATHER = _Env.WEATHER;
}
