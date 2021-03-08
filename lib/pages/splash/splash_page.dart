part of '../pages.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    dosomestuff();
  }

  Future<List> dosomestuff() async {
    print('run');
    http.Response res = await http.get(
      'http://retailapi.airtechsolutions.pk/api/settings/user/2170',
    );

    Map<String, dynamic> map = json.decode(res.body);
    print(map);
    print(map['Status']);
    if (int.parse(map['Status']) == 1) {
      print('aga chal');
      final storage = new FlutterSecureStorage();
      await storage.write(
          key: '_LocationID', value: map['LocationID'].toString());
      await storage.write(key: '_UserID', value: map['UserID'].toString());
      await storage.write(
          key: '_TaxPercentTaxPercent', value: map['TaxPercent']);
      await storage.write(
          key: '_DeliveryCharges', value: map['DeliveryCharges']);
      await storage.write(key: '_Currency', value: map['Currency']);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SplashWelcomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: kPrimaryColor,
        child: Stack(children: [
          Center(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  child: Image.asset('assets/icons/logo.png'))),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Image.asset(
                          'assets/images/Logo-Verticle-White-Square.png'))))
        ]));
    // return AnimatedSplashScreen(
    //   backgroundColor: kPrimaryColor,
    //   splash: 'assets/icons/logo.png',
    //   nextScreen: SplashWelcomePage(),
    //   splashTransition: SplashTransition.fadeTransition,
    //   pageTransitionType: PageTransitionType.fade,
    //   duration: 1500,
    //   animationDuration: Duration(milliseconds: 1500),
    // );
  }
}

class SplashWelcomePage extends StatefulWidget {
  @override
  _SplashWelcomePageState createState() => _SplashWelcomePageState();
}

class _SplashWelcomePageState extends State<SplashWelcomePage> {
  String _LocationID;
  String _UserID;

  void initState() {
    super.initState();
    dosomestuff();
  }

  Future<List> dosomestuff() async {
    final storage = new FlutterSecureStorage();
    _LocationID = await storage.read(key: "_LocationID");
    _UserID = await storage.read(key: "_UserID");
    print('API MENU');

    print(_LocationID);

    print(_UserID);
    http.Response res = await http.get(
      'http://retailapi.airtechsolutions.pk/api/menu/${_LocationID}/${_UserID}',
    );
    globalArray.globalArrayData = res.body;

    Map<String, dynamic> map = json.decode(res.body);

    if (map['description'] == "Success") {
      //print('show kr ');
      startTime();
    }
  }

  startTime() {
    Timer(
      Duration(milliseconds: 1000),
      () async {
        final storage = new FlutterSecureStorage();

        String board = await storage.read(key: "board");
        //print(board);
        if (board == "yes") {
          Get.offAll(BottomNavigationBarPage());

          //print('home pa bhejo');
        } else {
          //print('board pa bhejo');
          Get.offAll(
            OnBoardingPage(),
            // transition: Transition.topLevel,
            // duration: Duration(milliseconds: 2500),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const SpinKitWave(
            color: kPrimaryColor, type: SpinKitWaveType.center),
      ),
    );
  }
}
