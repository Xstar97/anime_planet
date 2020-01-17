
import 'package:anime_planet/logic/RateBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';

class DataCellRatingBar extends StatefulWidget {
  DataCellRatingBar({Key key, this.rateBloc}) : super(key: key);
  RateBloc rateBloc;

  @override
  _DataCellRatingBarState createState() => _DataCellRatingBarState();
}

class _DataCellRatingBarState extends State<DataCellRatingBar> {

  @override
  Widget build(BuildContext context) {
     return new StreamBuilder(stream: widget.rateBloc.ratingObservable, builder: (context, AsyncSnapshot<RateModel> snapshot){
      return RatingBar(
      initialRating: widget.rateBloc.model.rateCount,
      onRatingChanged: (rating) => widget.rateBloc.setRate(rating),
      filledIcon: Icons.star,
      isHalfAllowed: true,
      halfFilledIcon: Icons.star_half,
      emptyIcon: Icons.star_border,
    );
    });
  }
}