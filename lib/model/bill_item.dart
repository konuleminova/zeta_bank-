class BillItem {
  int id;
  String category;
  String description;
  double debtAmount;
  int viewed;
  String status;

  BillItem({this.id,
    this.category,
    this.description,
    this.debtAmount,
    this.viewed,
    this.status});

  factory BillItem.fromJson(Map<String, dynamic> json) {
    return BillItem(id: json['id'],
        category: json['category'],
        description: json['description'],
        debtAmount: json['debtAmount'],
        viewed: json['viewed'],
        status: json['status']);
  }
}
