import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgPicture extends StatelessWidget {
  const CustomSvgPicture({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.withColorFilter = true,
    this.isLogOut = false,
  });

  const CustomSvgPicture.withoutColor({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.isLogOut = false,
  }) : withColorFilter = false;

  final String path;
  final bool withColorFilter;
  final double? height;
  final double? width;
  final bool isLogOut;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      colorFilter: withColorFilter
          ? ColorFilter.mode( isLogOut?
        Theme.of(context).colorScheme.error: Theme.of(context).colorScheme.onSurface,
        BlendMode.srcIn,
      )
          : null,
    );
  }

}
