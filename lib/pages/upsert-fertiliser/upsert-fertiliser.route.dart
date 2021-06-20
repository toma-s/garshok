import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garshok/models/fertiliser.model.dart';
import 'package:garshok/pages/upsert-fertiliser/navigator-arguments/upsert-fertiliser.dart';
import 'package:garshok/pages/upsert-fertiliser/type/type.dart';

import '../../db/fertiliser.service.dart';

class UpsertFertiliserRoute extends StatelessWidget {
  final UpsertFertiliserArguments arguments;

  UpsertFertiliserRoute(this.arguments);

  @override
  Widget build(BuildContext context) {
    String _title =
        '${this.arguments.upsertType == UpsertType.Update ? 'Update' : 'Add new'} fertiliser';

    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: MyStatefulWidget(arguments),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  final UpsertFertiliserArguments arguments;

  MyStatefulWidget(this.arguments);

  @override
  State<MyStatefulWidget> createState() =>
      new _StatefulWidgetState(this.arguments);
}

class _StatefulWidgetState extends State<MyStatefulWidget> {
  final UpsertFertiliserArguments arguments;
  TextEditingController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var fertiliser = Fertiliser(null, null, null);

  _StatefulWidgetState(this.arguments);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Fertiliser getInitialData() {
    return Fertiliser(null, null, null);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getFertiliserById(widget.arguments.objectId),
        initialData: getInitialData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            print('state-none');
            // todo
            return Center();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('state-waiting');
            // todo
            return Center();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            print('state-done');
            if (this.arguments.upsertType == UpsertType.Update) {
              fertiliser = snapshot.data;
            }
            // Fertiliser f = snapshot.data == null ? Fertiliser('', '', '') : snapshot.data;
            return Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        onSaved: (String value) {
                          fertiliser.name = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Name',
                        ),
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter fertiliser name';
                          }
                          return null;
                        },
                        initialValue: fertiliser.name,
                      ),
                      TextFormField(
                        onSaved: (String value) {
                          fertiliser.durationDays = value;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          hintText: 'Efficiency duration',
                        ),
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter fertiliser efficiency duration';
                          }
                          return null;
                        },
                        initialValue: fertiliser.durationDays,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // save on update too
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              if (this.arguments.upsertType ==
                                  UpsertType.Create) {
                                createFertiliser(fertiliser);
                              } else {
                                updateFertiliser(fertiliser);
                              }
                            }
                          },
                          child: const Text('Submit'),
                          // todo show message
                        ),
                      ),
                    ]));
          }
          // todo
          return Center();
        });
  }
}
