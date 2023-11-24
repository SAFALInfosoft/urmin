import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maan_hrm/Screens/Expense%20Management/tansaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function _deleteTransaction;
  TransactionList(this.transaction , this._deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      child: transaction.isEmpty
      ? Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
       // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(10.0),
              child:/* widget.data != null
                    ? buildOrderDueDataListing(context, widget.data)
                    :*/ Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                        height: 100,
                        width: 100,
                        child: Image(
                            image: AssetImage(
                              'images/empty.png',
                            ))),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Expanse list not found",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "poppins_regular",
                          fontWeight: FontWeight.w900,
                          fontSize: 17.0),
                    )
                  ],
                ),
              )),

        ],
      )
        :ListView.builder(itemBuilder: (ctx,index){
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 18,vertical: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 50,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child:FittedBox(
                    child: Text('\₹ ${ transaction[index].amount}'),
                  ) ,
                ),
              ),
              title: Text(
                transaction[index].lable,
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(transaction[index].Date),
              ),
              trailing: IconButton(icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed:()=> _deleteTransaction(transaction[index].id),),
            ),
          );
          },
        itemCount: transaction.length,
      ),
    );
  }
}
