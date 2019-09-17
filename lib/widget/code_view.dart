import 'package:flutter/material.dart';
import 'dart:core';

class CodeViewCustom extends StatefulWidget {
  CodeViewCustom({this.code, this.length = 6, this.codeTextStyle, this.obscurePin});

  final String code;
  final int length;
  final bool obscurePin;
  final TextStyle codeTextStyle;
  Color color=Colors.yellow;

  CodeViewState createState() => CodeViewState();
}

class CodeViewState extends State<CodeViewCustom> {
  String getCodeAt(index) {
    if (widget.code == null || widget.code.length < index)
      return "  ";
    else if (widget.obscurePin) {
      return ".";
    } else {
      return widget.code.substring(index - 1, index);
    }
  }
  Color getColorAt(index) {
    if (widget.code == null || widget.code.length < index)
      return Colors.white;
    else if (widget.obscurePin) {
      return Colors.blueAccent;
    } else {
      return Colors.green;
    }
  }

  _getCodeViews() {
    List<Widget> widgets = [];
    for (var i = 0; i < widget.length; i++) {
      widgets.add(
          ClipOval(child: Container(
            width: 15,
            height: 15,
            margin: EdgeInsets.all(5.0),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(30.0),
              border: new Border.all(
                width: 1.0,
                color: Colors.blueAccent,
              ),
            ),
            child: new Container( decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(30.0),
              color: getColorAt(i+1),
            ),),
          ),)

      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _getCodeViews(),
    );
  }
}
