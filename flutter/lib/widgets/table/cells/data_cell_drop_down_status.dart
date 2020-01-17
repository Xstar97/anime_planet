
import 'package:anime_planet/logic/StatusBloc.dart';
import 'package:flutter/material.dart';

class DataCellDropDownStatus extends StatefulWidget {
  DataCellDropDownStatus({Key key, this.bloc}) : super(key: key);
  StatusBloc bloc;

  @override
  _DataCellDropDownStatusState createState() => _DataCellDropDownStatusState();
}

class _DataCellDropDownStatusState extends State<DataCellDropDownStatus> {

  @override
  void initState() {
    super.initState();

    //onSelected(widget.bloc.statusObservable.value);
  }

  void onSelected(StatusModel model){
    /*setState(() {
      for(StatusModel lis in widget.bloc.list){
        lis.showIcon = false;
      }
      model.showIcon = true;
    });*/
    widget.bloc.setStatus(model);
  }


  @override
  Widget build(BuildContext context) {

    return new StreamBuilder(stream: widget.bloc.statusObservable, builder: (context, AsyncSnapshot<StatusModel> snapshot){

      return new DropdownButton<StatusModel>(
          value: widget.bloc.statusObservable.value,
          onChanged: (StatusModel newValue) {
            onSelected(newValue);
          },
          items: widget.bloc.list.map((StatusModel user){return new DropdownMenuItem<StatusModel>(
            value: user,
            child: Row(children: <Widget>[
              Visibility(
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.all(5.0),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,// You can use like this way or like the below line
                    //borderRadius: new BorderRadius.circular(30.0),
                    color: user.color,
                  ),
                ),
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: true,
              ),
              Text(user.status)
            ]),
          );
          }
          ).toList());
    });
  }
}