import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zeta_bank/model/my_bills.dart';
import 'package:zeta_bank/service/networks.dart';
import 'package:zeta_bank/utility/shared_pref_util.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  String counter = null;
  String _homeScreenText = "Waiting for token...";
  String _messageText = "Waiting for message...";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var initializationSettings;
  int countViewed = 0;
  int countNonViewed = 0;

  String title;
  String messageBody;
  String mobilePushId;
  String type;

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      print(_homeScreenText);
    });
  }

  @override
  Widget build(BuildContext context) {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _messageText = "Push Messaging message: $message";
        print(_messageText);
        type = message['data']['type'];
        if (message['data']['type'] == "BANK_ACCOUNT_ACTIVATION") {
          flutterLocalNotificationsPlugin.initialize(initializationSettings,
              onSelectNotification: onSelectNotification1);
          setState(() {
            _messageText = "Push Messaging message: $message";
            title = message['notification']['title'];
            mobilePushId = message['data']['mobilePushId'];
          });
        } else {
          flutterLocalNotificationsPlugin.initialize(initializationSettings,
              onSelectNotification: onSelectNotification2);
          setState(() {
            title = message['notification']['title'];
            messageBody = message['notification']['body'];
            counter = message['data']['unPaidBillCount'];
            countNonViewed = int.parse(counter) -
                countViewed -
                countNonViewed +
                countNonViewed;
            print(counter);
          });
        }
        _showNotificationWithDefaultSound();
      },
      onLaunch: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onResume: $message");
      },
    );

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
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
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Expanded(
                    child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(40.0)),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.account_balance,
                                    color: Colors.black87,
                                  ),
                                  onPressed: null),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Bank Accounts",
                              style: TextStyle(fontSize: 13),
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, "/bank_accounts");
                        },
                      ),
                      GestureDetector(
                        child: new Stack(
                          children: <Widget>[
                            Align(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(40.0)),
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.view_list,
                                          color: Colors.black87,
                                        ),
                                        onPressed: null),
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    "My Bills",
                                    style: TextStyle(fontSize: 13),
                                  )
                                ],
                              ),
                              alignment: Alignment.topRight,
                            ),
                            new Positioned(
                              right: 0,
                              top: 0,
                              child: new Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: new BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 20,
                                    minHeight: 20,
                                  ),
                                  child: FutureBuilder(
                                      future: Networks.getMyBills(context),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          countViewed=0;
                                          countNonViewed=0;
                                          MyBills mybills=snapshot.data;
                                          for (int i = 0; i < mybills.bills.length; i++) {
                                            if (mybills.bills[i].status == "NEW") {
                                              if (mybills.bills[i].viewed == 1) {
                                                countViewed++;
                                              } else {
                                                countNonViewed++;
                                              }
                                            }
                                          }
                                          return Text(
                                            countNonViewed.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                            textAlign: TextAlign.center,
                                          );
                                        } else
                                          return CircularProgressIndicator();
                                      })),
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            counter = null;
                          });
                          Navigator.pushNamed(context, "/my_bills");
                        },
                      )
                    ],
                  ),
                ))
              ],
            )));
  }

  Future onSelectNotification2(String payload) async {
    //Networks.markAsViewed(billId, context);
    Navigator.pushNamed(context, "/my_bills");
  }

  Future onSelectNotification1(String payload) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: ListTile(
                title: Text(title),
                subtitle: Text(mobilePushId),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close')),
                RaisedButton(
                  onPressed: () {
                    Networks.confirmAccount(mobilePushId, context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ));
  }

  Future _showNotificationWithDefaultSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      type == "BANK_ACCOUNT_ACTIVATION" ? mobilePushId : messageBody,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }
}
