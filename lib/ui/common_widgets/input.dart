import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.g.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:flutter/material.dart';

const kAppTextFieldHeight = 48.0;

class _TextFieldDecoration extends StatelessWidget {
  const _TextFieldDecoration({
    Key? key,
    required this.child,
    required this.borderColor,
  }) : super(key: key);

  final Widget child;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
          color: context.theme.backgroundColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: borderColor ?? context.theme.borderColor)),
      child: child,
    );
  }
}

class _TextFieldError extends StatelessWidget {
  const _TextFieldError({Key? key, required this.message}) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    return message != null
        ? Container(
            padding: const EdgeInsetsDirectional.only(start: 32.0),
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              message!,
              style: const TextStyle(color: Colors.red),
            ),
          )
        : const SizedBox();
  }
}

class AppTextField extends StatefulWidget {
  final String hint;
  final Widget? icon;
  final Widget? actionIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String value)? onChanged;
  final String? error;
  final String? initialValue;
  final double? height;
  final EdgeInsets? contentPadding;
  final TextInputType? keyboardType;
  final TextDirection? textDirection;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Color? borderColor;

  const AppTextField({
    Key? key,
    required this.hint,
    this.icon,
    this.actionIcon,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.error,
    this.initialValue,
    this.height,
    this.contentPadding,
    this.keyboardType,
    this.textDirection,
    this.textInputAction,
    this.borderColor,
    this.obscureText = false,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final TextEditingController controller;

  @override
  initState() {
    super.initState();
    controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconTheme(
          data: IconThemeData(color: context.theme.input.hintColor),
          child: _TextFieldDecoration(
            borderColor: widget.borderColor,
            child: SizedBox(
              height: kAppTextFieldHeight,
              child: Row(
                textDirection: TextDirection.ltr,
                children: [
                  if (widget.actionIcon != null) widget.actionIcon!,
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (widget.icon != null) ...[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: widget.icon!,
                          ),
                          const SizedBox(width: 10),
                        ],
                        Expanded(
                          child: TextFormField(
                            controller: controller,
                            focusNode: widget.focusNode,
                            onChanged: widget.onChanged,
                            textInputAction: widget.textInputAction,
                            obscureText: widget.obscureText,
                            keyboardType: widget.keyboardType,
                            textDirection: widget.textDirection,
                            style: TextStyle(
                              color: context.theme.primaryTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              isCollapsed: true,
                              border: InputBorder.none,
                              hintText: widget.hint,
                              hintStyle: TextStyle(
                                color: context.theme.hintColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        _TextFieldError(message: widget.error),
      ],
    );
  }
}

class AppFormField extends StatefulWidget {
  final String? hint;
  final Widget? icon;
  final bool isSingleLine;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String value)? onChanged;
  final double? width;
  final double? height;
  final String? initialValue;
  final Color? borderColor;

  const AppFormField({
    Key? key,
    this.hint,
    this.icon,
    this.focusNode,
    this.isSingleLine = false,
    this.onChanged,
    this.initialValue,
    this.controller,
    this.width,
    this.height,
    this.borderColor,
  }) : super(key: key);

  @override
  _AppFormFieldState createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  late final TextEditingController controller;

  @override
  initState() {
    super.initState();
    controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: context.theme.dropDownTextColor),
      child: _TextFieldDecoration(
        borderColor: widget.borderColor,
        child: Container(
          height: widget.height ?? kAppTextFieldHeight * 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: controller,
            onChanged: widget.onChanged,
            keyboardType: TextInputType.multiline,
            maxLines: widget.isSingleLine ? 1 : null,
            style: TextStyle(
              color: context.theme.dropDownTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              isDense: true,
              hintText: widget.hint,
              prefixIcon: widget.icon,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              contentPadding: const EdgeInsets.all(10),
              hintStyle: TextStyle(
                color: context.theme.dropDownTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppPhoneNumberField extends StatefulWidget {
  final TextEditingController? controller;
  final String? error;
  final double? width;
  final double? height;
  final void Function(String phoneNumber)? onChanged;
  final TextInputAction? textInputAction;
  final bool isShowingIcon;

  const AppPhoneNumberField(
      {Key? key,
      this.controller,
      this.error,
      this.width,
      this.height,
      this.textInputAction,
      this.onChanged,
      this.isShowingIcon = true})
      : super(key: key);

  @override
  _AppPhoneNumberFieldState createState() => _AppPhoneNumberFieldState();
}

class _AppPhoneNumberFieldState extends State<AppPhoneNumberField> {
  late final TextEditingController controller;
  final countryCode = '+974';

  @override
  initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildField(context),
        _TextFieldError(message: widget.error),
      ],
    );
  }

  Widget _buildPhoneIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Svg(
        'assets/icons/phone_number.svg',
        color: context.theme.hintColor,
        matchTextDirection: true,
        size: 24.0,
      ),
    );
  }

  Widget _buildField(BuildContext context) {
    final t = Translations.of(context).widgets;
    return AppTextField(
      icon: widget.isShowingIcon ? _buildPhoneIcon(context) : null,
      actionIcon: _buildCountryCode(context),
      textDirection: TextDirection.ltr,
      controller: controller,
      onChanged: (phoneNumber) {
        widget.onChanged?.call(countryCode + phoneNumber);
      },
      contentPadding: const EdgeInsets.only(top: 3.0),
      keyboardType: TextInputType.phone,
      hint: t.phoneNumber,
      textInputAction: widget.textInputAction,
      borderColor: widget.error == null ? null : context.theme.input.errorColor,
    );
  }

  Widget _buildCountryCode(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/qatar.png',
            width: 24.0,
            height: 24.0,
          ),
          const SizedBox(width: 6.0),
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Text(
              countryCode,
              style: TextStyle(color: context.theme.input.hintColor),
            ),
          ),
          const SizedBox(width: 6.0),
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.theme.borderColor,
            ),
            child: const SizedBox(width: 1, height: double.infinity),
          ),
          const SizedBox(width: 12.0),
        ],
      ),
    );
  }
}
