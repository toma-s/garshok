import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../keys/keys.dart';

void initDB() {
  Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  print('initialised db');
}
