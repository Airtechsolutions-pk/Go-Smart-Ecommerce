part of '../pages.dart';

class allProducts extends StatefulWidget {
  @override
  _allProductsState createState() => _allProductsState();
}

class _allProductsState extends State<allProducts> {
  var items = {'Items': []};
  var proDitems = {'Items': []};
  var reproDitems = {'Items': []};

  var cat = {'Cat': []};
  int selectedIndex = 0;

  bool show = false;
  @override
  void initState() {
    dosomestuff();
  }

  Future<List> dosomestuff() async {
    Map<String, dynamic> map = json.decode(globalArray.globalArrayData);

    if (map['description'] == "Success") {
      //print('show kr ');

      List<dynamic> data = map["Categories"];
      cat['Cat'].addAll(map['Categories']);

      data.forEach((category) {
        if (category['Subcategories'] != null) {
          items['Items'].addAll(category['Subcategories']);
        }
      });

      data.forEach((category) {
        if (category['Subcategories'] != null) {
          category['Subcategories'].forEach((subcategory) {
            proDitems['Items'].addAll(subcategory['Items']);
            reproDitems['Items'].addAll(subcategory['Items']);
          });
        }
      });

      print('as222');
      print(items['Items']);
      setState(() {
        show = true;
      });
    }
  }

  void navigateToBrowsePage() {
    Get.to(BrowseProductPage());
  }

  navigateToBrowseCategory() {
    Get.to(BrowseCategoryPage());
  }

  navigateToBrowseCategory2() {
    Get.to(BrowserCategoryPage2());
  }

  void navigateToNotificationPage() {
    Get.to(NotificationPage());
  }

  void navigateToSearchPg2() {
    Get.to(SearchPgExtra());
  }

  void navigateToProductDetailPage(Product product) {
    Get.to(ProductDetailPage(product: product));
  }

  navigateToBrowseByNewProduct() {
    Get.to(BrowseProductPage());
  }

  navigateToBrowseByCategory() {
    Get.to(BrowseProductPage());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double Height = MediaQuery.of(context).size.height;
    double Width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'All Categories',
            style: Theme.of(context).textTheme.headline4,
          ).tr(),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                FlutterIcons.search_mdi,
              ),
              onPressed: navigateToSearchPg2,
            ),
            IconButton(
              icon: Icon(
                FlutterIcons.notifications_none_mdi,
              ),
              onPressed: navigateToNotificationPage,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Column(
              children: [

                show
                    ? SideInAnimation(2,
                        child: Container(
                          width: double.infinity,
                          height: Height * 0.13,
                          child: ListView.builder(
                            itemCount: cat["Cat"].length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: GestureDetector(
                                    onTap: () {
                                      //print(cat["Cat"][index]['Subcategories']);
                                      // Get.to(BrowserCategoryPage2(
                                      //     subCategory: cat["Cat"][index]
                                      //     ['Subcategories']));
                                      items = {'Items': []};
                                      items['Items'].addAll(
                                          cat["Cat"][index]['Subcategories']);
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 80.0,
                                      child: Column(
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100.0),

                                            child: Container(
                                              color: kCardImageBCColor,
                                              width: 60,
                                              height: 60,
                                              child: CachedNetworkImage(
                                                imageUrl: cat["Cat"][index]
                                                    ['Image'],
                                                width: double.infinity,
                                                fit: BoxFit.fitWidth,
                                                height: Height * 0.1,
                                              ),
                                            ),
                                            // child: Image.asset(
                                            //   product.image,
                                            //   height: 150.0,
                                            //   fit: BoxFit.cover,
                                            //   width: double.infinity,
                                            // ),
                                          ),
                                          SizedBox(height: 12.0),
                                          Text(
                                            show
                                                ? cat["Cat"][index]['Name']
                                                : 'Loading',
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          ).tr(),
                                        ],
                                      ),
                                    )),
                              );
                            },
                          ),
                        ))
                    : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SpinKitDoubleBounce(color: kPrimaryColor),
                            const SpinKitDoubleBounce(color: kPrimaryColor),
                            const SpinKitDoubleBounce(color: kPrimaryColor),
                            const SpinKitDoubleBounce(color: kPrimaryColor),
                            const SpinKitDoubleBounce(color: kPrimaryColor),
                          ],
                        ),
                      ),
              ],
            ),
            Column(
              children: [
                // SideInAnimation(
                //   2,
                //   child: Align(
                //     alignment: Alignment.topLeft,
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 18.0),
                //       child: Text(
                //         'Sub Categories',
                //         style: Theme.of(context).textTheme.headline3,
                //       ).tr(),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 15.0),
                show
                    ? SideInAnimation(2,
                        child: Container(
                          width: double.infinity,
                          color: Color(0xfff7f7f7),
                          height: Height * 0.05,
                          child: ListView.builder(

                            itemCount: items['Items'].length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: GestureDetector(
                                      onTap: () {
                                        //print(cat["Cat"][index]['Subcategories']);
                                        // Get.to(BrowserCategoryPage2(
                                        //     subCategory: cat["Cat"][index]
                                        //     ['Subcategories']));
                                        setState(() {
                                          selectedIndex = index;
                                          print(index);
                                          proDitems = {'Items': []};
                                          proDitems['Items'].addAll(items['Items'][index]['Items']);

                                        });
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Container(
                                            // width: 100.0,
                                            child: Center(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,

                                                  children: <Widget>[
                                                // SizedBox(height: 12.0),
                                                Text(
                                                  show
                                                      ? items['Items'][index]
                                                          ['Name']
                                                      : 'Loading',
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    color: selectedIndex == index
                                                        ? kPrimaryColor
                                                        : kSecondaryDarkFontColor,
                                                    fontSize:
                                                        selectedIndex == index
                                                            ? 13.0
                                                            : 12.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ).tr(),
                                                selectedIndex == index
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                top: 3),
                                                        child: Container(
                                                          width: 8,
                                                          height: 8,
                                                          decoration: BoxDecoration(
                                                              shape:
                                                                  BoxShape.circle,
                                                              color:
                                                                  kPrimaryColor),
                                                        ))
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                top: 3),
                                                        child: Container(
                                                          width: 8,
                                                          height: 8,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ))
                                              ],
                                            )),
                                          ))),
                                ),
                              );
                            },
                          ),
                        ))
                    : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SpinKitDoubleBounce(color: kPrimaryColor),
                            const SpinKitDoubleBounce(color: kPrimaryColor),
                            const SpinKitDoubleBounce(color: kPrimaryColor),
                            const SpinKitDoubleBounce(color: kPrimaryColor),
                            const SpinKitDoubleBounce(color: kPrimaryColor),
                          ],
                        ),
                      ),
              ],
            ),
            SizedBox(height: 15.0),

            show
                ? StaggeredGridView.countBuilder(
                    itemCount: show ? proDitems['Items'].length : 0,
                    crossAxisCount: 4,
                    staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 15.0,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    itemBuilder: (context, index) {
                      var product = show ? proDitems['Items'][index] : null;
                      return FadeInAnimation(
                        index,
                        child: ProductCard2(
                          product: product,
                          isHorizontalList: false,
                        ),
                      );
                    },
                  )
                : StaggeredGridView.countBuilder(
                    itemCount: 4,
                    crossAxisCount: 4,
                    staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 15.0,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    itemBuilder: (context, index) {
                      return Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: SpinKitDoubleBounce(color: kPrimaryColor));
                    },
                  ),
            SizedBox(height: 25.0),
          ]),
        ));
  }
}
