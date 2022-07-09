import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

const kDarkSky = const Color(0xFF1D0426);
const kMidNightSkyBlend = const Color(0xFF190632);
const kDawnSky = const Color(0xFF4AC3F6);
const kNightSky = const Color(0xFF080E65);
const kNoonSky = const Color(0xFF3280C1);
const kOceanSky = const Color(0xFF37e5e3);
const kLavenSky = const Color(0xFF73B6FF);
const kAlgaeSea = const Color(0xFF0BE881);
const kRichGrass = const Color(0xFF0b5707);
const kJadeLake = const Color(0xFF52BE80);
const kRoyalSky = const Color(0xFF0044ff);
const kGreySky = const Color(0xFF757575);
const kLightCoal = const Color(0xFF4D5656);
const kVolcanoMist = const Color(0xFF171726);

const kBriefcaseHeader = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
  color: Colors.white,
);

const kBriefcaseTitle = TextStyle(
  color: kDarkSky,
  fontSize: 18.0,
  fontWeight: FontWeight.w400,
);

const kStackBodyStyle = TextStyle(
  fontSize: 15.0,
);

const kLabHeaderStyle = TextStyle(
  fontSize: 14.0,
  color: kLightCoal,
);

const kDropMenuItemStyle = TextStyle(
  color: kGreySky,
  fontSize: 18.0,
);

const kWelcomeItemStyle = TextStyle(
  color: Colors.black87,
  fontSize: 18.0,
  fontWeight: FontWeight.w400,
);

const kDashItemStyle = TextStyle(
  color: Colors.black87,
  fontSize: 18.0,
  fontWeight: FontWeight.w500,
);

const kFieldTitleStyle = TextStyle(
  color: kLightCoal,
  fontSize: 18.0,
);

const kCaughtUpStyle = TextStyle(
  fontSize: 20,
  // color: kMidNightSkyBlend,
  // fontWeight: FontWeight.bold,
);

const kFormHeaderStyle = TextStyle(
  fontSize: 20.0,
);

const kStackHeaderStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
);

const kHelperRequiredStyle = TextStyle(fontSize: 12.0, color: kGreySky);

const kFeedbackUrl =
    'https://docs.google.com/forms/d/e/1FAIpQLSfnNVyNb-7NzvEULBl6vt6OO81BHkj3g0fAapPbJ9FdT3js9g/viewform?usp=sf_link';

const kStackBodyCautionStyle = TextStyle(
  fontSize: 15.0,
  color: Colors.red,
);

const kStackDxStyle = TextStyle(
  fontSize: 15.0,
  color: kRichGrass,
//  fontWeight: FontWeight.bold,
);

const kStackCommentStyle = TextStyle(
  fontSize: 15.0,
  color: kNightSky,
//  fontWeight: FontWeight.bold,
);

// snack durations
const kBlinkSnack = const Duration(milliseconds: 500);
const kShortSnack = const Duration(seconds: 1);
const kMediumSnack = const Duration(seconds: 2);
const kRegularSnack = const Duration(seconds: 4);
const kLongSnack = const Duration(seconds: 8);
const kXLongSnack = const Duration(seconds: 12);

const sendGridApiKey = "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";
const sendGridTemplateId = "d-108b0e8825c24c1598a7cca7c5e52cb0";
const sendGridEndPoint = "https://api.sendgrid.com/v3/mail/send";
