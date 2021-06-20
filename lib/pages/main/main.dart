import 'package:flutter/material.dart';
import 'package:garshok/pages/fertiliser-list/fertiliser-list.route.dart';
import 'package:garshok/pages/upsert-fertiliser/navigator-arguments/upsert-fertiliser.dart';
import 'package:garshok/pages/upsert-fertiliser/type/type.dart';
import 'package:garshok/pages/upsert-fertiliser/upsert-fertiliser.route.dart';
import '../../db/init-database.service.dart';
import '../../db/fertiliser.service.dart';

void main() {
  initDB();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Garshok',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: MyHomePage(title: 'Garshok'),
      // routes: {
      //   UpsertFertiliserRoute.routeName: (context) => UpsertFertiliserRoute(),
      // },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: loadInitFertilisers,
              child: Text('Load init fertilisers'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: deleteAllFertilisers,
              child: Text('Delete all fertilisers'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: _addFertiliser,
              child: Text('Add fertiliser'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: _listFertilisers,
              child: Text('List fertilisers'),
            ),
          ],
        ),
      ),
    );
  }

  void _addFertiliser() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpsertFertiliserRoute(UpsertFertiliserArguments(UpsertType.Create))),
    );
  }

  void _listFertilisers() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FertiliserRoute()),
    );
  }
}