import 'package:flutter/material.dart';
import 'package:zeta_bank/item/bank_account_item.dart';
import 'package:zeta_bank/model/bank_accounts.dart';
import 'package:zeta_bank/service/networks.dart';
import 'package:zeta_bank/utility/shared_pref_util.dart';

class BankAccountsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BankAccoquntsState();
  }
}

class BankAccoquntsState extends State<BankAccountsPage> {
  String accessToken;
  int userId;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Bank Accounts"),
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
        body: FutureBuilder(
            future: Networks.getBankAccounts(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                BankAccounts accounts = snapshot.data;
                return Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white, Colors.grey[300]],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return BankAccountItemWidget(
                        item: accounts.bankAccounts[index],
                      );
                    },
                    itemCount: accounts.bankAccounts.length,
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  getAsunc() async {}

  @override
  void initState() {
    super.initState();

  }
}
