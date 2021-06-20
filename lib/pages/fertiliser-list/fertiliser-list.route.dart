import 'package:flutter/material.dart';
import 'package:garshok/pages/upsert-fertiliser/navigator-arguments/upsert-fertiliser.dart';
import 'package:garshok/pages/upsert-fertiliser/type/type.dart';
import 'package:garshok/pages/upsert-fertiliser/upsert-fertiliser.route.dart';

import '../../../db/fertiliser.service.dart';
import '../../../models/fertiliser.model.dart';

class FertiliserRoute extends StatefulWidget {
  @override
  _FertiliserWidgetState createState() => _FertiliserWidgetState();
}

class _FertiliserWidgetState extends State<FertiliserRoute> {
  static const String _title = 'Fertilisers';
  Future _fertilisersListFuture = Future.value([]);
  bool showSpinner;

  @override
  Future<void> initState() {
    super.initState();
    _fertilisersListFuture = updateList();
    showSpinner = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: fertilisersWidget(),
    );
  }

  void setSpinner(bool show) {
    setState(() {
      showSpinner = show;
    });
  }

  void refreshList() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _fertilisersListFuture = updateList();
      });
    });
  }

  Future updateList() {
    return getAllFertilisers();
  }

  Widget fertilisersWidget() {
    return Center(
        child: Column(
      children: <Widget>[
        showSpinner ? CircularProgressIndicator() : Center(),
        // todo refresh when updated
        FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none &&
                snapshot.hasData == null) {
              showSpinner = false;
              return NoFertiliserAlertMessage();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              showSpinner = false;
              return CircularProgressIndicator();
            }
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data.length > 0) {
              showSpinner = false;

              return DataTable(
                  columns: const <DataColumn>[
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Duration days')),
                    DataColumn(label: Text('Update')),
                    DataColumn(label: Text('Delete')),
                  ],
                  rows:
                      List<DataRow>.generate(snapshot.data.length, (int index) {
                    Fertiliser fertiliser = snapshot.data[index];
                    return DataRow(cells: <DataCell>[
                      DataCell(Text(fertiliser.name)),
                      DataCell(Text(fertiliser.durationDays)),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.create_outlined),
                          tooltip: 'Update fertiliser',
                          onPressed: () {
                            _updateFertiliser(fertiliser.objectId);
                          },
                        ),
                      ),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.delete),
                          tooltip: 'Delete fertiliser',
                          onPressed: () {
                            setSpinner(true);
                            refreshList();
                            deleteFertiliser(fertiliser.objectId);
                          },
                        ),
                      ),
                    ]);
                  }));
            }
            return NoFertiliserAlertMessage();
          },
          future: _fertilisersListFuture,
        ),
      ],
    ));
  }

  void _updateFertiliser(objectId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => UpsertFertiliserRoute(
              UpsertFertiliserArguments(UpsertType.Update, objectId))),
    );
  }
}

class NoFertiliserAlertMessage extends StatelessWidget {
  const NoFertiliserAlertMessage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Fertilises list'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('No fertilisers were found'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Go back'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ]);
  }
}

List<DataRow> getTableData(data) {
  const List<DataRow> list = [];
  data.forEach((element) {
    list.add(DataRow(
      cells: <DataCell>[
        DataCell(Text(element.name)),
        DataCell(Text(element.durationDays)),
      ],
    ));
  });
  return list;
}
