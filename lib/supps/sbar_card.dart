import 'package:flutter/material.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';

class SbarCard extends StatelessWidget {
  SbarCard(
      {required this.label,
      this.labelIcon,
      this.labelIconColor,
      required this.labelBgColor,
      required this.cardShadowColor,
      required this.cardChild});

  final String label;
  final IconData? labelIcon;
  final Color? labelIconColor;
  final Color? labelBgColor;
  final Color cardShadowColor;
  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shadowColor: cardShadowColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            decoration: BoxDecoration(
              color: labelBgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  labelIcon,
                  color: labelIconColor,
                ),
                SizedBox(width: 12.0),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          cardChild,
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    labelBgColor!,
                    Colors.white,
                  ],
                  stops: [
                    0.1,
                    0.7,
                  ]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SbarStack extends StatelessWidget {
  SbarStack(
      {required this.label,
      required this.labelBgColor,
      required this.cardShadowColor,
      required this.cardChild,
      required this.footerChild});

  final String label;
  final Color? labelBgColor;
  final Color cardShadowColor;
  final Widget cardChild;
  final Widget footerChild;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0.0),
      elevation: 16.0,
      shadowColor: cardShadowColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
            decoration: BoxDecoration(
              color: labelBgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: kDarkSky,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          cardChild,
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            decoration: BoxDecoration(
              color: labelBgColor,
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.grey[300]!,
                    Colors.white,
                  ],
                  stops: [
                    0.1,
                    1.0,
                  ]),
            ),
            child: footerChild,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.grey[300]!,
                    Colors.white,
                  ],
                  stops: [
                    0.8,
                    1.0,
                  ]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Dropdown label

class DropDownLabel extends StatelessWidget {
  const DropDownLabel({@required this.labelText});

  final labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        children: <Widget>[
          Text(
            labelText,
            style: TextStyle(
              fontSize: 17.0,
//              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
