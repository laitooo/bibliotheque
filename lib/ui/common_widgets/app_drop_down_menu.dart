import 'package:bibliotheque/blocs/theme.dart';
import 'package:flutter/material.dart';

class AppDropDownMenu<T> extends StatefulWidget {
  final String hintText;
  final List<T> items;
  final Function? onChanged;
  final bool removePadding;
  final Function itemBuilder;
  final T? initialValue;

  const AppDropDownMenu({
    Key? key,
    required this.hintText,
    required this.items,
    this.onChanged,
    this.removePadding = true,
    required this.itemBuilder,
    this.initialValue,
  }) : super(key: key);

  @override
  AppDropDownMenuState createState() => AppDropDownMenuState();
}

class AppDropDownMenuState<T> extends State<AppDropDownMenu> {
  T? value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: widget.removePadding ? 0 : 20,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: context.theme.dropDownBackgroundColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: context.theme.borderColor,
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          dropdownColor: context.theme.dropDownBackgroundColor,
          hint: Text(
            widget.hintText,
            style: TextStyle(
              color: context.theme.dropDownTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          icon: Row(
            children: [
              getClearIcon(),
              const SizedBox(
                width: 5,
              ),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 20,
                color: context.theme.dropDownIconColor,
              ),
            ],
          ),
          items: widget.items.map((item) {
            return DropdownMenuItem<T>(
                value: item, child: (widget.itemBuilder(item)) as Widget);
          }).toList(),
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget getClearIcon() {
    if (value == null || widget.items.isEmpty) {
      return Container();
    }
    return GestureDetector(
      onTap: clearValue,
      child: Icon(
        Icons.clear,
        size: 15,
        color: context.theme.dropDownIconColor,
      ),
    );
  }

  void onChanged(T? newValue) {
    update(newValue);
  }

  void clearValue() {
    update(null);
  }

  void update(T? newValue) {
    widget.onChanged?.call(newValue);
    setState(() {
      value = newValue;
    });
  }
}
