import 'package:Prd/model/trasaction.dart';
import 'package:Prd/widget/chart_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import './chart_bar.dart';
class Chart extends StatelessWidget {
  final List<Transactions> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String,Object>> get groupedTransactionValues{
    return List.generate(7, (index){
      final weekday=DateTime.now().subtract(Duration(days: index),);
      double totalsum=0;
      for(var i=0;i<recentTransactions.length;i++)
      {
        if(recentTransactions[i].date.day==weekday.day && recentTransactions[i].date.month==weekday.month
        && recentTransactions[i].date.year==weekday.year)
        {
          totalsum+=recentTransactions[i].amount;
        }
      }
      return {'day':DateFormat.E().format(weekday).substring(0,1),
      'amount':totalsum};
    }).reversed.toList();
  }
  double get maxSpending{
    return groupedTransactionValues.fold(0.0,(sum,item){
      return sum+item['amount'];
      },);
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 6,

      child:Container(
        padding: EdgeInsets.all(10),
        child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactionValues.map((data)
      {
        return Flexible(
        fit:FlexFit.tight,
        child: ChartBar(data['day'],data['amount'],
        maxSpending==0.0?0.0:(data['amount'] as double)/maxSpending),);

      }).toList(),
      ),),
      );
  }
}