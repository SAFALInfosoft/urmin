import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final lableController = TextEditingController();

  final amountController = TextEditingController();

  void _submitDate() {
    final enterlable = type;
    final enteramount = amountController.text;
    if (enterlable.isEmpty || enteramount.isEmpty) {
      return;
    }
    widget.addTx(enterlable, enteramount);
    Navigator.of(context).pop();
  }

  DropdownButton<String> getType() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in ExpanseType) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      items: dropDownItems,
      value: type,
      onChanged: (value) {
        setState(() {
          type = value!;
        });
      },
    );
  }

  String type = 'Ticket';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 60.0,
            width: MediaQuery.of(context).size.width,
            child: FormField(
              builder: (FormFieldState<dynamic> field) {
                return InputDecorator(
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Expanse Type',
                      labelStyle: kTextStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  child: DropdownButtonHideUnderline(child: getType()),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Expanse Amount',
                labelStyle: kTextStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            keyboardType: TextInputType.number,
            controller: amountController,
            onSubmitted: (_) => _submitDate(),
          ),
           SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 60.0,
            child: AppTextField(
              textFieldType: TextFieldType.NAME,
              readOnly: true,
              enabled: true,
              decoration: InputDecoration(
                labelText: 'Choose File',
                hintText: 'No File Chosen',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: Image.asset('images/choosefile.png'),
                border:  OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 15),
          GestureDetector(
            onTap: () => {_submitDate()},
            child: Container(
              child: Text(
                'Add Expanse',
                style: TextStyle(letterSpacing: 1.0, fontSize: 18),
              ),
            ),
          ),
          // FlatButton(onPressed: () => _submitDate,
          //  child: Text("Add Transaction")),
        ],
      ),
    );
  }
}
