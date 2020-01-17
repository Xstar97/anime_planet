import 'package:rxdart/rxdart.dart';

class CounterModel{
  CounterModel(this.initialCount, this.maxCount);
  int initialCount = 0;
  int maxCount = 0;
  bool showWidget = true;
}

class CountBl{

  CounterModel model = new CounterModel(0, 0);

  BehaviorSubject<CounterModel> _subjectCounter;

  CountBl({this.model}){
    _subjectCounter = new BehaviorSubject<CounterModel>.seeded(this.model); //initializes the subject with element already
  }

  ValueStream<CounterModel> get counterObservable => _subjectCounter.stream;

  void initModel(CounterModel counterModel){
    model = counterModel;
    _subjectCounter.sink.add(model);
  }

  void increment(){
    model.initialCount++;
    if(model.initialCount == model.maxCount){
      model.showWidget = false;
    } else{
      model.showWidget = true;
    }
    _subjectCounter.sink.add(model);
  }
  void incrementByCustomValue(int value){
    model.initialCount = value;
    if(model.initialCount == model.maxCount){
      model.showWidget = false;
    } else{
      model.showWidget = true;
    }
    _subjectCounter.sink.add(model);
  }

  void decrement(){
    model.initialCount--;
    _subjectCounter.sink.add(model);
  }

  void dispose(){
    _subjectCounter.close();
  }
}