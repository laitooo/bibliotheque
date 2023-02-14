import 'package:bibliotheque/blocs/book_details_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/models/book.dart';
import 'package:bibliotheque/ui/screens/details/book_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.fromLTRB(1, 1, 1, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (context) => BookDetailsBloc()
                      ..add(
                        LoadBookDetails(book.id),
                      ),
                    child: BookDetailsScreen(id: book.id),
                  ),
                ),
              );
            },
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
                  color: context.theme.textColor1,
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
