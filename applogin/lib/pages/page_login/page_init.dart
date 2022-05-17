import 'package:applogin/bloc/basic_bloc/basic_bloc.dart';
import 'package:applogin/pages/page_login/PageLogin.dart';
import 'package:applogin/widgets/cupertino_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageInit extends StatelessWidget {
  const PageInit({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasicBloc,BasicState>(
      builder: (context,state){        
        if (state.isLogeado){
          return CuppertinoBar();
        }else{
          return PageLogin();
        }

      },
    );
  }
}