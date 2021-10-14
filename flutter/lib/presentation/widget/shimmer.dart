import 'package:flutter/material.dart';
import 'package:manpro/config/app.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  ShimmerLoading({this.width, this.height});
  final double width, height;

  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Shimmer.fromColors
        (
          baseColor: Colors.grey.withOpacity(0.7),
          highlightColor: Colors.grey.withOpacity(0.2),
          child: Container(width: 100, height: 17, color: accentColor.withOpacity(0.2)
        )
      )
    );
  }
}