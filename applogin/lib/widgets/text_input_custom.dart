
import 'package:flutter/material.dart';


class TextInputCustom extends StatelessWidget {


  final String hintText;
  
  final IconData icono;
  final Function(String) validator;
  final TextEditingController controller;
  final TextInputType inputType;

  const TextInputCustom({ 
    Key? key,
    required this.inputType,
    required this.hintText,
    required this.validator,
    required this.controller,
    required this.icono }) : super(key: key);


  OutlineInputBorder getBorde (){
   const borde= OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 7, 7, 7)
            ),
            borderRadius: BorderRadius.all(Radius.circular(15.0))
          );
    return borde;
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(right: 20.0, left: 20.0,top: 10.0),
      child: TextFormField(
        keyboardType: inputType ,
        autocorrect: true,
        maxLines: 1,
        controller: controller,
        autofocus: false,
        
        decoration: InputDecoration(
          filled: true,
          border: InputBorder.none,
          hintText: hintText,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(2.0), // add padding to adjust icon
            child: Icon(icono),
          ),
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusedErrorBorder:  InputBorder.none
        ),
        validator: (value){
          return validator(value!);
          
        }
      ),
    );
  }
}