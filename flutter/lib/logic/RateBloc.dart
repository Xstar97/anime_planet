
import 'package:rxdart/rxdart.dart';

class RateModel{
  RateModel(this.rateCount, this.rateMax);
  double rateCount;
  double rateMax;
}

class RateBloc{

  RateModel model = new RateModel(0, 5);

  BehaviorSubject<RateModel> _subjectRating;

  RateBloc({this.model}){
    _subjectRating = new BehaviorSubject<RateModel>.seeded(this.model);
  }

  ValueStream<RateModel> get ratingObservable => _subjectRating.stream;

  void setRate(double value){
    model.rateCount = value;
    _subjectRating.sink.add(model);
    print('rate $value');
  }

  void dispose(){
    _subjectRating.close();
  }
}