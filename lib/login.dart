import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:zeta_bank/model/login_response.dart';
import 'package:zeta_bank/service/networks.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  TextEditingController _controllerUsername, _controllerPass;
  FocusNode userFocus, passFocus;
  bool _validateUsername = false;
  bool _validatePassword = false;
  double opacity;
  String _homeScreenText = "Waiting for token...";
  String _messageText = "Waiting for message...";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    opacity = 0.5;
    _controllerUsername = TextEditingController();
    _controllerPass = TextEditingController();
    userFocus = new FocusNode();
    passFocus = new FocusNode();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onMessage: $message");
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: ListTile(
                    title: Text(message['notification']['title']),
                    subtitle: Text(message['notification']['body']),
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Close')),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Confirm',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ));
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
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = token;
      });
      print(_homeScreenText);
    });
  }

  @override
  void dispose() {
    _controllerUsername.dispose();
    _controllerPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.grey[300]],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: Text(
              "Special PaymentSystem",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            width: 120,
          ),
          Container(
              margin: EdgeInsets.all(16.00),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Login:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(
                          child: TextField(
                            onSubmitted: (value) {
                              //_controllerUsername.text=value;
                              userFocus.unfocus();
                              FocusScope.of(context).requestFocus(passFocus);
                            },
                            onChanged: (value) {
                              passFocus.unfocus();
                              setState(() {
                                _controllerUsername.text.isEmpty
                                    ? _validateUsername = false
                                    : _validateUsername = true;
                                if (_validateUsername && _validatePassword) {
                                  opacity = 1;
                                } else {
                                  opacity = 0.5;
                                }
                              });
                            },
                            controller: _controllerUsername,
                            textInputAction: TextInputAction.next,
                            focusNode: userFocus,
                            decoration:
                                InputDecoration.collapsed(hintText: null),
                          ),
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey)),
                        ),
                        flex: 3,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.00,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "PIN:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(
                          child: TextField(
                              onSubmitted: (value) {
                                //_controllerPass.text=value;
                                passFocus.unfocus();
                                userFocus.unfocus();
                                if (_validateUsername && _validatePassword) {
                                  Networks.login(
                                      _controllerUsername.text,
                                      _controllerPass.text,
                                      _homeScreenText,
                                      context);
                                }
                              },
                              onChanged: (value) {
                                userFocus.unfocus();
                                setState(() {
                                  _controllerPass.text.isEmpty
                                      ? _validatePassword = false
                                      : _validatePassword = true;
                                  if (_validateUsername && _validatePassword) {
                                    opacity = 1;
                                  } else {
                                    opacity = 0.5;
                                  }
                                });
                              },
                              autofocus: false,
                              obscureText: true,
                              controller: _controllerPass,
                              textInputAction: TextInputAction.done,
                              focusNode: passFocus,
                              decoration:
                                  InputDecoration.collapsed(hintText: null)),
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey)),
                        ),
                        flex: 3,
                      )
                    ],
                  )
                ],
              )),
          Opacity(
            opacity: opacity,
            child: Container(
              child: RaisedButton(
                disabledColor: Colors.lightBlue,
                color: Colors.lightBlue,
                onPressed: () {
                  if (_validateUsername && _validatePassword) {
                    Networks.login(_controllerUsername.text,
                        _controllerPass.text, _homeScreenText, context);
                  }
                },
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
