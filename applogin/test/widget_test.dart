// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:applogin/bloc/basic_bloc/basic_bloc.dart';
import 'package:applogin/localizations/localizations.dart';
import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/model/seguro/seguro.dart';
import 'package:applogin/model/seguro/seguro_list.dart';
import 'package:applogin/model/siniestro/siniestro.dart';
import 'package:applogin/model/siniestro/siniestro_list.dart';
import 'package:applogin/pages/page_client/client_data.dart';
import 'package:applogin/pages/page_client/client_view.dart';
import 'package:applogin/pages/page_client/list_client.dart';
import 'package:applogin/pages/page_login/PageLogin.dart';
import 'package:applogin/pages/page_seguro/Seguro_data.dart';
import 'package:applogin/pages/page_seguro/Seguro_view.dart';
import 'package:applogin/pages/page_seguro/list_client.dart';
import 'package:applogin/pages/page_setting/page_setting.dart';
import 'package:applogin/pages/page_siniestro/Siniestro_data.dart';
import 'package:applogin/pages/page_siniestro/Siniestro_view.dart';
import 'package:applogin/pages/page_siniestro/list_siniestro.dart';
import 'package:applogin/provider/languaje_provider.dart';
import 'package:applogin/provider/themeProvider.dart';
import 'package:applogin/utils/app_themes.dart';
import 'package:applogin/widgets/button_green.dart';
import 'package:applogin/widgets/cupertino_bar.dart';
import 'package:applogin/widgets/encabezado_pages.dart';
import 'package:applogin/widgets/gradient_back.dart';
import 'package:applogin/widgets/text_input_custom.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:applogin/main.dart';
import 'package:provider/provider.dart';

