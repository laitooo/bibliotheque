import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';

class VerificationCode extends StatefulWidget {
  final void Function(String code) onChanged;
  final int codeLength;

  const VerificationCode(
      {Key? key, required this.onChanged, this.codeLength = 6})
      : super(key: key);

  @override
  _VerificationCodeState createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  late List<FocusNode> _focusNodes;

  bool _showFocusedBorder = false;

  late List<TextEditingController> _controllers;

  late List<String?> _code;
  String get code => _code.map((v) => v ??= '').join();
  set code(String value) {
    _code = value
        // make it at least codeLength characters
        .padRight(widget.codeLength)
        .split('')
        // make it at most codeLength characters
        .sublist(0, widget.codeLength);
    // replace whitespace characters used for padding with null
    _code = _code.map((char) => char == ' ' ? null : char).toList();
  }

  _VerificationCodeState();

  @override
  void initState() {
    _controllers = <TextEditingController>[
      // the use of the initial value ('.') is explained in __DigitBlock
      for (int i = 0; i < widget.codeLength; ++i)
        TextEditingController(text: '.'),
    ];
    _code = <String>[for (int i = 0; i < widget.codeLength; ++i) ''];

    _focusNodes = <FocusNode>[
      for (int i = 0; i < widget.codeLength; ++i)
        FocusNode()
          ..addListener(() {
            setState(() {
              _showFocusedBorder =
                  _focusNodes.any((element) => element.hasFocus);
            });
          }),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          for (int i = 0; i < widget.codeLength ~/ 2; ++i)
            _DigitBlock(
              controller: _controllers[i],
              showFocusedBorder: _showFocusedBorder,
              focusNode: _focusNodes[i],
              prevNode: i == 0 ? null : _focusNodes[i - 1],
              nextNode: i == widget.codeLength - 1 ? null : _focusNodes[i + 1],
              onChanged: (value) => _updateCode(i, value),
            ),
          const SizedBox(width: 4.0),
          for (int i = widget.codeLength ~/ 2; i < widget.codeLength; ++i)
            _DigitBlock(
              controller: _controllers[i],
              showFocusedBorder: _showFocusedBorder,
              focusNode: _focusNodes[i],
              prevNode: i == 0 ? null : _focusNodes[i - 1],
              nextNode: i == widget.codeLength - 1 ? null : _focusNodes[i + 1],
              onChanged: (value) => _updateCode(i, value),
            ),
        ],
      ),
    );
  }

  void _updateCode(int i, String value) {
    if (value.length > 1) {
      // paste operation. we don't care where the paste operation happens, the
      // value characters are assigned in order starting from first digit.
      code = value;
      final lastDigitIndex = min(value.length, _controllers.length) - 1;
      for (int i = 0; i < lastDigitIndex + 1; ++i) {
        _controllers[i].text = value[i];
        _controllers[i].selection = const TextSelection.collapsed(
            offset: 1, affinity: TextAffinity.upstream);
      }
      if (lastDigitIndex < widget.codeLength - 1) {
        _focusNodes[lastDigitIndex + 1].requestFocus();
      } else {
        _focusNodes[lastDigitIndex].requestFocus();
      }
    } else {
      _code[i] = value;
    }
    widget.onChanged(code);
  }
}

class _DigitBlock extends StatefulWidget {
  final FocusNode focusNode;
  final FocusNode? prevNode, nextNode;
  final TextEditingController controller;
  final void Function(String) onChanged;
  final bool showFocusedBorder;

  const _DigitBlock({
    Key? key,
    required this.controller,
    required this.showFocusedBorder,
    required this.focusNode,
    this.prevNode,
    this.nextNode,
    required this.onChanged,
  }) : super(key: key);

  @override
  __DigitBlockState createState() => __DigitBlockState();
}

class __DigitBlockState extends State<_DigitBlock> {
  bool isEmpty = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        isEmpty = widget.controller.text == '.';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45.0,
      child: TextField(
        keyboardType: TextInputType.number,
        maxLength: 1,
        maxLines: 1,
        buildCounter: (
          context, {
          required currentLength,
          required isFocused,
          maxLength,
        }) =>
            null,
        maxLengthEnforcement: MaxLengthEnforcement.none,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        controller: widget.controller,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: isEmpty
                  ? context.theme.input.borderColor
                  : context.theme.primaryColor,
              width: 2.0,
            ),
          ),
        ),
        style: TextStyle(
          fontSize: 18.0,
          color: isEmpty ? Colors.transparent : context.theme.primaryColor,
        ),
        onChanged: (value) {
          // we need to detect deletions even when the field is empty to move
          // focus to previous FocusNode, but Flutter doesn't provide a way to
          // detect that. The workaround is to use a hidden character, ie, we
          // never leave the field empty. When [value] is empty, that means
          // backspace is pressed (a deletion) so we move focus to previous
          // field and we reset the field value to the empty character.
          //
          // the empty character used is the dot character '.'
          //
          // note that when the empty character is placed in the field the
          // text color is set to hide the character.

          if (value.isEmpty) {
            // this is a deletion, invoke callback with empty value
            widget.onChanged('');
            widget.prevNode?.requestFocus();

            // reset field value to the empty character ('.')
            widget.controller.text = '.';
            widget.controller.selection = const TextSelection.collapsed(
                offset: 1, affinity: TextAffinity.upstream);
          } else if (value.length > 2) {
            // paste operation. remove empty character if present
            // the paste can happen in the position after or before the empty
            // character or it can replace it (select all then paste).
            value = value.replaceFirst(RegExp(r'(^\.)|(\.$)'), '');
            if (!RegExp(r'^[0-9]+$').hasMatch(value) && value.isNotEmpty) {
              // on errors we reset the field to the empty character
              widget.controller.text = '.';
              widget.controller.selection = const TextSelection.collapsed(
                  offset: 1, affinity: TextAffinity.upstream);
              return;
            }

            widget.onChanged(value);
          } else {
            // the character inserted is the one before the cursor
            final newCharIndex = widget.controller.value.selection.start - 1;
            final char = value[newCharIndex];
            if (!RegExp(r'[0-9]+').hasMatch(char) && char.isNotEmpty) {
              // on errors we reset the field to the empty character
              widget.controller.text = '.';
              widget.controller.selection = const TextSelection.collapsed(
                  offset: 1, affinity: TextAffinity.upstream);
              return;
            }
            widget.onChanged(char);
            widget.nextNode?.requestFocus();

            widget.controller.text = char;
            widget.controller.selection = const TextSelection.collapsed(
                offset: 1, affinity: TextAffinity.upstream);
          }
        },
      ),
    );
  }
}
