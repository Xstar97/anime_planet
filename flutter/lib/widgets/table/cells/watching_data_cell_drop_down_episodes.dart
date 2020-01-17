import 'package:anime_planet/logic/CounterBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WatchingDataCellDropDownEpisodes extends StatefulWidget {
  WatchingDataCellDropDownEpisodes({Key key, this.counterBloc}) : super(key: key);
  CountBl counterBloc;

  @override
  _WatchingDataCellDropDownEpisodesState createState() => _WatchingDataCellDropDownEpisodesState();
}

class _WatchingDataCellDropDownEpisodesState extends State<WatchingDataCellDropDownEpisodes> {

  final list = List<int>();
  @override
  void initState() {
    for (var i = 0; i < widget.counterBloc.counterObservable.value.maxCount+1;  i++) {
      list.add(i);
    }
    super.initState();
  }
  void selectEpisodeNumber(int newValue){
    widget.counterBloc.incrementByCustomValue(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(stream: widget.counterBloc.counterObservable, builder: (context, AsyncSnapshot<CounterModel> snapshot){
      return Row(
        children: <Widget>[
          DropdownButton<int>(
            value: widget.counterBloc.counterObservable.value.initialCount,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(
                color: Colors.deepPurple
            ),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (int newValue) {
              selectEpisodeNumber(newValue);
            },
            items: list.map<DropdownMenuItem<int>>((int value) {
              var data = (value) == 0 ? 'eps' : value.toString();
              return DropdownMenuItem<int>(
                value: value,
                child: Text(data),
              );
            }).toList(),
          ),
          Visibility(
            child: Text('/${widget.counterBloc.counterObservable.value.maxCount}'),
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: widget.counterBloc.counterObservable.value.showWidget,
          )
        ],
      );
    });
  }
}