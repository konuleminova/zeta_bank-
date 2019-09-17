import 'package:flutter/material.dart';
import 'package:zeta_bank/item/bank_account_item.dart';
import 'package:zeta_bank/item/bill_item.dart';
import 'package:zeta_bank/model/my_bills.dart';
import 'package:zeta_bank/service/networks.dart';
import 'package:zeta_bank/utility/shared_pref_util.dart';

class MyBillsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyBillsState();
  }
}

class MyBillsState extends State<MyBillsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("My Bills"),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.grey[300],
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: TextStyle(color: Colors.black87))),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.view_day),
                title: Text(
                  "Accounts",
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), title: Text("History")),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text("Profile"))
          ],
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey[300]],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: FutureBuilder(
              future: Networks.getMyBills(context),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  MyBills myBills = snapshot.data;
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: BillItemWidget(item: myBills.bills[index]),
                        onTap: () {
                          Networks.markAsViewed(
                              myBills.bills[index].id, context);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(myBills.bills[index].category),
                                  content: Container(
                                    height: 60,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(myBills.bills[index].status,style: TextStyle(color: Colors.red),),
                                        Text(myBills.bills[index].description),
                                        Text(myBills.bills[index].debtAmount.toString()+" AZN"),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Container(
                                      child: FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('OK')),
                                    )
                                  ],
                                );
                              });
                        },
                      );
                    },
                    itemCount: myBills.bills.length,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }
}
