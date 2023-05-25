import 'package:bibliotheque/features.dart';
import 'package:bibliotheque/utils/generator.dart';
import 'package:flutter/material.dart';

enum MockImageType {
  bookCover,
  category,
}

class MockableImage extends StatelessWidget {
  final String url;
  final MockImageType type;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const MockableImage(
    this.url, {
    Key? key,
    required this.type,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: getImageProvider(
        url,
        getMockImageAssetPath(type),
      ),
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
    );
  }

  ImageProvider<Object> getImageProvider(String image, String assetPath) {
    if (Features.isMockImages) {
      return AssetImage(assetPath);
    } else {
      return NetworkImage(image);
    }
  }

  getMockImageAssetPath(MockImageType type) {
    switch (type) {
      case MockImageType.bookCover:
        return "assets/mock/covers/" +
            generator.count(1, 7).toString() +
            ".png";
      case MockImageType.category:
        return "assets/mock/categories/" +
            generator.count(1, 5).toString() +
            ".jpg";
    }
  }
}
