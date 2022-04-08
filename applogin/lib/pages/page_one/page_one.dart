import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applogin/bloc/basic_bloc.dart';
import 'package:applogin/pages/page_two/page_two.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => BasicBloc(),
        child: BlocListener<BasicBloc, BasicState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case AppStarted:
                break;
              case PageChanged:
                final estado = state as PageChanged;
                Navigator.push(context, MaterialPageRoute(builder: (cxt) => PageTwo(title: estado.title)));
                break;
            }
          },
          child: BlocBuilder<BasicBloc, BasicState>(
            builder: (context, state) {
              if (state is AppStarted) {
                print('aplicacion iniciada');
              }

              return Column(
                children: [
                  Text('Pagina uno'),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<BasicBloc>(context).add(ButtonPressed());
                    },
                    child: Text('Pagina dos'),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
