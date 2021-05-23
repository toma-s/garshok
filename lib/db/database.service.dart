import 'package:garshok/models/fertiliser.model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../keys/keys.dart';

void loadInitFertilisers() async {
  var fertiliser = ParseObject('Fertiliser');
  fertiliser.set('name', 'stick-30');
  fertiliser.set('durationDays', '30');
  await fertiliser.save();

  fertiliser = ParseObject('Fertiliser');
  fertiliser.set('name', 'stick-60');
  fertiliser.set('durationDays', '60');
  await fertiliser.save();

  fertiliser = ParseObject('Fertiliser')
  ..set('name', 'liquid')
  ..set('durationDays', '14');
  await fertiliser.save();
}

void deleteAllFertilisers() async {
  QueryBuilder<ParseObject> queryTodo = QueryBuilder<ParseObject>(ParseObject('Fertiliser'));
  final ParseResponse apiResponse = await queryTodo.query();

  if (!apiResponse.success || apiResponse.results == null) {
    return;
  }

  var results = apiResponse.results;
  results.forEach((element) async {
    var el = ParseObject('Fertiliser')..objectId = element.objectId;
    await el.delete();
  });
}

void createFertiliser(Fertiliser fertiliserData) async {
  var fertiliser = ParseObject('Fertiliser');
  fertiliser.set('name', fertiliserData.name);
  fertiliser.set('durationDays', fertiliserData.durationDays);
  await fertiliser.save();
}

void loadInitData() async {
  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  // clear DB
  var todo = ParseObject('Fertiliser');
  await todo.delete();

  // constant data
  // eixs1PC1DT
  // var fertiliser = ParseObject('Fertiliser');
  // fertiliser.set('name', 'stick-30');
  // fertiliser.set('durationDays', '30');
  // await fertiliser.save();
  //
  // 2QFtRp6xW6
  // fertiliser = ParseObject('Fertiliser');
  // fertiliser.set('name', 'stick-60');
  // fertiliser.set('durationDays', '60');
  // await fertiliser.save();
  //
  // es8GAs1Ufe
  // fertiliser = ParseObject('Fertiliser');
  // fertiliser.set('name', 'liquid');
  // fertiliser.set('durationDays', '14');
  // await fertiliser.save();

  // var profile = ParseObject('Plants');
  // profile.set('name', 'Aglaonema bidadari');
  // profile.set('description', 'big');
  // profile.set('startDate', DateTime.utc(2020, 04, 20));
  // profile.set('repottedDate', DateTime.utc(2021, 03, 07));
  // profile.set('fertilisedDate', DateTime.utc(2021, 05, 20));
  // profile.set('fertiliserType', 'eixs1PC1DT');
  // await profile.save();

  print('done');
}