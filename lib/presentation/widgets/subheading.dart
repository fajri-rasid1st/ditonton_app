import 'package:ditonton/common/constants.dart';
import 'package:flutter/material.dart';

class SubHeading extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const SubHeading({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 4, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: kHeading6,
          ),
          if (onTap != null) ...[
            InkWell(
              onTap: onTap,
              child: Row(
                children: const <Widget>[
                  Text('Show more'),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  ),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }
}
