import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rshb_test_task/custom_scroll_behavior.dart';
import 'package:rshb_test_task/pages/agriTours.dart';
import 'package:rshb_test_task/pages/farmers.dart';
import 'package:rshb_test_task/pages/products.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<String> tabs;
  TabController tabController;

  @override
  void initState() {
    tabs = ['Продукты', 'Фермеры', 'Агротуры'];
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.index = 0;
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Каталог'),
        ),
        //Hide scroll glowing
        body: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: OrientationBuilder(
                builder: (BuildContext context, Orientation orientation) =>
                    NestedScrollView(
                        floatHeaderSlivers: true,
                        headerSliverBuilder: (BuildContext context,
                                bool isScrolled) =>
                            [
                              //TabBar for category
                              SliverToBoxAdapter(
                                  child: Container(
                                      color: Colors.white,
                                      child: Container(
                                          height: 50,
                                          padding: const EdgeInsets.all(5),
                                          margin: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: TabBar(
                                              controller: tabController,
                                              indicatorPadding: EdgeInsets.zero,
                                              labelPadding: EdgeInsets.zero,
                                              labelColor: Colors.white,
                                              unselectedLabelColor:
                                                  Colors.black,
                                              indicatorSize:
                                                  TabBarIndicatorSize.label,
                                              indicator: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Colors.green),
                                              tabs: List<Tab>.generate(
                                                  tabs.length,
                                                  (int i) => Tab(
                                                          child: Container(
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(tabs[i],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      )))))))
                            ],
                        body: TabBarView(
                          controller: tabController,
                          //Disable scrollable view
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            //Content of product category
                            ProductsPage(orientation: orientation),
                            //Content of farmers category
                            FarmersPage(),
                            //Content of agrotours category
                            AgriToursPage(),
                          ],
                        )))));
  }
}
