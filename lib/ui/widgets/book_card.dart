import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/models/book.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/ui/screens/details/book_details_screen.dart';
import 'package:flutter/material.dart';

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
                  builder: (_) => BookDetailsScreen(id: book.id),
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
              Svg(
                'half_star.svg',
                size: 14,
                color: context.theme.iconColor4,
              ),
              const SizedBox(width: 5),
              Text(
                book.rate.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: context.theme.textColor4,
                ),
              ),
              const SizedBox(width: 15),
              Text(
                "\$" + book.price.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: context.theme.textColor4,
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
        height: 210,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BookDetailsScreen(id: book.id),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image(
                  image: NetworkImage(book.coveUrl),
                  height: 200,
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
                            book.rate.toString(),
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
                        "\$ " + book.price.toString(),
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
                          book.categoriesNames.length,
                          (index) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: context.theme.tagBackgroundColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              book.categoriesNames[index],
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
                  if (isWishList)
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 70),
                        child: PopupMenuButton(
                          color: context.theme.backgroundColor,
                          icon: const Svg(
                            'dots_vertical.svg',
                          ),
                          padding: EdgeInsets.zero,
                          itemBuilder: (_) {
                            return [
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    const Svg(
                                      'remove_from_list.svg',
                                      size: 18,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Remove from wish list",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: context.theme.textColor1,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: onRemoveClicked,
                              ),
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    const Svg(
                                      'send.svg',
                                      size: 18,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Share",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: context.theme.textColor1,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    const Svg(
                                      'info.svg',
                                      size: 18,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "About the app",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: context.theme.textColor1,
                                      ),
                                    ),
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

class WishListCard extends StatelessWidget {
  final Book book;
  final void Function()? onRemoveClicked;

  const WishListCard({
    Key? key,
    required this.book,
    this.onRemoveClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 0, 10),
      child: SizedBox(
        height: 180,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BookDetailsScreen(id: book.id),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image(
                  image: NetworkImage(book.coveUrl),
                  height: 200,
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
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 40),
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            book.name,
                            maxLines: 3,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              height: 2,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: context.theme.textColor1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Svg(
                            'half_star.svg',
                            size: 14,
                            color: context.theme.iconColor4,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            book.rate.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: context.theme.textColor4,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "\$ " + book.price.toString(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: context.theme.textColor4,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: PopupMenuButton(
                      color: context.theme.backgroundColor,
                      icon: const Svg(
                        'dots_vertical.svg',
                      ),
                      padding: EdgeInsets.zero,
                      itemBuilder: (_) {
                        return [
                          PopupMenuItem(
                            child: Row(
                              children: [
                                const Svg(
                                  'remove_from_list.svg',
                                  size: 18,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Remove from wish list",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: context.theme.textColor1,
                                  ),
                                ),
                              ],
                            ),
                            onTap: onRemoveClicked,
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: [
                                const Svg(
                                  'send.svg',
                                  size: 18,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Share",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: context.theme.textColor1,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: [
                                const Svg(
                                  'info.svg',
                                  size: 18,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "About the app",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: context.theme.textColor1,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ];
                      },
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
