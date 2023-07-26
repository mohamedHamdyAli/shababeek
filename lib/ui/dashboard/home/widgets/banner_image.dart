import 'package:flutter/material.dart';

class BannerImage extends StatefulWidget {
  const BannerImage();

  @override
  State<BannerImage> createState() => _BannerImageState();
}

class _BannerImageState extends State<BannerImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Image.asset(
          'assets/images/home_icon/Banner3.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
