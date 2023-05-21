import 'package:bibliotheque/blocs/book_details_bloc.dart';
import 'package:bibliotheque/blocs/does_wish_bloc.dart';
import 'package:bibliotheque/blocs/reviews_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/ui/common_widgets/mockable_image.dart';
import 'package:bibliotheque/ui/common_widgets/try_again_widget.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/ui/screens/details/about_book_screen.dart';
import 'package:bibliotheque/ui/screens/details/new_review_screen.dart';
import 'package:bibliotheque/ui/screens/details/reviews_list_screen.dart';
import 'package:bibliotheque/ui/widgets/reviews_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailsScreen extends StatelessWidget {
  final String id;

  const BookDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookDetailsBloc()..add(LoadBookDetails(id)),
        ),
        BlocProvider(
          create: (context) => DoesWishBloc()..add(CheckWishStatus(id)),
        ),
      ],
      child: _BookDetailsScreen(id: id),
    );
  }
}

class _BookDetailsScreen extends StatelessWidget {
  final String id;

  const _BookDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailsBloc, BookDetailsState>(
      builder: (context, state) {
        if (state.status == BookDetailsStatus.loading) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Svg('back.svg'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: const Center(
              child: AppProgressIndicator(size: 100),
            ),
          );
        }

        if (state.status == BookDetailsStatus.error) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Svg('back.svg'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: TryAgainWidget(
              onPressed: () {
                BlocProvider.of<BookDetailsBloc>(context).add(
                  LoadBookDetails(id),
                );
              },
            ),
          );
        }

        final book = state.details!;

        return Scaffold(
          appBar: AppBar(
            actions: [
              BlocBuilder<DoesWishBloc, DoesWishState>(
                builder: (context, doesWishState) {
                  if (doesWishState.status != DoesWishStatus.success) {
                    return const SizedBox();
                  }

                  return IconButton(
                    onPressed: () {
                      if (doesWishState.doesWish!) {
                        BlocProvider.of<DoesWishBloc>(context)
                            .add(RemoveFromWishList(book.id));
                      } else {
                        BlocProvider.of<DoesWishBloc>(context)
                            .add(AddToWishList(book.toBook()));
                      }
                    },
                    icon: Svg(
                      doesWishState.doesWish!
                          ? 'add_to_list.svg'
                          : 'remove_from_list.svg',
                      color: doesWishState.doesWish!
                          ? context.theme.iconColor1
                          : context.theme.textColor3,
                    ),
                  );
                },
              ),
              IconButton(
                onPressed: () {},
                icon: const Svg('send.svg'),
              ),
            ],
            leading: IconButton(
              icon: const Svg('back.svg'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: ListView(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 20),
                  Flexible(
                    flex: 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: MockableImage(
                        book.coveUrl,
                        type: MockImageType.bookCover,
                        // width: 135,
                        // height: 210,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          book.name,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: context.theme.textColor1,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          book.authorName,
                          style: TextStyle(
                            fontSize: 16,
                            color: context.theme.textColor3,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          t.details.releasedOn +
                              book.publishDate.month.toString() +
                              '. ' +
                              book.publishDate.year.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: context.theme.textColor4,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 8,
                          children: List.generate(
                            book.categoriesNames.length,
                            (index) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: context.theme.tagBackgroundColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                book.categoriesNames[index],
                                style: TextStyle(
                                    fontSize: 12,
                                    color: context.theme.textColor4),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            book.rate.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: context.theme.textColor1,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Svg(
                            'half_star.svg',
                            size: 16,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        book.numReviews.toString() + " " + t.details.reviews,
                        style: TextStyle(
                          fontSize: 14,
                          color: context.theme.textColor4,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        book.numPages.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: context.theme.textColor1,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        t.details.pages,
                        style: TextStyle(
                          fontSize: 14,
                          color: context.theme.textColor4,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        book.numBuyers.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: context.theme.textColor1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        t.details.purchases,
                        style: TextStyle(
                          fontSize: 14,
                          color: context.theme.textColor4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              MainButton(
                title: t.details.buy +
                    ' ${book.price.toString()} ' +
                    t.details.usd,
                backgroundColor: Colors.orange,
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 20),
                    child: Text(
                      t.details.aboutThisBook,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: context.theme.textColor1,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => AboutBookScreen(book: book),
                        ),
                      );
                    },
                    icon: Svg(
                      'forward.svg',
                      color: context.theme.iconColor2,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  book.aboutBook,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: TextStyle(
                    fontSize: 14,
                    color: context.theme.textColor1,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 20),
                    child: Text(
                      t.details.ratingsAndReviews,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: context.theme.textColor1,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => ReviewsBloc()..add(LoadReviews()),
                            child: ReviewsListScreen(book: book),
                          ),
                        ),
                      );
                    },
                    icon: Svg(
                      'forward.svg',
                      color: context.theme.iconColor2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ReviewsNumbersWidget(
                rate: book.rate,
                reviewsNumber: book.numReviews,
                numberByReview: book.reviewsPercentage,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    t.details.rateBook,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: context.theme.newReviewColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star_border,
                        size: 28,
                        color: context.theme.newReviewColor,
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.star_border,
                        size: 28,
                        color: context.theme.newReviewColor,
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.star_border,
                        size: 28,
                        color: context.theme.newReviewColor,
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.star_border,
                        size: 28,
                        color: context.theme.newReviewColor,
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.star_border,
                        size: 28,
                        color: context.theme.newReviewColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 2,
                        child: MainFlatButton(
                          title: t.details.writeReview,
                          textColor: context.theme.primaryColor,
                          backgroundColor: context.theme.backgroundColor,
                          borderColor: context.theme.primaryColor,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    NewReviewScreen(book: book.toBook()),
                              ),
                            );
                          },
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
