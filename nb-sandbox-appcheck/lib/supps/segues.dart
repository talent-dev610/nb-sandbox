import 'package:flutter/material.dart';

import 'constants.dart';

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                kMidNightSkyBlend,
                kNightSky,
                kNoonSky,
                kDawnSky,
                kOceanSky
              ],
              stops: [
                0.01,
                0.2,
                0.8,
                0.9,
                1.0
              ]),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.cloud_done,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 10),
              Text(
                'Success',
                style: TextStyle(fontSize: 54, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              RaisedButton.icon(
                color: Colors.white,
                onPressed: () {},
                label: Text(
                  'Add Next Patient',
                  style: TextStyle(fontSize: 20.0),
                ),
                icon: Icon(Icons.person_add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
