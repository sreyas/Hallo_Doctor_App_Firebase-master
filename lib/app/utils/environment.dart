import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get agoraAppId {
    return dotenv.env['AGORA_APP_ID'] ?? '';
  }
}
