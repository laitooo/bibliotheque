import 'package:bibliotheque/features.dart';
import 'package:flutter/material.dart';

class CircleImageWidget extends StatelessWidget {
  final String image;
  final double size;

  const CircleImageWidget(this.image, {Key? key, this.size = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO:// handle no avatar url
    return SizedBox(
      width: size,
      height: size,
      child: CircleAvatar(
        backgroundImage: getImageProvider(
          image,
        ),
        radius: size,
      ),
    );
  }

  ImageProvider<Object>? getImageProvider(String image) {
    if (Features.isMockImages) {
      return const AssetImage("assets/mock/avatar.png");
    } else {
      return NetworkImage(image);
    }
  }
}
