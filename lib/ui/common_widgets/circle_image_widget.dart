import 'package:flutter/material.dart';

class CircleImageWidget extends StatelessWidget {
  final String image;
  final double size;

  const CircleImageWidget(this.image, {Key? key, this.size = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      child: CircleAvatar(
        backgroundImage: NetworkImage(
          image,
        ),
      ),
    );
  }
}
