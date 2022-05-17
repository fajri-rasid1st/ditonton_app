import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomInformation extends StatelessWidget {
  final String asset;
  final String title;
  final String subtitle;
  final Widget? child;

  const CustomInformation({
    Key? key,
    required this.asset,
    required this.title,
    required this.subtitle,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(
              asset,
              width: 240,
              fit: BoxFit.fill,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: kHeading6,
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: kBodyText.copyWith(color: kDavysGrey),
            ),
            const SizedBox(height: 16),
            if (child != null) ...[child!]
          ],
        ),
      ),
    );
  }
}
