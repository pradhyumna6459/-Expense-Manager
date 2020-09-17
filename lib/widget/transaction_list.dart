import 'package:flutter/material.dart';
import '../model/trasaction.dart';
import 'package:intl/intl.dart';
class TranstionList extends StatelessWidget {
  final List<Transactions> transaction;
  final Function delettx;
  TranstionList(this.transaction,this.delettx);

  
  @override
  Widget build(BuildContext context) {
    return Container(
            height: 450,
            child:transaction.isEmpty?
            Column(children:<Widget>
            [
              Text('No Transaction added yet',
              style:TextStyle(color: Theme.of(context).primaryColor),),
              SizedBox(
                height:20,
              ),
              Container(
                height: 200,
                child:Image.asset('assets/images/waiting.png',fit:BoxFit.cover),

              )
              


            ],
            )
            :ListView.builder(
              itemBuilder:(ctx,index)
              {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical:8,horizontal:5),
                  child:ListTile(
                    leading:CircleAvatar(radius:30,
                    child:Padding(padding:EdgeInsets.all(7),
                    child:FittedBox(
                    child:Text(transaction[index].amount.toString(),),
                  ),
                    ),

                  ),
                  title: Text(transaction[index].title,),
                  subtitle: Text(DateFormat.yMMMd().format(transaction[index].date),),
                  trailing: IconButton(icon: Icon(Icons.delete), onPressed: ()=>delettx(transaction[index].id),
                  color:Theme.of(context).errorColor),
                  ),
            
              );

              },
              itemCount: transaction.length,
          ),

          );
  }
}