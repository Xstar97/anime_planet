
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class StatusModel{
  StatusModel(this.status, this.color);
  String status;
  Color color;
}


class StatusBloc{
 static var remove = StatusModel('remove', Colors.black);
 static var watched = StatusModel('watched', Colors.blueAccent);
 static var watching = StatusModel('Watching', Colors.green);
 static var wantToWatch = StatusModel('Want to watch', Colors.yellowAccent);
 static var stalled = StatusModel('Stalled', Colors.deepOrange);
 static var dropped = StatusModel('dropped', Colors.red);
 static var wontWatch = StatusModel('wont watch', Colors.deepPurple);
 var list = <StatusModel>[
    remove,
    watched,
    watching,
    wantToWatch,
    stalled,
    dropped,
    wontWatch
  ];
  StatusModel model = StatusModel('remove', Colors.black);

  BehaviorSubject<StatusModel> _subjectStatus;

  StatusBloc({this.model}){
    _subjectStatus = new BehaviorSubject<StatusModel>.seeded(this.model); //initializes the subject with element already
  }

  ValueStream<StatusModel> get statusObservable => _subjectStatus.stream;

  void setStatus(StatusModel model){
    print('${model.status}');
    _subjectStatus.sink.add(model);
  }

  void dispose(){
    _subjectStatus.close();
  }
}