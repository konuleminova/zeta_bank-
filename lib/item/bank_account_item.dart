import 'package:flutter/material.dart';
import 'package:zeta_bank/model/bank_account_item.dart';
import 'package:zeta_bank/service/networks.dart';
import 'package:zeta_bank/utility/dialog.dart';

class BankAccountItemWidget extends StatefulWidget {
  BankAccountItem item;

  BankAccountItemWidget({this.item});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BankAccountItemState();
  }
}

class BankAccountItemState extends State<BankAccountItemWidget> {
  BankAccountItem item;

  @override
  Widget build(BuildContext context) {
    item = widget.item;
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4)),
      margin: EdgeInsets.only(left: 12, right: 12, top: 8),
      padding: EdgeInsets.all(10.0),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(item.iban),
            flex: 3,
          ),
          Expanded(
            child: item.status == "ACTIVE"
                ? SizedBox(
                    width: 20,
                  )
                : RaisedButton(
                    onPressed: () {
                      // showMaterialDialog(context);
                      Networks.activateAccount(item.id, context);
                    },
                    color: Colors.lightBlue,
                    disabledColor: Colors.lightBlue,
                    child: Text(
                      "Active",
                      style: TextStyle(color: Colors.white),
                    )),
            flex: 1,
          )
        ],
      ),
    );
  }
}
