
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  String titleInput;

  String amountInput;
  DateTime selecteddate;


  void submit()
  {
    final title=titleInput;
    final amount=double.parse(amountInput);
    if (title.isEmpty || amount<=0||selecteddate==null)
    {
      return ;
    }
    widget.addTx(
      titleInput,
      double.parse(amountInput),
      selecteddate,
      );
      Navigator.of(context).pop();
  }
  void _presentDatePicker()
  {
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020),
     lastDate: DateTime.now()).then((pickedDate){
       if(pickedDate==null)
       {
         return ;
       }
       setState(() {
         selecteddate=pickedDate;
       });
       

       

     });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child:Column(children: <Widget>[
                TextField(decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value){
                  titleInput=value;
                },
                onSubmitted:(_)=>submit(),
                ),
                TextField(decoration: InputDecoration(labelText: 'Amount'),
                onChanged: (val){
                  amountInput=val;
                },
                keyboardType: TextInputType.number,
                onSubmitted:(_)=>submit(),),
                Container(
                  height:70,
                child:Row(
                  children: <Widget>[
                    Expanded(
                    child: Text(selecteddate==null?'No Date chossen':
                    'Picked Date: ${DateFormat.yMd().format(selecteddate)}',),),
                    FlatButton(onPressed: _presentDatePicker, child: Text("Choose date",
                    style: TextStyle(fontWeight: FontWeight.bold),),
                    textColor: Theme.of(context).primaryColor,)
                  ],
                ),
              ),
                RaisedButton(onPressed: (){
                  widget.addTx(
                    titleInput,
                    double.parse(amountInput)
                    );
                }, child: Text("Add Details"),textColor:Theme.of(context).primaryColor,)
              ],)
            ),
          );
  }
}