import 'package:flutter/material.dart';

class CustomSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  CustomSliverHeaderDelegate({this.child});

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      child;

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
