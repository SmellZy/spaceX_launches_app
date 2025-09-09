import 'package:flutter/widgets.dart';

class CarouselContainer extends StatelessWidget {
  const CarouselContainer({
    super.key,
    required this.screenWidth,
    required this.screenHeigh,
    required this.imageAsset,
  });

  final double screenWidth;
  final double screenHeigh;
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeigh * 0.35,
      width: screenWidth,
      child: Image.asset(imageAsset, fit: BoxFit.cover),
    );
  }
}
