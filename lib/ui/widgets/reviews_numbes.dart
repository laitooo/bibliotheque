import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ReviewsNumbersWidget extends StatelessWidget {
  final double rate;
  final int reviewsNumber;
  final List<double> numberByReview;

  const ReviewsNumbersWidget(
      {Key? key,
      required this.rate,
      required this.reviewsNumber,
      required this.numberByReview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                rate.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              RatingBar.builder(
                initialRating: rate,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 18,
                ignoreGestures: true,
                itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                unratedColor: Colors.orangeAccent.shade100,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.orange,
                ),
                onRatingUpdate: (rating) {},
              ),
              const SizedBox(height: 10),
              Text(
                '(${reviewsNumber}k reviews)',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 5),
        Container(
          width: 0.5,
          height: 150,
          color: Colors.grey.shade400,
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 4,
          child: Column(
            children: List.generate(
              5,
              (index) => _getProgressBar(
                5 - index,
                numberByReview[index],
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  _getProgressBar(int number, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            number.toString(),
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: LinearPercentIndicator(
              lineHeight: 6.0,
              percent: value,
              linearGradient: LinearGradient(
                colors: [Colors.orangeAccent.shade100, Colors.orange],
              ),
              backgroundColor: Colors.grey.shade300,
              barRadius: const Radius.circular(5),
            ),
          ),
        ],
      ),
    );
  }
}
