part of '../pages.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  var address = {'Address': []};
  bool showAddress = false;
  int dateindex = 0;
  var addressSelected;
  bool showBtn = false;
  String _userID = "";
  num amount = 0;
  var items = [];

  @override
  void initState() {
    setState(() {
      getAddress();
      this._query();
    });
  }

  void _query() async {


    //print('cart');
    final dbHelper = DatabaseHelper.instance;

    var allRows = await dbHelper.queryAllRows();

    allRows.forEach((row) {
      items.add(

          {
            "ItemID": row['id'],
            "ItemName": row['title'],
            "Quantity": row['quantity'],
            "Price": row['price'],
            "Cost": 0,
            "StatusID": 1,
            "OrderDetailModifiers": [
              {
                "ModifierID": 0,
                "ModifierName": row['color'],
                "Quantity": 0,
                "Price": 0,
                "Cost": 0,
                "StatusID": 1
              },
              {
                "ModifierID": 0,
                "ModifierName": row['sizeselect'],
                "Quantity": 0,
                "Price": 0,
                "Cost": 0,
                "StatusID": 1
              }
            ]

          }
      );
      amount += double.parse(row['price']);
      //print(amount);
      //print(row);
      print(items);
    });
  }

  getAddress() async {
    final storage = new FlutterSecureStorage();

    String _userEmail = await storage.read(key: "_userEmail");
    String _userPassword = await storage.read(key: "_userPassword");
    String url =
        'http://retailapi.airtechsolutions.pk/api/customer/login/${_userEmail}/${_userPassword}';

    //print(url);
    http.Response res = await http.get(
      url,
    );
    var data = json.decode(res.body.toString());
    //print(data);

    if (data['description'].toString() == "Success") {
      //print(data['customer']['Addresses']);
      address['Address'].addAll(data['customer']['Addresses']);

      //print(address);

      setState(() {
        showAddress = true;
      });
      print(address['Address'].length);
      if (address['Address'].length == 0) {
        print('Yes showBtn');
        setState(() {
          showBtn = true;
        });

      } else {
        setState(() {
          showBtn = false;
        });        print('No showBtn');
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    onClick()async{
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(
                child: const SpinKitWave(color: kPrimaryColor, type: SpinKitWaveType.center));
          });


      final storage = new FlutterSecureStorage();

      Map<String, dynamic> body = {
        "CustomerID": await storage.read(key: "_userID"),
        "OrderType": "APP",
        "OrderDate": "2021-01-28",
        "StatusID": 2,
        "LocationID": 2112,
        "OrderCheckouts": {
          "PaymentMode": 1,
          "AmountPaid": amount,
          "AmountTotal": amount,
          "ServiceCharges": 0,
          "GrandTotal": 0,
          "Tax": 0,
          "CheckoutDate": "2021-01-28",
          "StatusID": 2
        },
        "OrderDetails": items
      };
      String jsonBody = json.encode(body);
      //print(jsonBody);

      final headers = {'Content-Type': 'application/json'};

      http.Response res = await http.post(
        'http://retailapi.airtechsolutions.pk/api/orders/new',
        headers: headers,

        body: jsonBody,
      );
      var data = json.decode(res.body.toString());
      //print(data);

      if(data['description'] == "Your order has been punched successfully."){
        Navigator.pop(context);
        final dbHelper = DatabaseHelper.instance;
        await dbHelper.deleteAll();
        showAlert(context);

        // Get.to(BottomNavigationBarPage());
      }
      else{
        Navigator.pop(context);

      }
    }

    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showAddress
                ? Flexible(
                    flex: 9,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.0),
                          Text(
                            'order.shippingaddress',
                            style: Theme.of(context).textTheme.headline4,
                          ).tr(),
                          SizedBox(height: 20.0),
                          ListView.builder(
                            itemCount: address['Address'].length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return SideInAnimation(
                                index,
                                child: GestureDetector(
                                  // onTap: widget.onPressed,
                                  onTap: () {
                                    setState(() {
                                      dateindex = index;
                                      addressSelected =
                                          address['Address'][index];
                                      //print(addressSelected);
                                    });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(15.0),
                                    margin: EdgeInsets.only(bottom: 15.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        color: dateindex == index
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context).accentColor,
                                        width: dateindex == index ? 2.0 : 1.0,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            showAddress
                                                ? address['Address'][index]
                                                    ['Address']
                                                : '...',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4),
                                        SizedBox(height: 8.0),
                                        Text(
                                            showAddress
                                                ? address['Address'][index]
                                                    ['Address']
                                                : '...',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1),
                                        SizedBox(height: 8.0),
                                        Text(
                                            showAddress
                                                ? address['Address'][index]
                                                    ['Address']
                                                : '...',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1),
                                        SizedBox(height: 8.0),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.edit_outlined),
                                              onPressed: () {
                                                Get.to(EditAddressPage(
                                                    address:
                                                    address['Address']
                                                    [index]));
                                              },
                                            ),
                                            // SizedBox(
                                            //   width: 80.0,
                                            //   child: RaisedButtonWidget(
                                            //     title: 'product.edit',
                                            //     onPressed: () {
                                            //       Get.to(EditAddressPage(
                                            //           address:
                                            //               address['Address']
                                            //                   [index]));
                                            //       // Navigator.push(context, MaterialPageRoute(builder: (context) => EditAddressPage(address: address['Address'][index]))).then((value) {
                                            //       //   if (value == true) {
                                            //       //     setState(() {
                                            //       //     });
                                            //       //   }
                                            //       // });
                                            //       // Navigator.push(context, EditAddressPage(address: address['Address'][index])).then((result) => setState(() {}));
                                            //     },
                                            //   ),

                                            SizedBox(width: 15.0),
                                            IconButton(
                                              icon: Icon(Icons.delete_outline),
                                              onPressed: () {
                                                // showDeleteConfirmation(context);
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 25.0),
                        ],
                      ),
                    ),
                  )
                : Container(),
            showBtn ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/undraw_Directions_re_kjxs.png',
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    'No Address Available',
                    style: Theme.of(context).textTheme.headline1,
                  ).tr(),
                  SizedBox(height: 15.0),
                  Text(
                    'Please add address so we can deliver. Happy Shopping  :)',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                ],
              ),
            ) : Container() ,
            showBtn ? Container() : Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 15.0),
                child: FadeInAnimation(
                  2,
                  child: RaisedButtonWidget(
                    title: 'order.next',
                    onPressed: (){
                      onClick();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  void navigateToPaymentPage() {
    Get.to(PaymentPage());
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'order.checkout',
        style: Theme.of(context).textTheme.headline4,
      ).tr(),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Get.to(AddAddressPage());
          },
        ),
      ],
    );
  }

  void showAlert(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: Dialog(
                backgroundColor: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
                    height: height * 0.5,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  child: Icon(
                                    Icons.done,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                  backgroundColor: Theme.of(context).primaryColor,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'order.success',
                                  style: Theme.of(context).textTheme.headline1,
                                ).tr(),
                                SizedBox(height: 12.0),
                                Text(
                                  'order.subtitlesuccess',
                                  style: Theme.of(context).textTheme.bodyText2,
                                  textAlign: TextAlign.center,
                                ).tr(),
                                SizedBox(height: 20),
                                RaisedButtonWidget(
                                    title: 'CLOSE',
                                    onPressed: () => Get.offAll(BottomNavigationBarPage())

                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 450),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

}
