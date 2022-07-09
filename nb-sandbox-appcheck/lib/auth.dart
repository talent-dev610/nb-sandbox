import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:universal_platform/universal_platform.dart';

import 'global.dart';
import 'models/patients/patient.dart';
import 'services/backend.dart';

class Auth {
  static final _auth = Auth._internal();
  factory Auth() => _auth;
  Auth._internal();

  GoogleSignIn googleSignIn = GoogleSignIn(
      // scopes: [
      //   'email',
      // ],
      );

  FacebookLogin fb = FacebookLogin();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> signInWithGoogle() async {
    try {
      print('--------initiating google signin---------');
      GoogleSignInAccount? acc;

      GoogleSignInAccount? _sigin = await googleSignIn.signInSilently();
      if (_sigin != null) {
        acc = _sigin;
      } else {
        acc = await googleSignIn.signIn();
      }
      if (acc != null) {
        GoogleSignInAuthentication auth = await acc.authentication;
        AuthCredential cred = GoogleAuthProvider.credential(
            idToken: auth.idToken, accessToken: auth.accessToken);
        SharedPreferences _prefss;
        _prefss = await SharedPreferences.getInstance();
        await FirebaseAuth.instance.signInWithCredential(cred);

        await _prefss.setString("auth", "google");
        await createInitialDocument();
        uploadGuestPatient(_prefss);
      }
    } catch (error) {
      print("signInerror:: $error");
    }
  }

  Future<void> logoutFromGoogle() async {
    if (await googleSignIn.isSignedIn()) await googleSignIn.signOut();
  }

  uploadGuestPatient(SharedPreferences _prefss) async {
    try {
      //get patient added by guest to add it to firestore
      String json = _prefss.getString('guestPatient')!;

      Map<String, dynamic> userMap = jsonDecode(json) as Map<String, dynamic>;
      Patient localPat = Patient.fromMap(userMap);
      print(localPat.toMap());

      print(_prefss.getString('guestPatient'));

      //add guest patient to firestore
      await Backend().addPatient(localPat);

      await _prefss.remove('guestPatient');
    } catch (e) {
      print('err$e');
    }
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    SharedPreferences _prefss;
    _prefss = await SharedPreferences.getInstance();
    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    await _prefss.setString("auth", "apple");
    await createInitialDocument();
    uploadGuestPatient(_prefss);
  }

  Future<void> signInWithFacebook() async {
    if (UniversalPlatform.isWeb) {
      // Create a new provider
      FacebookAuthProvider facebookProvider = FacebookAuthProvider();

      facebookProvider.addScope('email');
      facebookProvider.setCustomParameters({
        'display': 'popup',
      });

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithPopup(facebookProvider);
    } else {
      final res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      switch (res.status) {
        case FacebookLoginStatus.success:
          // Logged in
          await _prefs!.setString("auth", "facebook");

          // Send access token to server for validation and auth
          final FacebookAccessToken accessToken = res.accessToken!;
          print('Access token: ${accessToken.token}');

          // Get profile data
          final profile = await (fb.getUserProfile());
          print('Hello, ${profile!.name}! You ID: ${profile.userId}');

          // Get user profile image url
          final imageUrl = await fb.getProfileImageUrl(width: 100);
          print('Your profile image: $imageUrl');

          // Get email (since we request email permission)
          final email = await fb.getUserEmail();
          // But user can decline permission
          if (email != null) print('And your email is $email');

          AuthCredential cred =
              FacebookAuthProvider.credential(res.accessToken!.token);
          await FirebaseAuth.instance.signInWithCredential(cred);
          SharedPreferences _prefss;
          _prefss = await SharedPreferences.getInstance();
          await _prefss.setString("auth", "facebook");
          await createInitialDocument();
          uploadGuestPatient(_prefss);

          break;
        case FacebookLoginStatus.cancel:
          // User cancel log in
          break;
        case FacebookLoginStatus.error:
          // Log in failed
          print('Error while log in: ${res.error}');
          break;
      }
    }
  }

  Future<void> logoutFromFacebook() async {
    if (await fb.isLoggedIn) await fb.logOut();
  }

  Future<void> logout() async {
    SharedPreferences _prefss;
    _prefss = await SharedPreferences.getInstance();
    String? auth = _prefss.getString("auth");
    switch (auth) {
      case "google":
        await logoutFromGoogle();
        break;

      case "facebook":
        await logoutFromFacebook();
        break;

      default:
        break;
    }
    print(FirebaseAuth.instance.currentUser);
    // await FirebaseAuth.instance.currentUser.delete().then((value) {
    //   print("deleted");
    // });
    currentIndex = 0;
    await FirebaseAuth.instance.signOut();
    await _prefss.remove("auth");
  }

  Future<void> createInitialDocument() async {
    print("uid");
    DocumentReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    DocumentSnapshot doc = await ref.get();
    bool exists = doc.exists;

    if (!exists) {
      await ref.set({'uid': FirebaseAuth.instance.currentUser!.uid});
    } else {
      Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
      if (!map.containsKey('is_sharing')) {
        await ref.set({'is_sharing': false}, SetOptions(merge: true));
      }
    }
  }
}
