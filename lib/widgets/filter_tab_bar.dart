import 'package:flutter/material.dart';
import 'package:rshb_test_task/widgets/filter_tab_bar_item.dart';
import 'package:rshb_test_task/sliver_header_delegate.dart';

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
      delegate: CustomSliverHeaderDelegate(
          child: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: filterItems,
            )),
      )),
    );
  }
}
