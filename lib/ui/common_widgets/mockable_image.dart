import 'package:bibliotheque/features.dart';
import 'package:flutter/material.dart';

class MockableImage extends StatelessWidget {
  final String url;
  final String? assetPath;
  final double? width;
  final double? height;
  final BoxFit? fit;
  const MockableImage(this.url,
      {Key? key, this.assetPath, this.width, this.height, this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: getImageProvider(url, assetPath),
      width: width,
      height: height,
      fit: fit,
    );
  }

  ImageProvider<Object> getImageProvider(String image, [String? assetPath]) {
    if (Features.isMockImages) {
      return AssetImage(assetPath ?? "assets/mock/cover.png");
    } else {
      return NetworkImage(image);
    }
  }
}
