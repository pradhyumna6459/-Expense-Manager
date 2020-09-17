import "package:flutter/foundation.dart";
class Transactions{
  @required String id;
  @required String title;
  @required double amount;
  @required DateTime date;
  Transactions({this.id,this.title,this.amount,this.date});

}