import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class RangeSelector extends StatefulWidget {
  final double start;
  final double step;
  final double end;
  final double? initialStart;
  final double? initialEnd;
  final String quantityName;
  final Function(double min, double max)? onChanged;

  const RangeSelector({
    Key? key,
    required this.start,
    required this.step,
    required this.end,
    this.initialStart,
    this.initialEnd,
    required this.quantityName,
    this.onChanged,
  }) : super(key: key);

  @override
  _RangeSelectorState createState() => _RangeSelectorState();
}

class _RangeSelectorState extends State<RangeSelector> {
  late double value1;
  late double value2;

  @override
  void initState() {
    super.initState();
    value1 = widget.initialStart ?? widget.start;
    value2 = widget.initialEnd ?? widget.end;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 35),
      child: SfRangeSelector(
        min: widget.start,
        max: widget.end,
        initialValues: SfRangeValues(
          widget.initialStart ?? widget.start,
          widget.initialEnd ?? widget.end,
        ),
        interval: widget.step,
        stepSize: widget.step,
        dragMode: SliderDragMode.onThumb,
        enableDeferredUpdate: true,
        deferredUpdateDelay: 10,
        enableIntervalSelection: false,
        enableTooltip: false,
        onChanged: (value) {
          widget.onChanged?.call(value.start, value.end);
          setState(() {
            value1 = value.start;
            value2 = value.end;
          });
        },
        shouldAlwaysShowTooltip: true,
        child: Container(),
        inactiveColor: context.theme.inActiveColor,
        activeColor: context.theme.activeColor,
      ),
    );
  }
}
