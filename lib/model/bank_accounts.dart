
import 'package:zeta_bank/model/bank_account_item.dart';

class BankAccounts {
  List<BankAccountItem> bankAccounts;

  BankAccounts({this.bankAccounts});

  factory BankAccounts.fromJson(List<dynamic> json) {
    List<BankAccountItem> bankAccounts = new List();
    bankAccounts = json.map((i) => BankAccountItem.fromJson(i)).toList();
    return BankAccounts(bankAccounts: bankAccounts);
  }
}
