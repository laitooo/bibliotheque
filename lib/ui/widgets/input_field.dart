import 'package:bibliotheque/blocs/theme_bloc.dart';
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
    widget.controller.text = widget.label;
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
          keyboardType: widget.inputType ?? TextInputType.name,
          focusNode: focusNode,
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
    widget.controller.text = widget.label;
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
              icon: Icon(
                isPasswordVisible
                    ? Icons.remove_red_eye_outlined
                    : Icons.remove_red_eye_sharp,
                size: 16,
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
  final DateTime currentTime;
  final void Function(DateTime dateTime) onDateSelected;

  const AppDateSelector({
    Key? key,
    required this.label,
    required this.onDateSelected,
    required this.currentTime,
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
              initialDate: DateTime(2000), //get today's date
              firstDate: DateTime(
                  1900), //DateTime.now() - not to allow to choose before today.
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
              Text(
                widget.currentTime.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: context.theme.textColor1,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: isSelecting
                    ? context.theme.textFieldActiveColor
                    : context.theme.textFieldInactiveColor,
              )
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
  final String selectedCountry;
  final void Function(Country country) onCountrySelected;

  const AppCountrySelector({
    Key? key,
    required this.label,
    required this.selectedCountry,
    required this.onCountrySelected,
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
                  prefixIcon: const Icon(Icons.search),
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
                widget.selectedCountry.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: context.theme.textColor1,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.keyboard_arrow_down_sharp,
                size: 24,
                color: isSelecting
                    ? context.theme.textFieldActiveColor
                    : context.theme.textFieldInactiveColor,
              )
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
