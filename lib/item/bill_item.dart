import 'package:flutter/material.dart';
import 'package:zeta_bank/model/bill_item.dart';
import 'package:zeta_bank/service/networks.dart';

class BillItemWidget extends StatefulWidget {
  BillItem item;

  BillItemWidget({this.item});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BillItemState();
  }
}

class BillItemState extends State<BillItemWidget> {
  BillItem item;

  @override
  Widget build(BuildContext context) {
    item = widget.item;
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  30.0,
                ),
                border: Border.all(color: Colors.grey),
                color: Colors.white),
            child: Align(
              child: IconButton(
                  icon: item.status == "NEW"
                      ? Icon(
                          Icons.file_download,
                          color: Colors.red,
                          size: 18,
                        )
                      : Icon(
                          Icons.view_list,
                          color: Colors.black87,
                        ),
                  onPressed: null),
            ),
            alignment: Alignment.center,
          ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
              flex: 5,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(item.category),
                    Text(item.description)
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(item.debtAmount.toString() + " AZN"),
                ),
                item.status == "NEW"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              //Networks.markAsViewed(item.id, context);
                                 Networks.payBill(item.id, context);
                              setState(() {
                                item.status = "PAIED";
                              });
                            },
                            child: Text(
                              "Pay",
                              style: TextStyle(color: Colors.lightBlue),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Networks.rejectBill(item.id, context);
                              setState(() {
                                item.status = "REJECTED";
                              });
                            },
                            child: Text(
                              "Reject",
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        ],
                      )
                    : SizedBox(
                        child: Text(
                          item.status,
                          style: TextStyle(fontSize: 12, color: Colors.black26),
                        ),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
