
import 'package:flutter/material.dart';


class TextInput extends StatelessWidget {


  final String hintText;
  
  final IconData icono;
  final Function(String) validator;
  final TextEditingController controller;
  final TextInputType inputType;

  const TextInput({ 
    Key? key,
    required this.inputType,
    required this.hintText,
    required this.validator,
    required this.controller,
    required this.icono }) : super(key: key);


  OutlineInputBorder getBorde (){
   const borde= OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffe5e5e5)
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
        maxLines: 1,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 163, 173, 179),
          border: InputBorder.none,
          hintText: hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(2.0), // add padding to adjust icon
            child: Icon(icono),
          ),
          errorBorder: getBorde(),
          enabledBorder: getBorde(),
          focusedBorder: getBorde(),
          focusedErrorBorder:  getBorde()
        ),
        validator: (value){
          return validator(value!);
        }
      ),
    );
  }
}