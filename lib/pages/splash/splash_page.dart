part of '../pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: kPrimaryColor,
      splash: 'assets/icons/logo.png',
      nextScreen: SplashWelcomePage(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      duration: 1000,
      animationDuration: Duration(milliseconds: 1500),
    );
  }
}

class SplashWelcomePage extends StatefulWidget {
  @override
  _SplashWelcomePageState createState() => _SplashWelcomePageState();
}

class _SplashWelcomePageState extends State<SplashWelcomePage> {
  startTime() {
    Timer(
      Duration(milliseconds: 1500),
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
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const SpinKitWave(color: kPrimaryColor, type: SpinKitWaveType.center),
      ),
    );
  }
}
