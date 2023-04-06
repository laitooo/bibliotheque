import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/models/review.dart';
import 'package:bibliotheque/ui/common_widgets/circle_image_widget.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/ui/widgets/filter_item.dart';
import 'package:bibliotheque/utils/enum_to_text.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 20),
            CircleImageWidget(
              review.userCover,
              size: 50,
            ),
            const SizedBox(width: 20),
            Text(
              review.userName,
              maxLines: 2,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: context.theme.textColor1,
              ),
            ),
            const Spacer(),
            IconFilterItem(
              name: starsNumberToText(review.numStars),
              icon: Icon(
                Icons.star,
                size: 14,
                color: context.theme.filterItemColor1,
              ),
              isSelected: false,
              onClick: () {},
            ),
            IconButton(
              onPressed: () {},
              icon: const Svg(
                'more.svg',
                size: 28,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            review.content,
            style: TextStyle(
              fontSize: 16,
              color: context.theme.textColor1,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const SizedBox(width: 20),
            // TODO: do on fav clicked interaction
            Svg(
              review.hasLiked ? 'favorite_full.svg' : 'favorite_empty.svg',
              color: review.hasLiked
                  ? context.theme.iconColor2
                  : context.theme.iconColor1,
            ),
            const SizedBox(width: 10),
            Text(
              review.numLikes.toString(),
              style: TextStyle(
                fontSize: 14,
                color: context.theme.textColor1,
              ),
            ),
            const SizedBox(width: 20),
            // TODO: do time format
            Text(
              review.creationDate.toString(),
              style: TextStyle(
                fontSize: 14,
                color: context.theme.textColor1,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
