import 'package:garshok/models/fertiliser.model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

const String _fertiliser = 'Fertiliser';

void createFertiliser(Fertiliser fertiliserData) async {
  var fertiliser = ParseObject(_fertiliser);
  fertiliser.set('name', fertiliserData.name);
  fertiliser.set('durationDays', fertiliserData.durationDays);
  await fertiliser.save();
}

Future readFertilisers() async {
  QueryBuilder<ParseObject> queryTodo =
      QueryBuilder<ParseObject>(ParseObject(_fertiliser));
  final ParseResponse apiResponse = await queryTodo.query();

  if (!apiResponse.success || apiResponse.results == null) {
    return [];
  }

  var output = [];
  apiResponse.results.forEach((element) async {
    var newEl = Fertiliser(
        element['objectId'], element['name'], element['durationDays']);
    output.add(newEl);
  });
  return output;
}

// todo update

void deleteFertiliser(String objectId) async {
  var el = ParseObject(_fertiliser)..objectId = objectId;
  await el.delete();
}

void deleteAllFertilisers() async {
  var results = await readFertilisers();
  results.forEach((element) async {
     deleteFertiliser(element.objectId);
  });
}

void loadInitFertilisers() async {
  var fertiliser = ParseObject(_fertiliser);
  fertiliser.set('name', 'Sticks');
  fertiliser.set('durationDays', '30');
  await fertiliser.save();

  fertiliser = ParseObject(_fertiliser);
  fertiliser.set('name', 'Sticks');
  fertiliser.set('durationDays', '60');
  await fertiliser.save();

  fertiliser = ParseObject(_fertiliser)
    ..set('name', 'Liquid')
    ..set('durationDays', '14');
  await fertiliser.save();
}
