import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rshb_test_task/pages/home.dart';
import 'package:rshb_test_task/pages/initialization.dart';
import 'package:rshb_test_task/providers/catalog.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => CatalogProvider(),
    child: Application(),
  ));
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: <String, WidgetBuilder>{
          'init': (BuildContext context) => InitializationPage(),
          //'productDetail': (BuildContext context) => ProductDetailPage(),
        },
        home: Provider.of<CatalogProvider>(context, listen: false).isLoaded
            ? HomePage()
            : FutureBuilder(
                future: Provider.of<CatalogProvider>(context, listen: false)
                    .loadFromAssets('assets/data/sample.json'),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return HomePage();
                  }
                  return InitializationPage();
                }),
        theme: ThemeData(
            fontFamily: 'SFPro',
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
                textTheme: TextTheme(
                    headline6: TextStyle(
                        fontFamily: 'SFPro',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20))),
            primaryColor: Colors.white,
            secondaryHeaderColor: Colors.white));
  }
}