void main() {


  Widget createWidgetForTesting({Widget? child}){
    return MaterialApp(
      home: child,
    );

  }


  Widget createWidgetForTesting2({required Widget child_}){
    
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
                      body: child_,
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

  // setUpAll(() async{ 
  //   await Firebase.initializeApp();

  // });
  // testWidgets("Login", (WidgetTester tester) async {
  //   //await Firebase.initializeApp();
    
  //   await tester.pumpWidget( createWidgetForTesting2(child_: PageLogin()));

  //   final textCorreo = find.byKey(const Key("inputEmail"));
  //   final textPass = find.byKey(const Key("inputPass"));

  //   await tester.ensureVisible(textCorreo);
  //   await tester.tap(textCorreo);
  //   await tester.enterText(textCorreo, "alexYovani53@gmail.com");

    
  //   await tester.ensureVisible(textPass);
  //   await tester.tap(textPass);
  //   await tester.enterText(textPass, "1234");

  //   TextFormField email = tester.firstWidget(textCorreo);
  //   expect(email.controller!.text,"alexYovani53@gmail.com");

  // });

  testWidgets("TextFormField",(WidgetTester tester)async{
    TextEditingController controller = TextEditingController();

    final textInput = TextInputCustom(inputType: TextInputType.text, hintText: "", validator: (val){}, controller: controller, icono: Icons.person);
    await tester.pumpWidget(createWidgetForTesting2(child_: textInput));


    expect(find.byWidget(textInput), findsOneWidget);

    await tester.ensureVisible(find.byWidget(textInput));
    await tester.tap(find.byWidget(textInput));
    await tester.enterText(find.byWidget(textInput), "alexYovani53@gmail.com");

    expect(controller.text,"alexYovani53@gmail.com");

  });

  testWidgets("encabezado", (WidgetTester tester) async{

    final wid = EncabezadoPages(titulo:"Clientes");
    await tester.pumpWidget(createWidgetForTesting2(child_:BlocProvider(
          create: (context)=> BasicBloc(),
          child: BlocListener<BasicBloc,BasicState>(
           listener: (context, state) {
            
           }, 
           child: BlocBuilder<BasicBloc,BasicState>(
               builder: (context, state) {
                 return Scaffold(
                   body: wid,
                 );
               },
             ),
          )
        ) ));

    await tester.pumpAndSettle();

    expect(find.byWidget(wid), findsOneWidget);
    

  });


  testWidgets("Boton personal", (WidgetTester tester) async {
    int conteo = 0;

    await tester.pumpWidget(createWidgetForTesting2(child_:ButtonGreen(texto: "texto", onPressed: (){ conteo += 1;})));
    final button = find.text("texto");

    await tester.pumpAndSettle();
    await tester.ensureVisible(button);
    await tester.tap(button);

    expect(conteo, 1);

  });

  testWidgets("background", (WidgetTester tester) async{

    await tester.pumpWidget(createWidgetForTesting2(child_: GradientBack()));
    expect(find.byKey(const Key("background")), findsOneWidget);
  });

  testWidgets("cupertino Bar",(WidgetTester tester)async{
    await tester.pumpWidget(createWidgetForTesting2(
        child_: BlocProvider(
          create: (context)=> BasicBloc(),
          child: BlocBuilder<BasicBloc,BasicState>(
            builder: (context, state) {
              return const CuppertinoBar();
            },
          ),
        ) 
      )
    );
    expect(find.byIcon(Icons.emoji_people,skipOffstage: false),findsNWidgets(1));
    expect(find.byIcon(Icons.add_moderator,skipOffstage: false),findsNWidgets(1));
    expect(find.byIcon(Icons.dangerous,skipOffstage: false),findsNWidgets(1));
  });

  testWidgets("Vista clientes", (WidgetTester tester)async{
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
      
    await tester.pumpWidget(createWidgetForTesting2(
      child_: ListClient(
        listaCliente: ClienteList.fromList([data,data]), navegar: (data){}
      )
    ));

    await tester.pump();

    expect(find.byType(ClientView,skipOffstage: false),findsNWidgets(2));

  });  
  
  testWidgets("Vista seguros", (WidgetTester tester)async{
    final data = {
      "numeroPoliza": 303,
      "ramo": "fecha",
      "fechaInicio": "2022-04-28",
      "fechaVencimiento": "2022-04-30",
      "condicionesParticulares": "ffffffffffff",
      "dniCl": 285      
    };
      
    await tester.pumpWidget(createWidgetForTesting2(
      child_: ListSeguro(
        listaSeguros: SeguroList.fromList([data,data,data,data]), navegar: (data){}
      )
    ));

    await tester.pump();

    expect(find.byType(SeguroView,skipOffstage: false),findsNWidgets(4));

  }); 

  testWidgets("Vista siniestros", (WidgetTester tester)async{
    final data = {
      "idSiniestro": 143,
      "fechaSiniestro": "2022-03-10T00:00:00.000+00:00",
      "causas": "Incendio",
      "aceptado": "no",
      "indemnizacion": 15000,
      "numeroPoliza": 303,
      "dniPerito": 67
    };

    await tester.pumpWidget(createWidgetForTesting2(
      child_: ListSiniestro(
        listaSiniestros: SiniestroList.fromList([data,data,data,data]), navegar: (data){}
      )
    ));

    await tester.pump();

    expect(find.byType(SiniestroView,skipOffstage: false),findsNWidgets(4));

  }); 


    testWidgets("Cliente data", (WidgetTester tester) async {
    
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
    expect(find.text("11"), findsNWidgets(1));
    expect(find.text("Guatemala"), findsNWidgets(1));
  });

    testWidgets("Seguro data", (WidgetTester tester) async {
    
    final data = {
      "numeroPoliza": 303,
      "ramo": "VIDA",
      "fechaInicio": "2022-04-28",
      "fechaVencimiento": "2022-04-30",
      "condicionesParticulares": "Ninguna",
      "dniCl": 285      
    };
      
    final seguro = Seguro.fromServiceSpring(data);
    await tester.pumpWidget( createWidgetForTesting( child: SeguroData(seguro:seguro)));
    await tester.pumpAndSettle();

    expect(find.text("2022-04-28"), findsNWidgets(1));
    expect(find.text("Ninguna"), findsNWidgets(1));
    expect(find.text("VIDA"), findsNWidgets(1));
  });

  testWidgets("Siniestro data", (WidgetTester tester) async {
    
    final data = {
      "idSiniestro": 143,
      "fechaSiniestro": "2022-03-10T00:00:00.000+00:00",
      "causas": "Incendio",
      "aceptado": "no",
      "indemnizacion": 15000,
      "numeroPoliza": 303,
      "dniPerito": 67
    };
      
    final siniestro = Siniestro.fromServiceSpring(data);
    await tester.pumpWidget( createWidgetForTesting( child: SiniestroData(siniestro: siniestro)));
    await tester.pumpAndSettle();

    expect(find.text("Incendio"), findsNWidgets(1));
    expect(find.text("no"), findsNWidgets(1));
    expect(find.text("15000"), findsNWidgets(1));
  });

  testWidgets("Setting theme", (WidgetTester tester)async{


    await tester.pumpWidget(createWidgetForTesting2(child_: PageSetting()));

    final buttonDark = find.byKey(const Key("Dark"),skipOffstage: false);
    final buttonLight = find.byKey(const Key("Light"),skipOffstage: false);
    expect(buttonDark, findsOneWidget);
    expect(buttonLight,findsOneWidget);

    await tester.tap(buttonDark,pointer: 1);
    expect(find.text("Claro"), findsOneWidget);

  });


}
