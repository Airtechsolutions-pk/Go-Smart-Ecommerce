part of '../pages.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  var items = {'Items': []};
  bool show = false;
  @override
  void initState() {
    dosomestuff();
  }

  Future<List> dosomestuff() async {
    //print(WishList.wishlistArray);
    http.Response res = await http.get(
      'http://retailapi.airtechsolutions.pk/api/menu/2112',
    );

    Map<String, dynamic> map = json.decode(res.body);

    if (map['description'] == "Success") {
      //print('show kr ');

      List<dynamic> data = map["Categories"];
      data.forEach(
        (category) {
          if (category['Subcategories'] != null) {
            category['Subcategories'].forEach((subcategory) {
              final itemsToAdd = subcategory['Items'];
              final filteredItemsToAdd = itemsToAdd
                  .where((item) => WishList.wishlistArray.contains(item['ID']));
              items['Items'].addAll(filteredItemsToAdd);
            });
          }
        },
      );

      //print(items['Items']);
      setState(() {
        show = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'product.favoriteproduct',
          style: Theme.of(context).textTheme.headline4,
        ).tr(),
      ),
      body: Container(
          child: show
              ? StaggeredGridView.countBuilder(
                  itemCount: show ? items['Items'].length : 0,
                  crossAxisCount: 4,
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 15.0,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  itemBuilder: (context, index) {
                    var product = show ? items['Items'][index] : null;
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
                )),
    );
  }
}
