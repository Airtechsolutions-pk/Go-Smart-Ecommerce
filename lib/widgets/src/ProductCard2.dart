part of '../widgets.dart';


class ProductCard2 extends StatefulWidget {
  final product;
  final bool isHorizontalList;
  const ProductCard2(
      {Key key, @required this.product, @required this.isHorizontalList})
      : super(key: key);

  @override
  _ProductCard2State createState() => _ProductCard2State();
}

class _ProductCard2State extends State<ProductCard2> {
  bool heart = false;



  @override
  Widget build(BuildContext context) {

    if(WishList.wishlistArray.contains(widget.product['ID'])){
       setState(() {
         heart = true;
       });
    }

    double statusBarHeight = MediaQuery.of(context).padding.top;
    double Height = MediaQuery.of(context).size.height;
    double Width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(right: widget.isHorizontalList ? 15.0 : 0.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () {
          //print(widget.product);
          Get.to(ProductDetailPage2(product: widget.product));
        },
        child: Container(
          width: 150.0,
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),

                    child: Container(
                      color: kCardImageBCColor,

                      child: CachedNetworkImage(
                        imageUrl:
                        widget.product['Image'],
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                        height: Height * 0.2,
                      ),
                    ),
                    // child: Image.asset(
                    //   product.image,
                    //   height: 150.0,
                    //   fit: BoxFit.cover,
                    //   width: double.infinity,
                    // ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.product['Name'],
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 3.0),
                  Row(
                    children: [
                      Text(
                        "$priceGlobal${widget.product['Price']}",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 5.0),

                    ],
                  ),

                  SizedBox(height: 5.0),
                ],
              ),

              Positioned(
                right: 0.0,
                top: 0.0,
                child: IconButton(
                  icon: Icon(
                    heart ? Icons.favorite : Icons.favorite_border,
                    color: kPrimaryColor,
                    size: 22.0,
                  ),
                  onPressed: () {
                    //print(widget.product['ID']);


                    if(WishList.wishlistArray.contains(widget.product['ID'])){
                      WishList.wishlistArray.removeWhere((item) => item == widget.product['ID']);
                      //print(WishList.wishlistArray);
                      setState(() {
                        heart = false;

                      });
                    }
                    else{
                      WishList.wishlistArray.add(widget.product['ID']);
                      //print(WishList.wishlistArray);
                    }
                    setState(() {

                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
