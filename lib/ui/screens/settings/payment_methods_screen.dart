import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment method'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          const SizedBox(height: 15),
          _paymentMethod(
            context,
            "Paypal",
            Icons.payment,
            () {},
          ),
          const SizedBox(height: 15),
          Divider(
            thickness: 0.5,
            color: context.theme.dividerColor,
          ),
          const SizedBox(height: 15),
          _paymentMethod(
            context,
            "Google Pay",
            Icons.payment,
            () {},
          ),
          const SizedBox(height: 15),
          Divider(
            thickness: 0.5,
            color: context.theme.dividerColor,
          ),
          const SizedBox(height: 15),
          _paymentMethod(
            context,
            "Apple Pay",
            Icons.payment,
            () {},
          ),
          const SizedBox(height: 15),
          Divider(
            thickness: 0.5,
            color: context.theme.dividerColor,
          ),
          const SizedBox(height: 15),
          _paymentMethod(
            context,
            "Visa card",
            Icons.payment,
            () {},
          ),
          const SizedBox(height: 15),
          Divider(
            thickness: 0.5,
            color: context.theme.dividerColor,
          ),
          const SizedBox(height: 15),
          _paymentMethod(
            context,
            "Master Card",
            Icons.payment,
            () {},
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  _paymentMethod(BuildContext context, String title, IconData iconData,
      void Function() onClick) {
    return InkWell(
      onTap: onClick,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: context.theme.iconBackgroundColor,
            ),
            child: Icon(
              iconData,
              size: 25,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 20),
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: context.theme.textColor1,
              ),
            ),
          ),
          const Spacer(),
          Icon(
            Icons.chevron_right_sharp,
            color: context.theme.iconColor1,
            size: 20,
          ),
        ],
      ),
    );
  }
}
