import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rshb_test_task/models/product.dart';
import 'package:rshb_test_task/providers/catalog.dart';
import 'package:rshb_test_task/widgets/characteristic_list.dart';
import 'package:rshb_test_task/widgets/favorite_button.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage(this.product, {Key key}) : super(key: key);
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (BuildContext context,
                    bool innerBoxIsScrolled) =>
                <Widget>[
                  SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverAppBar(
                        forceElevated: innerBoxIsScrolled,
                        title: innerBoxIsScrolled
                            ? _titleWidget(
                                widget.product.title, widget.product.unit)
                            : Container(),
                        leading: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              margin: EdgeInsets.all(5),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                      color: innerBoxIsScrolled
                                          ? Colors.transparent
                                          : const Color(0xFFE0E0E0))),
                              child: Icon(Icons.arrow_back),
                            )),
                        actions: [
                          Consumer<CatalogProvider>(
                              builder: (BuildContext context,
                                      CatalogProvider catalog, Widget child) =>
                                  SizedBox(
                                    height: 40,
                                    width: 57,
                                    child: FavoriteButton(
                                      isSmall: false,
                                      state:
                                          catalog.isFavorite(widget.product.id),
                                      margin: EdgeInsets.all(5),
                                      border: innerBoxIsScrolled
                                          ? null
                                          : Border.all(
                                              color: const Color(0xFFE0E0E0)),
                                      onPressed: () => catalog
                                          .setFavorite(widget.product.id),
                                    ),
                                  )),
                        ],
                        expandedHeight: 250.0,
                        floating: false,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.pin,
                            background: Stack(fit: StackFit.expand, children: [
                              Image.asset(
                                widget.product.image,
                                fit: BoxFit.cover,
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  height: 32,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: //Title
                                      Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 6),
                                    child: _titleWidget(widget.product.title,
                                        widget.product.unit),
                                  ),
                                ),
                              ),
                            ])),
                      ))
                ],
            body: SingleChildScrollView(
                padding:
                    EdgeInsets.only(top: 78, left: 16, right: 16, bottom: 20),
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //Mark
                        Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                //Average mark
                                Container(
                                  width: 25,
                                  height: 20,
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: (3 > 4)
                                          ? Color(0xFFBDBDBD)
                                          : (4 > 4)
                                              ? Color(0xFFD7A50C)
                                              : Color(0xFF42AB44),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text(
                                    //Replace 4.0 to var
                                    (widget.product.totalRating != 0)
                                        ? widget.product.totalRating.toString()
                                        : '-',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                                //Total mark count
                                Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      //Replace 31 to var
                                      (31 > 0)
                                          ? 31.toString() +
                                              ([0, 5, 6, 7, 8, 9]
                                                      .contains(31 % 10)
                                                  ? ' оценок'
                                                  : [2, 3, 4].contains(31 % 10)
                                                      ? ' оценки'
                                                      : ' оценка')
                                          : 'Нет оценок',
                                      style: TextStyle(
                                          color: const Color(0xFF969696),
                                          fontSize: 12),
                                    ))
                              ],
                            )),
                        //Price
                        Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              '${widget.product.price} ₽',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                        //Description
                        Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              widget.product.description,
                              style: TextStyle(
                                  color: const Color(0xFF969696), fontSize: 16),
                            )),
                        //Characteristics
                        Container(
                            padding: EdgeInsets.only(top: 20),
                            child: CharacteristicList(
                                widget.product.characteristicsList))
                      ],
                    )))));
  }

  Widget _titleWidget(String title, String unit) => Container(
        child: RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: title,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                  text: ' / ' + unit,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      );
}
