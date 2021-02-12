part of '../pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userPassword = '';

  @override
  Widget build(BuildContext context) {
    // final signInProv = Provider.of<SignInProvider>(context);

    Future<http.Response> _trySubmit() async {
      final isValid = _formKey.currentState.validate();

      if (isValid) {
        _formKey.currentState.save();

        //print(_userEmail.trim());
        //print(_userPassword.trim());

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Center(
                  child: const SpinKitWave(
                      color: kPrimaryColor, type: SpinKitWaveType.center));
            });

        String url =
            'http://retailapi.airtechsolutions.pk/api/customer/login/${_userEmail.trim()}/${_userPassword.trim()}';

        //print(url);
        http.Response res = await http.get(
          url,
        );
        var data = json.decode(res.body.toString());
        //print(data);

        if (data['description'].toString() == "Success") {
          //print('hogya');
          Navigator.pop(context);
          //print(data['customer']['Addresses']);
          //print(data['customer']['CustomerID']);
          //print(data['customer']['Email']);
          //print(data['customer']['FullName']);
          final _storage = FlutterSecureStorage();

          await _storage.write(key: 'imei', value: 'loginhuavaha');
          await _storage.write(key: '_userEmail', value: _userEmail.trim());
          await _storage.write(
              key: '_userPassword', value: _userPassword.trim());
          await _storage.write(
              key: '_userID', value: data['customer']['CustomerID'].toString());
          await _storage.write(
              key: '_userEmail', value: data['customer']['Email'].toString());
          await _storage.write(
              key: '_userName', value: data['customer']['FullName'].toString());
          navigateToHomePage(context);
        } else {
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "Something went wrong.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: kPrimaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        //

      }
    }

    return Scaffold(

      body: Container(
        child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 80.0),
                  buildIcon(context),
                  SizedBox(height: 18.0),
                  buildTitle(context),
                  SizedBox(height: 12.0),
                  buildSubtitle(context),
                  SizedBox(height: 35.0),

                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value;
                    },
                    cursorColor: Theme.of(context).primaryColor,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    style: Theme.of(context).textTheme.bodyText2,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                      hintStyle: Theme.of(context).textTheme.subtitle2,
                      prefixIcon: Icon(FlutterIcons.mail_fea),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor.withOpacity(.4),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).errorColor,
                          )),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).errorColor,
                          )),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a valid Password.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPassword = value;
                    },
                    cursorColor: Theme.of(context).primaryColor,
                    obscureText: true,
                    style: Theme.of(context).textTheme.bodyText2,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: Theme.of(context).textTheme.subtitle2,
                      prefixIcon: Icon(FlutterIcons.lock_fea),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor.withOpacity(.4),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).errorColor,
                          )),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).errorColor,
                          )),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  buildForgotPasswordButton(context),
                  SizedBox(height: 20.0),
                  SideInAnimation(
                    4,
                    child: RaisedButtonWidget(
                      title: 'signin.signin',
                      onPressed: () async {
                        _trySubmit();

                        // navigateToHomePage(context);
                        // final _storage = FlutterSecureStorage();
                        //
                        // await _storage.write(key: 'imei', value: 'loginhuavaha');
                      },
                    ),
                  ),
                  SizedBox(height: 15.0),
                  buildDivider(context),
                  SizedBox(height: 15.0),
                  buildGoogleSignInButton(),
                  SizedBox(height: 15.0),
                  buildFacebookSignInButton(),
                  SizedBox(height: 15.0),
                  buildSignUpButton(context),
                  SizedBox(height: 15.0),
                  // Text(tr('ewew'))
                ],
              ),
            )),
      ),
    );
  }

  FadeInAnimation buildDivider(BuildContext context) {
    return FadeInAnimation(
      5,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              height: .5,
              color: Theme.of(context).accentColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'signin.or',
              style: Theme.of(context).textTheme.subtitle2,
            ).tr(),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: .5,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }

  FadeInAnimation buildSignUpButton(BuildContext context) {
    return FadeInAnimation(
      7,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'signin.noaccount',
              style: Theme.of(context).textTheme.subtitle1,
            ).tr(),
            SizedBox(width: 7.0),
            GestureDetector(
              onTap: navigateToSignUp,
              child: Text(
                'signin.register',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Theme.of(context).primaryColor),
              ).tr(),
            )
          ],
        ),
      ),
    );
  }

  FadeInAnimation buildFacebookSignInButton() {
    return FadeInAnimation(
      6,
      child: FacebookSignInButtonWidget(
        title: 'signin.facebook',
        onPressed: facebookSignInClicked,
      ),
    );
  }

  FadeInAnimation buildGoogleSignInButton() {
    return FadeInAnimation(
      5,
      child: GoogleSignInButtonWidget(
        title: 'signin.google',
        onPressed: googleSignInClicked,
      ),
    );
  }

  // SideInAnimation buildSignInButton(BuildContext context) {
  //   return SideInAnimation(
  //     4,
  //     child: RaisedButtonWidget(
  //       title: 'signin.signin',
  //       onPressed: () async {
  //         _trySubmit();
  //
  //         // navigateToHomePage(context);
  //         // final _storage = FlutterSecureStorage();
  //         //
  //         // await _storage.write(key: 'imei', value: 'loginhuavaha');
  //       },
  //     ),
  //   );
  // }

  SideInAnimation buildForgotPasswordButton(BuildContext context) {
    return SideInAnimation(
      4,
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: navigateToForgotPassword,
          child: Text(
            'signin.forgot',
            style:
                Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14.0),
          ).tr(),
        ),
      ),
    );
  }

  SideInAnimation buildPasswordTextField() {
    return SideInAnimation(
      3,
      child: TextFormFieldWidget(
        obscureText: true,
        hintText: tr('signin.password'),
        keyboardType: TextInputType.text,
        prefixIcon: Icon(FlutterIcons.lock_fea),
      ),
    );
  }

  // SideInAnimation buildEmailTextField() {
  //   return SideInAnimation(
  //     3,
  //     child: TextFormField(
  //       cursorColor: Theme.of(context).primaryColor,
  //       obscureText: false,
  //       keyboardType: TextInputType.emailAddress,
  //       style: Theme.of(context).textTheme.bodyText2,
  //       autocorrect: false,
  //       decoration: InputDecoration(
  //         hintText: 'Email Address',
  //         hintStyle: Theme.of(context).textTheme.subtitle2,
  //         prefixIcon: Icon(FlutterIcons.mail_fea),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12.0),
  //           borderSide: BorderSide(
  //             color: Theme.of(context).accentColor.withOpacity(.4),
  //           ),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12.0),
  //           borderSide: BorderSide(
  //             color: Theme.of(context).primaryColor,
  //           ),
  //         ),
  //         focusedErrorBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(12.0),
  //             borderSide: BorderSide(
  //               color: Theme.of(context).errorColor,
  //             )),
  //         errorBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(12.0),
  //             borderSide: BorderSide(
  //               color: Theme.of(context).errorColor,
  //             )),
  //       ),
  //     )
  //
  //
  //
  //
  //
  //   );
  // }

  SideInAnimation buildSubtitle(BuildContext context) {
    return SideInAnimation(
      2,
      child: Text(
        'signin.subtitle',
        style: Theme.of(context).textTheme.subtitle1,
      ).tr(),
    );
  }

  SideInAnimation buildTitle(BuildContext context) {
    return SideInAnimation(
      2,
      child: Text(
        'signin.title',
        style: Theme.of(context).textTheme.headline1,
      ).tr(),
    );
  }

  SideInAnimation buildIcon(BuildContext context) {
    return SideInAnimation(
      1,
      child: Center(
        child: Container(
          width: 75.0,
          height: 75.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Theme.of(context).primaryColor,
          ),
          child: Center(
            child: Icon(
              Icons.shopping_cart_outlined,
              color: kBackgroundLightColor,
              size: 45.0,
            ),
          ),
        ),
      ),
    );
  }

  void navigateToSignUp() {
    Get.to(SignUpPage());
  }

  void navigateToForgotPassword() {
    Get.to(ForgotPasswordPage());
  }

  navigateToHomePage(BuildContext context) {
    Get.offAll(BottomNavigationBarPage());
  }

  facebookSignInClicked() {
    showToast(msg: 'Facebook Sign In Clicked!');
  }

  googleSignInClicked() {
    showToast(msg: 'Google Sign In Clicked!');
  }
}
