import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/utils/locale_date_format.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final String initialValue;
  final TextEditingController controller;
  final TextInputType? inputType;

  const AppTextField({
    Key? key,
    required this.label,
    required this.initialValue,
    required this.controller,
    this.inputType,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.initialValue;
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: focusNode.hasFocus
                ? context.theme.textFieldActiveColor
                : context.theme.textFieldInactiveColor,
          ),
        ),
        TextField(
          focusNode: focusNode,
          controller: widget.controller,
          keyboardType: widget.inputType ?? TextInputType.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: context.theme.textColor1,
          ),
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.theme.textFieldInactiveColor,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.theme.textFieldActiveColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppPasswordTextField extends StatefulWidget {
  final String label;
  final String initialValue;
  final TextEditingController controller;

  const AppPasswordTextField({
    Key? key,
    required this.label,
    required this.initialValue,
    required this.controller,
  }) : super(key: key);

  @override
  _AppPasswordTextFieldState createState() => _AppPasswordTextFieldState();
}

class _AppPasswordTextFieldState extends State<AppPasswordTextField> {
  final focusNode = FocusNode();
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.initialValue;
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: focusNode.hasFocus
                ? context.theme.textFieldActiveColor
                : context.theme.textFieldInactiveColor,
          ),
        ),
        TextField(
          controller: widget.controller,
          focusNode: focusNode,
          obscureText: !isPasswordVisible,
          enableSuggestions: false,
          autocorrect: false,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: context.theme.textColor1,
          ),
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.theme.textFieldInactiveColor,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.theme.textFieldActiveColor,
              ),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
              icon: Svg(
                isPasswordVisible ? "hide_password.svg" : "show_password.svg",
                size: 20,
                color: focusNode.hasFocus
                    ? context.theme.textFieldActiveColor
                    : context.theme.textFieldInactiveColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppDateSelector extends StatefulWidget {
  final String label;
  final DateTime? selectedDateTime;
  final void Function(DateTime dateTime) onDateSelected;

  const AppDateSelector({
    Key? key,
    required this.label,
    required this.onDateSelected,
    this.selectedDateTime,
  }) : super(key: key);

  @override
  _AppDateSelectorState createState() => _AppDateSelectorState();
}

class _AppDateSelectorState extends State<AppDateSelector> {
  bool isSelecting = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelecting
                ? context.theme.textFieldActiveColor
                : context.theme.textFieldInactiveColor,
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () async {
            setState(() {
              isSelecting = true;
            });

            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1900),
              lastDate: DateTime(2023),
            );

            if (pickedDate != null) {
              widget.onDateSelected(pickedDate);
            }

            setState(() {
              isSelecting = false;
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (widget.selectedDateTime != null)
                Text(
                  LocaleDateFormat.defaultFormat(widget.selectedDateTime!),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: context.theme.textColor1,
                  ),
                ),
              const Spacer(),
              Svg(
                "calendar.svg",
                size: 16,
                color: isSelecting
                    ? context.theme.textFieldActiveColor
                    : context.theme.textFieldInactiveColor,
              ),
            ],
          ),
        ),
        const SizedBox(height: 3),
        Divider(
          thickness: 1,
          color: isSelecting
              ? context.theme.textFieldActiveColor
              : context.theme.textFieldInactiveColor,
        ),
      ],
    );
  }
}

class AppCountrySelector extends StatefulWidget {
  final String label;
  final Country? selectedCountry;
  final void Function(Country country) onCountrySelected;

  const AppCountrySelector({
    Key? key,
    required this.label,
    required this.onCountrySelected,
    this.selectedCountry,
  }) : super(key: key);

  @override
  _AppCountrySelectorState createState() => _AppCountrySelectorState();
}

class _AppCountrySelectorState extends State<AppCountrySelector> {
  bool isSelecting = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelecting
                ? context.theme.textFieldActiveColor
                : context.theme.textFieldInactiveColor,
          ),
        ),
        const SizedBox(height: 15),
        GestureDetector(
          onTap: () async {
            setState(() {
              isSelecting = true;
            });

            showCountryPicker(
              context: context,
              countryListTheme: CountryListThemeData(
                flagSize: 25,
                backgroundColor: Colors.white,
                textStyle:
                    const TextStyle(fontSize: 16, color: Colors.blueGrey),
                bottomSheetHeight: 500,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                inputDecoration: InputDecoration(
                  labelText: 'Search',
                  hintText: 'Start typing to search',
                  prefixIcon: const Svg(
                    "search.svg",
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color(0xFF8C98A8).withOpacity(0.2),
                    ),
                  ),
                ),
              ),
              onSelect: (Country country) {
                widget.onCountrySelected(country);

                setState(() {
                  isSelecting = false;
                });
              },
              onClosed: () {
                setState(() {
                  isSelecting = false;
                });
              },
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.selectedCountry == null
                    ? ""
                    : widget.selectedCountry!.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: context.theme.textColor1,
                ),
              ),
              const Spacer(),
              Svg(
                "arrow_down.svg",
                size: 24,
                color: isSelecting
                    ? context.theme.textFieldActiveColor
                    : context.theme.textFieldInactiveColor,
              ),
            ],
          ),
        ),
        const SizedBox(height: 3),
        Divider(
          thickness: 1,
          color: isSelecting
              ? context.theme.textFieldActiveColor
              : context.theme.textFieldInactiveColor,
        ),
      ],
    );
  }
}
