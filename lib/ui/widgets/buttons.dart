import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';

const kAppButtonHeight = 48.0;

class MainButton extends StatelessWidget {
  final String title;
  final Widget? icon;
  final void Function()? onPressed;
  final double? height;
  final double? width;
  final bool showShadow;
  final bool removePadding;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? shadowColor;
  final Color? progressIndicatorColor;

  const MainButton({
    Key? key,
    required this.title,
    this.icon,
    this.onPressed,
    this.height,
    this.width,
    this.showShadow = true,
    this.removePadding = false,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.shadowColor,
    this.progressIndicatorColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? kAppButtonHeight,
      width: width,
      padding: removePadding
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(onPressed != null
              ? backgroundColor ?? context.theme.primaryColor
              : context.theme.hintColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          shadowColor: showShadow
              ? MaterialStateProperty.all(
                  shadowColor ?? context.theme.mainButtonShadowColor)
              : MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: isLoading ? null : onPressed,
        child: Center(
          child: isLoading
              ? AppProgressIndicator(
                  size: 30,
                  color: progressIndicatorColor,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      icon!,
                      const SizedBox(width: 16),
                    ],
                    Text(
                      title,
                      style: TextStyle(
                        color: textColor ?? context.theme.mainButtonTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class MainFlatButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final Widget? icon;
  final double? height;
  final double? width;
  final bool removePadding;
  final bool isLoading;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;

  const MainFlatButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.icon,
    this.height,
    this.width,
    this.removePadding = false,
    this.isLoading = false,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? kAppButtonHeight,
      width: width,
      padding: removePadding
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 24),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              backgroundColor ?? context.theme.cardColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor ?? Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: onPressed,
        child: isLoading
            ? const AppProgressIndicator(size: 30)
            : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      icon!,
                      const SizedBox(width: 10),
                    ],
                    Text(
                      title,
                      style: TextStyle(
                        color: textColor ?? context.theme.cardColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class MainIconButton extends StatelessWidget {
  final String title;
  final Widget icon;
  final Function()? onPressed;
  final double? height;
  final double? width;
  final bool removePadding;
  final bool isLoading;

  const MainIconButton({
    Key? key,
    required this.title,
    required this.icon,
    this.onPressed,
    this.height,
    this.width,
    this.removePadding = false,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? kAppButtonHeight,
      width: width,
      padding: removePadding
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(color: context.theme.borderColor),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Center(
          child: isLoading
              ? const AppProgressIndicator(size: 30)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon,
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: TextStyle(
                        color: context.theme.titleColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
