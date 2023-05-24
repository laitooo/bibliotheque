import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/models/book_details.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/utils/enum_to_text.dart';
import 'package:bibliotheque/utils/locale_date_format.dart';
import 'package:flutter/material.dart';

import '../../../i18n/translations.dart';

class AboutBookScreen extends StatelessWidget {
  final BookDetails book;

  const AboutBookScreen({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: context.theme.textColor1,
    );
    final textStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: context.theme.textColor1,
    );
    // TODO:: complete this screen (links and data)
    final linkStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: context.theme.textColor3,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.details.aboutThisBook,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: context.theme.textColor1,
          ),
        ),
        leading: IconButton(
          icon: const Svg('back.svg'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              book.aboutBook,
              style: TextStyle(
                height: 1.5,
                fontSize: 14,
                color: context.theme.textColor1,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Divider(
            thickness: 0.5,
            color: context.theme.dividerColor,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  t.details.language,
                  style: titleStyle,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  t.details.age,
                  style: titleStyle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  languageToText(book.language),
                  style: textStyle,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  ageRangeToText(book.age),
                  style: textStyle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  t.details.author,
                  style: titleStyle,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  t.details.publisher,
                  style: titleStyle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  book.authorName,
                  style: linkStyle,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  book.publisherName,
                  style: linkStyle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  t.details.publishedOn,
                  style: titleStyle,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  t.details.isbn,
                  style: titleStyle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  LocaleDateFormat.monthYearFormat(book.publishDate),
                  style: textStyle,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  book.isbn,
                  style: textStyle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  t.details.pages,
                  style: titleStyle,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  t.details.purchases,
                  style: titleStyle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  book.numPages.toString(),
                  style: textStyle,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  book.numBuyers.toString(),
                  style: textStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
