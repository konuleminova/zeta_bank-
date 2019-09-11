class BankAccountItem {
  int id;
  String iban;
  String status;

  BankAccountItem({this.id, this.iban, this.status});

  factory BankAccountItem.fromJson(Map<String, dynamic> json) {
    return BankAccountItem(
      id: json['id'],
      iban: json['iban'],
      status: json['status'],
    );
  }
}
