import 'package:flutter/material.dart';
import 'package:rshb_test_task/widgets/filter_tab_bar_item.dart';

class FilterTabBar extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final List<FilterTabBarItem> filterItems;

  const FilterTabBar({Key key, this.margin, this.padding, this.filterItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: true,
      delegate: _SliverHeaderDelegate(
          child: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
            color: Colors.white,
            //margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: filterItems,
            )),
      )),
    );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  _SliverHeaderDelegate({this.child});

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
