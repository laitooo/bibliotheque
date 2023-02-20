import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/models/book_details.dart';
import 'package:bibliotheque/utils/enum_to_text.dart';
import 'package:flutter/material.dart';

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
        title: const Text("About this book"),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              book.aboutBook,
              style: const TextStyle(
                height: 1.5,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Divider(
            thickness: 0.5,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "Language",
                  style: titleStyle,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Age",
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
                  "Author",
                  style: titleStyle,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Publisher",
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
                  "Published on",
                  style: titleStyle,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "ISBN",
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
                  book.publishDate.toString(),
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
                  "Pages",
                  style: titleStyle,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Purchases",
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
