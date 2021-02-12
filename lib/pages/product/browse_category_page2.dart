part of '../pages.dart';

List sort = [
  '0xFFCF6679',
  '0xFF223263',
  '0xFFCF6679',
];

class BrowserCategoryPage2 extends StatefulWidget {
  final subCategory;
  const BrowserCategoryPage2({Key key, @required this.subCategory})
      : super(key: key);

  @override
  _BrowserCategoryPage2State createState() => _BrowserCategoryPage2State();
}

class _BrowserCategoryPage2State extends State<BrowserCategoryPage2> {
  var items = {'Items': []};
  var Reitems = {'Items': []};

  var filterItems = {'Items': []};

  int dateindex;
  bool showNotAvail = false;
  RangeValues _currentRangeValues = const RangeValues(0, 10000);
  TextEditingController filterFirstvalue = TextEditingController();
  double ffFirstValue = 0;
  double ffSecondValue = 1000;

  TextEditingController filterSecondvalue = TextEditingController();
  @override
  void initState() {
    super.initState();

    //print('browse subcategory');
    //print(widget.subCategory);

    widget.subCategory.forEach((subcategory) {
      items['Items'].addAll(subcategory['Items']);
      Reitems['Items'].addAll(subcategory['Items']);

    });
    //print(items);
    //print('sada');
  }

  int currentindex = 0;
  int sortindex = 0;
  @override
  Widget build(BuildContext context) {
    double Height = MediaQuery.of(context).size.height;
    double Width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Get.to(SearchPg());
            },
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SideInAnimation(
                2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 15.0),
                  child: Text(
                    'Select Category',
                    style: Theme.of(context).textTheme.headline4,
                  ).tr(),
                ),
              ),
              SideInAnimation(2,
                  child: Container(
                    width: double.infinity,
                    height: 110.0,
                    child: ListView.builder(
                      itemCount: widget.subCategory.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              //print(widget.subCategory[index]['Items']);
                              setState(() {
                                dateindex = index;
                                items = {'Items': []};
                                items['Items']
                                    .addAll(widget.subCategory[index]['Items']);
                                if (items['Items'].length == 0) {
                                  showNotAvail = true;
                                }

                                // Or
                                // items['Items'].clear();
                                //print(items);
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
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
                                          imageUrl: widget.subCategory[index]
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
                                      widget.subCategory[index]['Name'],
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ).tr(),
                                  ],
                                ),
                              ),
                            ));
                      },
                    ),
                  )),
              // SideInAnimation(
              //   2,
              //   child: Align(
              //     alignment: Alignment.topLeft,
              //     child: Padding(
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 18.0, vertical: 18),
              //         child: Text(
              //           'Products',
              //           style: Theme.of(context).textTheme.headline3,
              //         ).tr(),
              //     ),
              //   ),
              // ),
              SideInAnimation(
                2,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 18),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Products',
                              style: Theme.of(context).textTheme.headline3,
                            ).tr(),
                            IconButton(
                              icon: Icon(
                                FlutterIcons.filter_fea,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.only(
                                            topLeft:
                                                const Radius.circular(23.0),
                                            topRight:
                                                const Radius.circular(23.0))),
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(builder:
                                          (BuildContext context,
                                              StateSetter state) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          decoration: new BoxDecoration(
                                              borderRadius:
                                                  new BorderRadius.only(
                                                      topLeft:
                                                          const Radius.circular(
                                                              20.0),
                                                      topRight:
                                                          const Radius.circular(
                                                              20.0))),
                                          child: Column(children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 25.0,
                                                  horizontal: 18.0),
                                              child: Text(
                                                'Filter By Price',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ).tr(),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 18.0),
                                              height: 50.0,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: TextField(
                                                    cursorColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    obscureText: false,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2,
                                                    autocorrect: false,
                                                    onChanged: (text) {
                                                      print(
                                                          "First text field: $text");
                                                      ffFirstValue =
                                                          double.parse(text);
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          tr('filter.min'),
                                                      hintStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .subtitle2,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15.0),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        borderSide: BorderSide(
                                                          color: Theme.of(
                                                                  context)
                                                              .accentColor
                                                              .withOpacity(.4),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        borderSide: BorderSide(
//            color: kErrorColor,
                                                            ),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        borderSide: BorderSide(
//            color: kErrorColor,
                                                            ),
                                                      ),
                                                    ),
                                                  )),
                                                  SizedBox(width: 20),
                                                  Expanded(
                                                      child: TextField(
                                                    cursorColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    obscureText: false,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2,
                                                    autocorrect: false,
                                                    onChanged: (text) {
                                                      print(
                                                          "First text field: $text");
                                                      ffSecondValue =
                                                          double.parse(text);
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          tr('filter.max'),
                                                      hintStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .subtitle2,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15.0),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        borderSide: BorderSide(
                                                          color: Theme.of(
                                                                  context)
                                                              .accentColor
                                                              .withOpacity(.4),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        borderSide: BorderSide(
//            color: kErrorColor,
                                                            ),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        borderSide: BorderSide(
//            color: kErrorColor,
                                                            ),
                                                      ),
                                                    ),
                                                  )),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            SideInAnimation(
                                              4,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  color: Colors.transparent,
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                      color: Theme.of(context)
                                                          .primaryColor
                                                          .withOpacity(0.4),
                                                      blurRadius: 5,
                                                      offset: Offset(0, 5),
                                                    ),
                                                  ],
                                                ),
                                                child: RaisedButton(
                                                  onPressed: () {
                                                    filterItems['Items'] = [];

                                                    print(ffFirstValue);
                                                    print(ffSecondValue);
                                                    print(items['Items']);
                                                    print('end');

                                                    print(Reitems['Items']);
                                                    print(
                                                        items['Items'].length);

                                                    for (int i = 0;
                                                        i <
                                                            Reitems['Items']
                                                                .length;
                                                        i++) {
                                                      var current =
                                                      Reitems['Items'][i];
                                                      if (current['Price'] >=
                                                              ffFirstValue &&
                                                          current['Price'] <=
                                                              ffSecondValue) {
                                                        print(current);
                                                        // here i need to add current in items['Items'] but i need to clear all arrays also
                                                        filterItems['Items']
                                                            .add(current);
                                                      }
                                                    }
                                                    items['Items'] = [];

                                                    for (int i = 0;
                                                        i <
                                                            filterItems['Items']
                                                                .length;
                                                        i++) {
                                                      // here i need to add current in items['Items'] but i need to clear all arrays also
                                                      items['Items'].add(
                                                          filterItems['Items']
                                                              [i]);
                                                    }

                                                    print(
                                                        items['Items'].length);
                                                    setState(() {

                                                    });

                                                    Navigator.of(context).pop();
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  child: Center(
                                                    child: Text(
                                                      'Apply',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .copyWith(
                                                              color:
                                                                  kBackgroundLightColor),
                                                    ).tr(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        );
                                      });
                                    });
                              },
                            ),
                          ])),
                ),
              ),
              StaggeredGridView.countBuilder(
                itemCount: items['Items'].length,
                crossAxisCount: 4,
                staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                itemBuilder: (context, index) {
                  var product = items['Items'][index];
                  return FadeInAnimation(
                    index,
                    child: ProductCard2(
                      product: product,
                      isHorizontalList: false,
                    ),
                  );
                },
              ),

              showNotAvail
                  ? Center(
                      child: Container(
                        child: Text('No Products Available',
                            style: Theme.of(context).textTheme.subtitle1),
                      ),
                    )
                  : Container(),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
