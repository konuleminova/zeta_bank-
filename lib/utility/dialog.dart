import 'package:flutter/material.dart';

void showMaterialDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Push authentication'),
          content: Text(""),
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
              child: Text('Confirm',style: TextStyle(color: Colors.white),),
            )
          ],
        );
      });
}
