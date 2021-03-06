import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imgUrl;
  final double? width;
  final double? height;
  final double placeHolderSize;
  final BoxFit fit;

  const CustomNetworkImage({
    Key? key,
    required this.imgUrl,
    this.width,
    this.height,
    required this.placeHolderSize,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      width: width,
      height: height,
      fit: fit,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 300),
      placeholder: (context, url) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: placeHolderSize,
              height: placeHolderSize,
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: placeHolderSize,
              height: placeHolderSize,
              child: const Icon(Icons.motion_photos_off_outlined),
            ),
          ),
        );
      },
    );
  }
}
