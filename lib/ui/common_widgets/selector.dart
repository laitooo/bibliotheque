import 'package:flutter/material.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    Key? key,
    required this.onChanged,
    required this.quantity,
  }) : super(key: key);

  final void Function(int quantity) onChanged;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildControlButton(context, Icons.add, 1, 5),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
          width: 30,
          child: Center(
            child: Text(
              '$quantity',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: context.theme.primaryColor,
              ),
            ),
          ),
        ),
        _buildControlButton(context, Icons.remove, -1, 5),
      ],
    );
  }

  Widget _buildControlButton(
      BuildContext context, IconData icon, int changeBy, int minAmount) {
    return Material(
      type: MaterialType.circle,
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          if (quantity == 0 && changeBy > 0) {
            onChanged(minAmount);
            return;
          }

          if (quantity == minAmount && changeBy < 0) {
            onChanged(0);
            return;
          }

          var newQuantity = quantity + changeBy;
          if (newQuantity < 0) {
            newQuantity = 0;
          }
          if (quantity == newQuantity) {
            return;
          }
          onChanged(newQuantity);
        },
        child: Container(
          height: 32,
          width: 32,
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.theme.backgroundColor,
            border: Border.all(
              color: context.theme.inActiveColor,
            ),
          ),
          child: Icon(
            icon,
            color: context.theme.iconColor1,
          ),
        ),
      ),
    );
  }
}
