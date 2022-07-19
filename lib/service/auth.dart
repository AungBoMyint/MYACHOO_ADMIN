import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> onAuthChange() => _firebaseAuth.authStateChanges();

  Future<void> login({
    required String phoneNumber,
    required PhoneVerificationCompleted verificationCompleted,
    required PhoneVerificationFailed verificationFailed,
    required PhoneCodeSent codeSent,
    required PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
  }) =>
      _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
  //Login with phone number in Web
  Future<void> loginInWeb({
    required String phoneNumber,
    required void Function(void Function(String code)) enterCode,
  }) async {
    await _firebaseAuth
        .signInWithPhoneNumber(phoneNumber)
        .then((confirmationResult) {
      //Confirm with phone code
      enterCode((phoneCode) {
        //The time user have filled phone code and pressed confirm
        confirmationResult
            .confirm(phoneCode) //CONFIRM
            .then((value) => _firebaseAuth.signInWithCredential(
                value.credential!)); //SIGN IN WITH CREDENTIAL
      });
    });
  }

  Future<void> loginWithCerdential(AuthCredential credential) =>
      _firebaseAuth.signInWithCredential(credential);

  Future<void> logout() => _firebaseAuth.signOut();
}
