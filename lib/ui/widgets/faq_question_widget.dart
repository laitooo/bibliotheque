import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/models/question.dart';
import 'package:bibliotheque/utils/locale_based_string_selector.dart';
import 'package:flutter/material.dart';

class FAQQuestionWidget extends StatefulWidget {
  final Question question;
  final Color? iconColor;

  const FAQQuestionWidget(
    this.question, {
    Key? key,
    this.iconColor = Colors.black,
  }) : super(key: key);

  @override
  FAQQuestionWidgetState createState() => FAQQuestionWidgetState();
}

class FAQQuestionWidgetState extends State<FAQQuestionWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  Duration animatedIconsDuration = const Duration(seconds: 1);
  Duration textExpansion = const Duration(seconds: 1);

  bool visible = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: animatedIconsDuration);
  }

  void toggle() {
    setState(() {
      visible = !visible;
      bool isPlaying = visible;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.black.withOpacity(0.2),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: toggle,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LocaleBasedStringSelector.select(
                    context,
                    widget.question.questionAr,
                    widget.question.questionEn,
                  ),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: context.theme.textColor1),
                ),
                const Spacer(),
                AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: _animationController,
                  color: widget.iconColor,
                ),
              ],
            ),
          ),
          ExpandedSection(
            duration: textExpansion,
            expand: visible,
            child: Column(
              children: [
                const SizedBox(height: 4),
                Divider(
                  color: context.theme.dividerColor,
                  thickness: 0.5,
                ),
                const SizedBox(height: 10),
                Text(
                  LocaleBasedStringSelector.select(
                    context,
                    widget.question.answerAr,
                    widget.question.answerEn,
                  ),
                  style: TextStyle(
                    fontSize: 14,
                    color: context.theme.textColor4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandedSection extends StatefulWidget {
  final Duration duration;

  final Widget? child;
  final bool expand;

  const ExpandedSection(
      {Key? key,
      this.expand = false,
      this.child,
      this.duration = const Duration(seconds: 1)})
      : super(key: key);

  @override
  ExpandedSectionState createState() => ExpandedSectionState();
}

class ExpandedSectionState extends State<ExpandedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;
  Duration? duration;

  @override
  void initState() {
    super.initState();
    duration = widget.duration;
    prepareAnimations();
    _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(vsync: this, duration: duration);
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0, sizeFactor: animation, child: widget.child);
  }
}
