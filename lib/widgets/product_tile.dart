import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rshb_test_task/models/product.dart';
import 'package:rshb_test_task/providers/catalog.dart';
import 'package:rshb_test_task/utils.dart';
import 'package:rshb_test_task/widgets/favorite_button.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final Function onPressed;

  const ProductTile(this.product, {Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      child: Ink(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE0E0E0))),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                //Image
                Ink(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      image: DecorationImage(
                        image: AssetImage(product.image),
                        fit: BoxFit.fitHeight,
                      )),
                ),
                //Favorite Button
                Consumer<CatalogProvider>(
                    builder: (BuildContext context, CatalogProvider catalog,
                            Widget child) =>
                        FavoriteButton(
                          state: catalog.isFavorite(product.id),
                          margin: EdgeInsets.all(10),
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                          onPressed: () => catalog.setFavorite(product.id),
                        ))
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Title
                  Container(
                    child: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: product.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' / ' + product.unit,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                  ),
                  //Mark
                  Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          //Average mark
                          Container(
                            width: 25,
                            height: 20,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: (3 > product.totalRating)
                                    ? Color(0xFFBDBDBD)
                                    : (4 > product.totalRating)
                                        ? Color(0xFFD7A50C)
                                        : Color(0xFF42AB44),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                                child: Text(
                              //Replace 4.0 to var
                              (product.totalRating != 0)
                                  ? product.totalRating.toString()
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
                                Utils.ratingCountToString(product.ratingCount),
                                style: TextStyle(
                                    color: const Color(0xFF969696),
                                    fontSize: 12),
                              ))
                        ],
                      )),
                  //Short description
                  Container(
                      padding: EdgeInsets.only(top: 6),
                      child: Text(
                        product.shortDescription,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: const Color(0xFF969696), fontSize: 12),
                      )),
                  //Farmer title
                  Container(
                      padding: EdgeInsets.only(top: 6),
                      child: Text(
                        Provider.of<CatalogProvider>(context, listen: false)
                            .farmerById(product.farmerId)
                            .title,
                        style: TextStyle(fontSize: 12),
                      )),
                  //Price
                  Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        '${product.price} ₽',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            )
          ])),
      onTap: onPressed,
    );
  }
}
