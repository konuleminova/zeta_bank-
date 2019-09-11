import 'package:zeta_bank/model/bill_item.dart';

class MyBills {
  List<BillItem> bills;

  MyBills({this.bills});

  factory MyBills.fromJson(List<dynamic> json) {
    List<BillItem> bills = new List();
    bills = json.map((i) => BillItem.fromJson(i)).toList();
    return MyBills(bills: bills);
  }
}
