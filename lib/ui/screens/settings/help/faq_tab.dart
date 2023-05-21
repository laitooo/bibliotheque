import 'package:bibliotheque/blocs/faqs_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/models/question.dart';
import 'package:bibliotheque/ui/common_widgets/try_again_widget.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/widgets/faq_question_widget.dart';
import 'package:bibliotheque/ui/widgets/filter_item.dart';
import 'package:bibliotheque/utils/enum_to_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FAQTab extends StatefulWidget {
  const FAQTab({Key? key}) : super(key: key);

  @override
  State<FAQTab> createState() => _FAQTabState();
}

class _FAQTabState extends State<FAQTab> {
  QuestionType selectedType = QuestionType.general;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FAQsBloc, FAQsState>(
      builder: (context, state) {
        if (state.status == FAQsStatus.loading) {
          return const Center(
            child: AppProgressIndicator(),
          );
        }

        if (state.status == FAQsStatus.error) {
          return TryAgainWidget(
            onPressed: () {
              BlocProvider.of<FAQsBloc>(context).add(
                LoadFAQs(selectedType),
              );
            },
          );
        }

        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 10),
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 38,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                children: QuestionType.values
                    .map(
                      (type) => Padding(
                        padding: const EdgeInsetsDirectional.only(end: 10),
                        child: FilterItem(
                          name: questionToText(type),
                          isSelected: type == selectedType,
                          onClick: () {
                            setState(() {
                              selectedType = type;
                            });
                            BlocProvider.of<FAQsBloc>(context).add(
                              LoadFAQs(type),
                            );
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 10),
            ...state.faqs!
                .map(
                  (faq) => FAQQuestionWidget(
                    faq,
                    iconColor: context.theme.activeColor,
                  ),
                )
                .toList(),
            const SizedBox(height: 50),
          ],
        );
      },
    );
  }
}
