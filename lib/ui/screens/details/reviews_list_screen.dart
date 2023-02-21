import 'package:bibliotheque/blocs/reviews_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/models/book_details.dart';
import 'package:bibliotheque/models/review.dart';
import 'package:bibliotheque/ui/common_widgets/bloc_generic_loader.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/widgets/filter_item.dart';
import 'package:bibliotheque/ui/widgets/review_card.dart';
import 'package:bibliotheque/ui/widgets/reviews_numbers.dart';
import 'package:bibliotheque/utils/enum_to_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsListScreen extends StatefulWidget {
  final BookDetails book;

  const ReviewsListScreen({Key? key, required this.book}) : super(key: key);

  @override
  State<ReviewsListScreen> createState() => _ReviewsListScreenState();
}

class _ReviewsListScreenState extends State<ReviewsListScreen> {
  StarsNumber? selectedNumOfStarts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ratings & Reviews"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          ReviewsNumbersWidget(
            rate: widget.book.rate,
            reviewsNumber: widget.book.numReviews,
            numberByReview: widget.book.reviewsPercentage,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              thickness: 0.5,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 32,
            width: MediaQuery.of(context).size.width,
            child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                children: [
                  FilterItem(
                    name: "All",
                    isSelected: selectedNumOfStarts == null,
                    icon: Icon(
                      Icons.star,
                      size: 14,
                      color: selectedNumOfStarts == null
                          ? context.theme.filterItemColor2
                          : context.theme.filterItemColor1,
                    ),
                    onClick: () {
                      setState(() {
                        selectedNumOfStarts = null;
                      });
                      BlocProvider.of<ReviewsBloc>(context).add(
                        LoadReviews(starsNumber: null),
                      );
                    },
                  ),
                  ...StarsNumber.values
                      .map(
                        (stars) => Padding(
                          padding: const EdgeInsetsDirectional.only(start: 10),
                          child: FilterItem(
                            name: starsNumberToText(stars),
                            isSelected: selectedNumOfStarts == stars,
                            icon: Icon(
                              Icons.star,
                              size: 14,
                              color: stars == selectedNumOfStarts
                                  ? context.theme.filterItemColor2
                                  : context.theme.filterItemColor1,
                            ),
                            onClick: () {
                              setState(() {
                                selectedNumOfStarts = stars;
                              });
                              BlocProvider.of<ReviewsBloc>(context).add(
                                LoadReviews(starsNumber: stars),
                              );
                            },
                          ),
                        ),
                      )
                      .toList(),
                ]),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              thickness: 0.5,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<ReviewsBloc, ReviewsState>(builder: (context, state) {
            if (state.status == ReviewsStatus.loading) {
              return const SizedBox(
                height: 300,
                child: Center(
                  child: AppProgressIndicator(size: 100),
                ),
              );
            }

            if (state.status == ReviewsStatus.error) {
              return SizedBox(
                height: 300,
                child: TryAgainWidget(
                  onPressed: () {
                    BlocProvider.of<ReviewsBloc>(context).add(
                      LoadReviews(starsNumber: selectedNumOfStarts),
                    );
                  },
                ),
              );
            }

            return Column(
              children: state.reviews!
                  .map(
                    (review) => ReviewCard(
                      review: review,
                    ),
                  )
                  .toList(),
            );
          }),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
