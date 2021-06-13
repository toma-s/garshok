import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garshok/models/fertiliser.model.dart';

import 'db/fertiliser.service.dart';

class NewFertiliserRoute extends StatelessWidget {
  const NewFertiliserRoute({Key key}) : super(key: key);

  static const String _title = 'Add new fertiliser';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _StatefulWidgetState();
}

class _StatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var fertiliser = Fertiliser(null, null, null);

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

  @override
  Widget build(BuildContext context) {
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
          ),
          TextFormField(
            onSaved: (String value) {
              fertiliser.durationDays = value;
            },
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              hintText: 'Efficiency duration',
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'Please enter fertiliser efficiency duration';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  createFertiliser(fertiliser);
                  print(_formKey);
                  print(fertiliser.name);
                  print(fertiliser.durationDays);
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}