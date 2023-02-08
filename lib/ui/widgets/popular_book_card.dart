import 'package:bibliotheque/blocs/theme.dart';
import 'package:bibliotheque/models/book.dart';
import 'package:flutter/material.dart';

class PopularBookCard extends StatelessWidget {
  final Book book;
  const PopularBookCard({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.fromLTRB(1, 1, 1, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: NetworkImage(book.coveUrl),
                width: 178,
                height: 280,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Text(
                book.name,
                maxLines: 2,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  color: context.theme.primaryTextColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star_rate_outlined,
                  size: 14,
                ),
                const SizedBox(width: 5),
                Text(
                  book.rate.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  book.price.toString() + "\$",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
