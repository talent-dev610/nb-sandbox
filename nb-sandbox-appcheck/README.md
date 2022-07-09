# sbarsmartbrainapp

SBAR Smart Brain Redefined

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Making Google Sign In Work

In order to correctly make the Google Sign in work, run Flutter Web using the following command:
`flutter run -d chrome --web-hostname localhost --web-port 7357`

This is done as in Google Developer Console, http://localhost:7357 is added as an authorized JavaScript URI.

## Todo:

1. QR Scanner on Flutter Web 
2. Remove the options in the qr scan page 
3. Implement the multi sharing feature along with single sharing of patient data for PDF & QR sharing 
4. Fix sign in with apple loading issue 
5. Change the google sign in permissions 
6. Change the email and password auth to only email auth, that is passwordless sign in 
7. Shift the QR Code to a bottom modal sheet.
