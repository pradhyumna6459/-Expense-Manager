import 'package:Prd/widget/new_transaction.dart';
import 'package:flutter/material.dart';
import './widget/transaction_list.dart';
import './widget/new_transaction.dart';
import './model/trasaction.dart';
import './widget/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        errorColor: Colors.red,


      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _startAddNewTransaction(BuildContext ctx)
  {
    showModalBottomSheet(context: ctx, builder: (_)
    {
      return GestureDetector(
      onTap: (){},
      child: NewTransaction(_addNewTranstion),
      behavior: HitTestBehavior.opaque,
      );
    });
  }
  final List <Transactions> userTransaction=[
  //Transactions(id:'t1',title:'Moblie',amount:5000,date:DateTime.now()),
  //Transactions(id:'t2',title:'Nike Jordon',amount:2500,date:DateTime.now()),

  ];
  List<Transactions> get _recentTransaction{
    return userTransaction.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days:7),),);

    }).toList();
  }
  void _addNewTranstion(String txtitle,double txamount,DateTime choosendate)
  {
    final newTx=Transactions(
      title:txtitle,
      amount:txamount,
      date: choosendate,
      id:DateTime.now().toString(),

    );
    setState(() {
      userTransaction.add(newTx);
      
    });
  }
  void _deleteTranstiction(String id)
  {
    setState(() {
      userTransaction.removeWhere((tx) {
        return tx.id==id;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense App'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed:()=>_startAddNewTransaction(context)),
        ],
      ),
    
      body:SingleChildScrollView(
        child:
      Column(

        children: <Widget>[
          Chart(_recentTransaction),
          TranstionList(userTransaction,_deleteTranstiction)

          
        ],
      ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: FloatingActionButton(child:Icon(Icons.add),onPressed:()=>_startAddNewTransaction(context)),
    );
  }
}
