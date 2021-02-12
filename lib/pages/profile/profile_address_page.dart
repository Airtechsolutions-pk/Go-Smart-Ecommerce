part of '../pages.dart';

class ProfileAddressPage extends StatefulWidget {
  @override
  _ProfileAddressPageState createState() => _ProfileAddressPageState();
}

class _ProfileAddressPageState extends State<ProfileAddressPage> {
  var address = {'Address': []};
  bool showAddress = false;
  var addressSelected;
  @override
  void initState() {
    setState(() {
      getAddress();
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'profile.savedaddress',
          style: Theme.of(context).textTheme.headline4,
        ).tr(),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Get.to(ProfileAddAddressPage());
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        child: showAddress ? ListView.builder(
          itemCount: address['Address'].length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          itemBuilder: (context, index) {
            return SideInAnimation(
              index,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(15.0),
                margin: EdgeInsets.only(bottom: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Theme.of(context).accentColor,
                    width:  1.0,
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
                        SizedBox(
                          width: 80.0,
                          child: RaisedButtonWidget(
                            title: 'product.edit',
                            onPressed: () {
                              Get.to(ProfileEditAddress(address: address['Address'][index]));
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => EditAddressPage(address: address['Address'][index]))).then((value) {
                              //   if (value == true) {
                              //     setState(() {
                              //     });
                              //   }
                              // });
                              // Navigator.push(context, EditAddressPage(address: address['Address'][index])).then((result) => setState(() {}));

                            },
                          ),
                        ),
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
            );
          },
        ) : Center(
          child: const SpinKitWave(color: kPrimaryColor, type: SpinKitWaveType.center),
        ),
      ),
    );
  }

  onItemSelected(int index) {
    setState(() {});
  }
}
