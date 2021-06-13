import 'package:flutter/material.dart';

import 'db/fertiliser.service.dart';
import 'models/fertiliser.model.dart';

class FertiliserRoute extends StatelessWidget {
  static const String _title = 'Fertilisers';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: fertilisersWidget(),
    );
  }

  Widget fertilisersWidget() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null) {
          // todo message
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          // todo message
          return Container();
        }
        return DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Duration days')),
            ],
            rows: List<DataRow>.generate(snapshot.data.length, (int index) {
              Fertiliser fertiliser = snapshot.data[index];
              return DataRow(cells: <DataCell>[
                DataCell(Text(fertiliser.name)),
                DataCell(Text(fertiliser.durationDays)),
              ]);
            }));
      },
      future: readFertilisers(),
      initialData: [],
    );
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
