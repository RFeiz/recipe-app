import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class CustomImage extends StatefulWidget {
  const CustomImage({super.key, required this.image, required this.skeleton});

  final NetworkImage image;
  final Widget skeleton;

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = true;
    widget.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, call) {
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        },
      ),
    );

    return Skeleton(
        isLoading: isLoading,
        skeleton: widget.skeleton,
        child: Image(image: widget.image));
  }
}
