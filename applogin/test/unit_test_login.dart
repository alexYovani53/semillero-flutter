

import 'package:applogin/pages/page_login/PageLogin.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  PageLogin log = PageLogin();

  test("Encrypt",(){    
    final text = log.encrypt("HolaMundo");
    debugPrint(text);
    expect(text, isNotNull);
  });

  test("Decrypt",(){    
    final text =log.decrypt("M/sL/x8R0eBpm29jNADohw==");
    debugPrint(text);
    expect(text, "HolaMundo");
  });

}