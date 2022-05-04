import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imgUrl;
  final double? width;
  final double? height;
  final double placeHolderSize;

  const CustomNetworkImage({
    Key? key,
    required this.imgUrl,
    this.width,
    this.height,
    required this.placeHolderSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      width: width,
      height: height,
      fadeInDuration: const Duration(milliseconds: 200),
      fadeOutDuration: const Duration(milliseconds: 200),
      placeholder: (context, url) {
        return Center(
          child: SizedBox(
            width: placeHolderSize,
            height: placeHolderSize,
            child: const CircularProgressIndicator(),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Center(
          child: SizedBox(
            width: placeHolderSize,
            height: placeHolderSize,
            child: const Icon(Icons.motion_photos_off_outlined),
          ),
        );
      },
    );
  }
}
