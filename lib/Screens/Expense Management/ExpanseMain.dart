import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maan_hrm/Screens/Expense%20Management/tansaction.dart';
import 'package:maan_hrm/Screens/Expense%20Management/transaction_list.dart';

import 'new_transaction.dart';


class TransectionMainDemo extends StatefulWidget {
   TransectionMainDemo({Key? key}) : super(key: key);

  @override
  State<TransectionMainDemo> createState() => _TransectionMainDemoState();
}

class _TransectionMainDemoState extends State<TransectionMainDemo> {
  final List<Transaction> _userTransaction = [];
  void _addTransaction(var lable, var amount) {
    var addTx = Transaction(
      lable: lable,
      amount: amount,
      Date: DateTime.now(),
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransaction.add(addTx);
    });
  }

  void _addNewTransactionModel(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }
  void _deleteTransaction(var id){
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),

        ],
        title:  Text(
          'Daily Expense',
        ),
        backgroundColor: Colors.deepPurple,

    ),
      drawer:
      Drawer(),
      body:
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child:
                Text(
                  "EXPANSE DATA",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                elevation: 5,
                color: Colors.purpleAccent,
              ),
            ),
            TransactionList(_userTransaction , _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: Icon(Icons.add),
          onPressed: () => _addNewTransactionModel(context)),
    );
  }
}
