
import 'package:anime_planet/logic/CounterBloc.dart';
import 'package:flutter/material.dart';

class WatchingDataCellEpisodeCounter extends StatefulWidget {
  WatchingDataCellEpisodeCounter({Key key, this.counterBloc}) : super(key: key);
  CountBl counterBloc;

  @override
  _WatchingDataCellEpisodeCounterState createState() => _WatchingDataCellEpisodeCounterState();
}

class _WatchingDataCellEpisodeCounterState extends State<WatchingDataCellEpisodeCounter> {
  @override
  void initState() {
    super.initState();
  }
  void incrementCounter(){
    widget.counterBloc.increment();
  }

  @override
  Widget build(BuildContext context) {

    return new StreamBuilder(stream: widget.counterBloc.counterObservable, builder: (context, AsyncSnapshot<CounterModel> snapshot){

      return Visibility(
        child: new FlatButton(onPressed: () {
          incrementCounter();
        },
          child: Text('+eps'),
        ),
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: widget.counterBloc.counterObservable.value.showWidget,
      );
    });
  }

  @override
  void dispose() {
    widget.counterBloc.dispose();
    super.dispose();
  }
}