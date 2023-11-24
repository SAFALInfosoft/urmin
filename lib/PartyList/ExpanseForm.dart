import 'package:flutter/material.dart';

class ExpanseForm extends StatefulWidget {
   ExpanseForm({key});

  @override
  State<ExpanseForm> createState() => _ExpanseFormState();
}

class _ExpanseFormState extends State<ExpanseForm> {
  int _formCount = 0;
  final List<Map<String, dynamic>> _dataArray = [];
  String? _data = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 19),
              const Text('Names of Programming Languages',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      fontSize: 22)),
              const SizedBox(height: 20),
              ...List.generate(_formCount, (index) => form(index)),
              buttonRow(),
              const SizedBox(height: 10),
              Visibility(visible: _dataArray.isNotEmpty, child: Text(_data!)),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget form(int key) => Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: TextFormField(
      decoration: InputDecoration(hintText: 'Form ${key + 1}'),
      onChanged: (val) => _onUpdate(key, val),
    ),
  );

  Widget buttonRow() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Visibility(
        visible: _formCount > 0,
        child: IconButton(
            onPressed: () {
              if (_dataArray.isNotEmpty) {
                _dataArray.removeAt(_dataArray.length - 1);
              }
              setState(() {
                _data = _dataArray.toString();
                _formCount--;
              });
            },
            icon: const CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(
                Icons.remove,
              ),
            )),
      ),
      IconButton(
          onPressed: () {
            setState(() => _formCount++);
          },
          icon: const CircleAvatar(
            backgroundColor: Colors.teal,
            child: Icon(
              Icons.add,
            ),
          )),
    ],
  );

  void _onUpdate(int key, String val) {
    void addData() {
      Map<String, dynamic> json = {'id': key, 'value': val};
      _dataArray.add(json);
      setState(() {
        _data = _dataArray.toString();
      });
    }

    if (_dataArray.isEmpty) {
      addData();
    } else {
      for (var map in _dataArray) {
        if (map["id"] == key) {
          _dataArray[key]['value'] = val;
          setState(() {
            _data = _dataArray.toString();
          });
          break;
        }
      }

      for (var map in _dataArray) {
        for (var map in _dataArray) {
          if (map["id"] == key) {
            return;
          }
        }
        addData();
      }
    }
  }
}