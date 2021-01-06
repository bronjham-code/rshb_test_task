import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rshb_test_task/models/category.dart';
import 'package:rshb_test_task/models/product.dart';
import 'package:rshb_test_task/providers/catalog.dart';
import 'package:rshb_test_task/widgets/filter_tab_bar.dart';
import 'package:rshb_test_task/widgets/filter_tab_bar_item.dart';
import 'package:rshb_test_task/widgets/product_tile.dart';
import 'package:rshb_test_task/pages/product_detail.dart';

class ProductsPage extends StatefulWidget {
  final Orientation orientation;

  const ProductsPage({Key key, this.orientation}) : super(key: key);
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage>
    with AutomaticKeepAliveClientMixin {
  var _filters = List<int>();
  var _filtersList = List<FilterTabBarItem>();
  bool sortByPrice = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _filtersList.add(FilterTabBarItem(
        'Сортировать', 'assets/icons/sort_icon.svg',
        initState: sortByPrice,
        onPressed: (bool state) => setState(() => sortByPrice = state)));

    Provider.of<CatalogProvider>(context, listen: false)
        .categories
        .forEach((ProductCategory category) {
      _filtersList.add(FilterTabBarItem(category.title, category.assetFilePath,
          initState: _filters.contains(category.id),
          onPressed: (bool state) => _filterChanged(category.id, state)));
    });
    super.initState();
  }

  void _filterChanged(int categoryId, bool state) => setState(() {
        if (_filters.contains(categoryId)) {
          _filters.remove(categoryId);
        } else {
          _filters.add(categoryId);
        }
      });

  Widget build(BuildContext context) {
    super.build(context);

    return CustomScrollView(key: PageStorageKey('products'), slivers: [
      FilterTabBar(filterItems: _filtersList),
      SliverPadding(
        padding: EdgeInsets.all(16),
        sliver: FutureBuilder(
            future: Provider.of<CatalogProvider>(context, listen: false)
                .products(filterByCategory: _filters, sortByPrice: sortByPrice),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SliverGrid.count(
                  childAspectRatio: (MediaQuery.of(context).size.width /
                          (widget.orientation == Orientation.portrait
                              ? 2
                              : 3)) /
                      335,
                  crossAxisCount:
                      widget.orientation == Orientation.portrait ? 2 : 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: List<Widget>.generate(
                      snapshot.data.length,
                      (int i) => ProductTile(
                            (snapshot.data as List<Product>)[i],
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ProductDetailPage((snapshot.data
                                            as List<Product>)[i]))),
                          )),
                );
              }
              return SliverToBoxAdapter(
                  child: Center(
                child: Container(
                  height: 30,
                  width: 30,
                  margin: EdgeInsets.all(10),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              ));
            }),
      )
    ]);
  }
}
