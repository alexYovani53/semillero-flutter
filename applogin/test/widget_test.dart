// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:applogin/localizations/localizations.dart';
import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/pages/page_client/client_data.dart';
import 'package:applogin/pages/page_login/PageLogin.dart';
import 'package:applogin/provider/languaje_provider.dart';
import 'package:applogin/provider/themeProvider.dart';
import 'package:applogin/utils/app_themes.dart';
import 'package:applogin/widgets/button_green.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:applogin/main.dart';
import 'package:provider/provider.dart';

void main() {


  Widget createWidgetForTesting({Widget? child}){
    return MaterialApp(
      home: child,
    );
  }


  Widget segundo({required Widget chil}){
    
  ThemeProvider themeProvider_ = ThemeProvider();
  LanguajeProvider langProvider = LanguajeProvider();
  langProvider.setLanguaje = const Locale("es");
  themeProvider_.setTheme=ThemeMode.light;

    return MultiProvider(
          providers: [
            //ChangeNotifierProvider(create: (_)=>LanguajeProvider()),
            ChangeNotifierProvider.value(value: langProvider),
            ChangeNotifierProvider.value(value: themeProvider_)
          ],
          child: Consumer2<LanguajeProvider, ThemeProvider>(
            builder: (context,LanguajeProvider languajeProvider, ThemeProvider themeProvider, child) {
              return  MaterialApp(
                    locale: languajeProvider.getLanguaje,
                    localizationsDelegates: const [
                      AppLocalizationsDelegate(),
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('es', ''),
                      Locale('en', ''),
                    ],
                    title: 'Flutter Demo',
                    debugShowCheckedModeBanner: false,
                    themeMode:themeProvider_.getTheme,
                    theme: AppThemes.claro,
                    darkTheme: AppThemes.obscuro,
                    home: Scaffold(
                      body: chil,
                    )
                  );
               
            },
          ),
        );  
  }


  testWidgets('Crear MyApp', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());  
  });

  // testWidgets("Login", (WidgetTester tester) async {
    
  //   await tester.pumpWidget( PageLogin());

  //   final textCorreo = find.byKey(const Key("inputEmail"));
  //   final textPass = find.byKey(const Key("inputPass"));

  //   await tester.ensureVisible(textCorreo);
  //   await tester.tap(textCorreo);
  //   await tester.enterText(textCorreo, "alexYovani53@gmail.com");

    
  //   await tester.ensureVisible(textPass);
  //   await tester.tap(textPass);
  //   await tester.enterText(textPass, "1234");

  // });

  testWidgets("Login", (WidgetTester tester) async {
    
    final data = {
      "dniCl": 11,
      "nombreCl": "alex",
      "apellido1": "a",
      "apellido2": "a",
      "claseVia": "a",
      "numeroVia": 3,
      "codPostal": 3,
      "ciudad": "Guatemala",
      "telefono": 444,
      "observaciones": "aaaa",
      "nombreVia": "a"
    };
      
    final cliente = Cliente.fromServiceSpring(data);
    await tester.pumpWidget( createWidgetForTesting( child: ClientData(cliente: cliente)));
    await tester.pumpAndSettle();

    expect(find.text("alex"), findsNWidgets(2));
  });

  testWidgets("Boton personal", (WidgetTester tester) async {
    int conteo = 0;

    await tester.pumpWidget(segundo(chil:ButtonGreen(texto: "texto", onPressed: (){ conteo += 1;})));

    await tester.pump(Duration(seconds: 3));

    final button = find.text("texto");

    await tester.pumpAndSettle();
    await tester.ensureVisible(button);
    await tester.tap(button);

    expect(conteo, 1);

  });

}
