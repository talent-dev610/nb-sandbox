import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sbarsmartbrainapp/auth.dart';
import 'package:sbarsmartbrainapp/global.dart';
import 'package:sbarsmartbrainapp/screens/home/home.dart';
import 'package:sbarsmartbrainapp/services/firebase_analytics.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  bool policyFlag = false;
  bool termsFlag = true;

  void launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  void initState() {
    // prevent auth screen from not popping up on safari/firefox
    Auth().googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CustomAnalytics().screenLogin();
    Auth().init(); // preparing to login
    // Random int generator
    Random random = new Random();
    int randomNumber = random.nextInt(3); // 0-2,3 excluded
    return Scaffold(
      backgroundColor:
          Color.fromRGBO(217, 243, 255, 1), // Color.fromRGBO(217, 243, 255, 1)
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(builder: (context, constraints) {
        var smallScreen = constraints.maxWidth < 768;
        var size = constraints.biggest;
        var bgUrl = 'https://nb-app.b-cdn.net/login$randomNumber.jpeg';
        return Stack(
          children: [
            // Text / Logo
            Positioned(
              top: size.height * 0.01,
              left: size.width * 0.1,
              right: size.width * 0.1,
              height: size.height * 0.22,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /*Text(
                    'NurseBrain™',
                    style: TextStyle(
                      fontSize: 14,
                      color: kNoonSky,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),*/
                  SizedBox(height: 10),
                  Text(
                    'Stay on Top of Your Shift!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: kMidNightSkyBlend,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    children: [
                      Text(
                        'Access your HIPAA compliant nursing report sheet from any device and get expert nursing tools and resources right at your fingertips!',
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        style: TextStyle(
                          fontSize: 15,
                          color: kNoonSky,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            MyCurvedPositioned(size.height * 0.80, Colors.white),
            MyCurvedPositioned(
                size.height * 0.76, Color.fromRGBO(180, 229, 251, 1)),
            MyCurvedPositioned(
                size.height * 0.70, Color.fromRGBO(155, 217, 248, 1)),
            MyCurvedPositioned(
                size.height * 0.64, Color.fromRGBO(132, 215, 239, 1)),
            // background image
            MyCurvedPositionedImage(size.height * 0.58, bgUrl),
            // Apple Signin
            UniversalPlatform.isIOS
                ? Positioned(
                    left: smallScreen ? size.width * 0.12 : size.width * 0.22,
                    right: smallScreen ? size.width * 0.12 : size.width * 0.22,
                    top: size.height * 0.53,
                    height: size.height * 0.09,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final snackBar = SnackBar(
                          backgroundColor: kMidNightSkyBlend,
                          content: Text(
                              'Please agree to the terms and conditions in order to proceed.'),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        );
                        if (termsFlag) {
                          await Auth().signInWithApple();
                          firebaseAnalytics.logLogin();
                          currentIndex = 1;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        } else {
                          print('apple signin error');
                        }
                      },
                      icon: Icon(FontAwesomeIcons.apple),
                      label: Text('Continue with with Apple'),
                    ),
                  )
                : Container(),
            // Facebook Signin
            Positioned(
              left: smallScreen ? size.width * 0.12 : size.width * 0.22,
              right: smallScreen ? size.width * 0.12 : size.width * 0.22,
              top: size.height * 0.65,
              height: size.height * 0.09,
              child: ElevatedButton.icon(
                onPressed: () async {
                  // Auth().signInWithFacebook,
                  final snackBar = SnackBar(
                    backgroundColor: kMidNightSkyBlend,
                    content: Text(
                        'Please agree to the terms and conditions in order to proceed.'),
                    action: SnackBarAction(
                      label: '',
                      onPressed: () {
                        // launchURL("https://nursebrain.app/terms/");
                      },
                    ),
                  );
                  if (termsFlag) {
                    await Auth().signInWithFacebook();
                    firebaseAnalytics.logLogin();
                    currentIndex = 1;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  } else {
                    print('facebook signin error');
                  }
                },
                icon: Icon(FontAwesomeIcons.facebook),
                label: Text('Continue with with Facebook'),
              ),
            ),
            // Google Signin
            Positioned(
              left: smallScreen ? size.width * 0.12 : size.width * 0.22,
              right: smallScreen ? size.width * 0.12 : size.width * 0.22,
              top: size.height * 0.77,
              height: size.height * 0.09,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final snackBar = SnackBar(
                    backgroundColor: kMidNightSkyBlend,
                    content: Text(
                        'Please agree to the terms and conditions in order to proceed.'),
                    action: SnackBarAction(
                      label: '',
                      onPressed: () {
                        // launchURL("https://nursebrain.app/terms/");
                      },
                    ),
                  );
                  if (termsFlag) {
                    await Auth().signInWithGoogle();
                    firebaseAnalytics.logLogin();
                    if (FirebaseAuth.instance.currentUser!.uid != null &&
                        FirebaseAuth.instance.currentUser!.uid != '') {
                      currentIndex = 1;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }
                  } else {
                    print('google signin error');
                  }
                },
                icon: Icon(FontAwesomeIcons.google),
                label: Text('Continue with with Google'),
              ),
            ),
            // Terms and Conditions
            Positioned(
              left: smallScreen ? size.width * 0.08 : size.width * 0.22,
              right: smallScreen ? size.width * 0.08 : size.width * 0.22,
              top: size.height * 0.90,
              height: size.height * 0.05,
              child: Container(
                color: Color.fromRGBO(25, 6, 50, 0.15),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    GestureDetector(
                        child: Icon(
                          !termsFlag
                              ? Icons.check_box_outline_blank
                              : Icons.check_box,
                          color: Colors.blue,
                        ),
                        onTap: () {
                          setState(() {
                            termsFlag = !termsFlag;
                          });
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      child: Text(
                        "I agree to the terms and conditions. ",
                        style: TextStyle(fontSize: 15, color: Colors.white
                            // decoration: TextDecoration.underline
                            ),
                      ),
                      onTap: () {
                        setState(() {
                          termsFlag = !termsFlag;
                        });
                        launchURL("https://nursebrain.com/terms/");
                        CustomAnalytics().eventViewTerms();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class MyCurvedPositioned extends StatelessWidget {
  final double height;
  final Color color;

  MyCurvedPositioned(this.height, this.color);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: height,
      child: ClipPath(
        clipper: _MyClipper(),
        child: Container(
          decoration: BoxDecoration(color: color),
        ),
      ),
    );
  }
}

class MyCurvedPositionedImage extends StatelessWidget {
  final double height;
  final String image;

  MyCurvedPositionedImage(this.height, this.image);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: height,
      child: ClipPath(
        clipper: _MyClipper(),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                  alignment: Alignment.center)),
        ),
      ),
    );
  }
}

class _MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.quadraticBezierTo(size.width * 0.5, size.height * 0.22, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
