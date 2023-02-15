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
          Flexible(
            child: GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  book.name,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: context.theme.textColor1,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 15),
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
                "\$" + book.price.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class HorizontalBookCard extends StatelessWidget {
  final Book book;
  final bool isWishList;
  final void Function()? onRemoveClicked;

  const HorizontalBookCard({
    Key? key,
    required this.book,
    required this.isWishList,
    this.onRemoveClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
        height: 180,
        child: Row(
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
                borderRadius: BorderRadius.circular(8),
                child: Image(
                  image: NetworkImage(book.coveUrl),
                  height: 180,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          book.name,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: context.theme.textColor1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
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
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "\$ " + book.price.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
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
                                horizontal: 6, vertical: 4),
                            decoration: BoxDecoration(
                              color: context.theme.tagBackgroundColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              book.categoriesNames[index],
                              style: TextStyle(
                                fontSize: 14,
                                color: context.theme.textColor1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: PopupMenuButton(
                        icon: const Icon(Icons.list),
                        padding: EdgeInsets.zero,
                        itemBuilder: (_) {
                          return [
                            PopupMenuItem(
                              child: Row(
                                children: const [
                                  Icon(Icons.remove),
                                  SizedBox(width: 10),
                                  Text("Remove from wish list"),
                                ],
                              ),
                              onTap: onRemoveClicked,
                            ),
                            PopupMenuItem(
                              child: Row(
                                children: const [
                                  Icon(Icons.share),
                                  SizedBox(width: 10),
                                  Text("Share"),
                                ],
                              ),
                              onTap: () {},
                            ),
                            PopupMenuItem(
                              child: Row(
                                children: const [
                                  Icon(Icons.info_outline),
                                  SizedBox(width: 10),
                                  Text("About the app"),
                                ],
                              ),
                              onTap: () {},
                            ),
                          ];
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
