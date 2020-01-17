import 'package:flutter/material.dart';

class DataCellTitle extends StatefulWidget {
  DataCellTitle({Key key, this.title}) : super(key: key);
  String title;
  @override
  _DataCellTitleState createState() => _DataCellTitleState();
}

class _DataCellTitleState extends State<DataCellTitle> {

  @override
  Widget build(BuildContext context) {

     return Text(widget.title);
  }
}