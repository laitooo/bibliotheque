import 'package:bibliotheque/blocs/faqs_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/models/question.dart';
import 'package:bibliotheque/ui/screens/settings/help/contact_tab.dart';
import 'package:bibliotheque/ui/screens/settings/help/faq_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_widgets/svg.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Help center',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
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
          bottom: TabBar(
            indicatorWeight: 4,
            labelColor: context.theme.textColor3,
            unselectedLabelColor: context.theme.textColor5,
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            indicatorColor: context.theme.primaryColor,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
            tabs: const [
              Tab(text: 'FAQ'),
              Tab(text: 'Contact us'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocProvider(
              create: (context) =>
                  FAQsBloc()..add(LoadFAQs(QuestionType.general)),
              child: const FAQTab(),
            ),
            const ContactTab(),
          ],
        ),
      ),
    );
  }
}
