
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class ApiLocalAuth {

  
  ApiLocalAuth._privateConstructor();

  static final ApiLocalAuth shared = ApiLocalAuth._privateConstructor();

  final _auth = LocalAuthentication();

  Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  Future<List<BiometricType>> getBiometrics() async{
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException  catch (e) {
      return <BiometricType>[];
    }
  }

  Future<bool> authenticateBiometrics() async{
  

    final isAvailable = await hasBiometrics();
    
    print("INGRESO A BIOMETRICSfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff ${isAvailable}");
    if(!isAvailable) return false;

    try {
      return await _auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException  catch (e) {
      print('Error - ${e.message}');
      return false;
    }

  }

}