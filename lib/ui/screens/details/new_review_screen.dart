import 'package:bibliotheque/blocs/create_review_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/entities/review_content.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/models/book.dart';
import 'package:bibliotheque/ui/common_widgets/app_snackbar.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:bibliotheque/ui/common_widgets/mockable_image.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/ui/dialogs/created_review_success_dialog.dart';
import 'package:bibliotheque/utils/enum_to_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NewReviewScreen extends StatelessWidget {
  final Book book;

  const NewReviewScreen({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateReviewBloc(),
      child: _NewReviewScreen(book: book),
    );
  }
}

class _NewReviewScreen extends StatefulWidget {
  final Book book;

  const _NewReviewScreen({Key? key, required this.book}) : super(key: key);

  @override
  State<_NewReviewScreen> createState() => _NewReviewScreenState();
}

class _NewReviewScreenState extends State<_NewReviewScreen> {
  double rate = 0;
  final reviewContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateReviewBloc, CreateReviewState>(
      listener: (context, state) async {
        if (state.status == CreateReviewStatus.error) {
          context.showSnackBar(
            text: reviewsErrorToText(state.error!),
          );
        }

        if (state.status == CreateReviewStatus.success) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (context) => const CreatedReviewSuccessDialog(),
            useRootNavigator: false,
          );
        }
      },
      builder: (context, state) {
        if (state.status == CreateReviewStatus.sending) {
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

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Svg('back.svg'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(width: 20),
                Expanded(
                  child: MainButton(
                    title: t.createReview.submit,
                    textColor: context.theme.textColor2,
                    backgroundColor: context.theme.buttonColor1,
                    removePadding: true,
                    onPressed: () async {
                      BlocProvider.of<CreateReviewBloc>(context).add(
                        SubmitReview(
                          ReviewContent(
                            rate: rate,
                            content: reviewContent.text,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: MainFlatButton(
                    title: t.createReview.cancel,
                    removePadding: true,
                    textColor: context.theme.textColor3,
                    backgroundColor: context.theme.buttonColor2,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
          body: ListView(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: SizedBox(
                  height: 210,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: MockableImage(
                          widget.book.coveUrl,
                          height: 200,
                          type: MockImageType.bookCover,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                widget.book.name,
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  height: 1.4,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: context.theme.textColor1,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Svg(
                                  'half_star.svg',
                                  size: 14,
                                  color: context.theme.iconColor4,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  widget.book.rate.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: context.theme.textColor4,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "\$ " + widget.book.price.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: context.theme.textColor4,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              runSpacing: 8,
                              children: List.generate(
                                widget.book.categoriesNames.length,
                                (index) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: context.theme.tagBackgroundColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    widget.book.categoriesNames[index],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: context.theme.textColor4,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                    t.createReview.rateBook,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: context.theme.newReviewColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  RatingBar.builder(
                    unratedColor: context.theme.dividerColor.withOpacity(0.5),
                    glowColor: context.theme.primaryColor.withOpacity(0.3),
                    initialRating: rate,
                    itemBuilder: (context, index) {
                      return Icon(
                        Icons.star,
                        size: 28,
                        color: context.theme.primaryColor,
                      );
                    },
                    onRatingUpdate: (newRate) {
                      rate = newRate;
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 20),
                      child: Text(
                        t.createReview.describeExperience,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: context.theme.textColor1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 150,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      expands: true,
                      minLines: null,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        fontSize: 16,
                        color: context.theme.textColor1,
                      ),
                      cursorColor: context.theme.primaryColor,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.all(10),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: context.theme.primaryColor)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: context.theme.dividerColor)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
