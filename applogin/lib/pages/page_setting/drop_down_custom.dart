
import 'package:applogin/localizations/localizations.dart';
import 'package:applogin/provider/languaje_provider.dart';
import 'package:applogin/utils/app_string.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDownCustom extends StatefulWidget {
  
  TextEditingController textEditingController  = TextEditingController();
  Function(String) setting;

  DropDownCustom({ 
    Key? key,
    required this.textEditingController,
    required this.setting
  
  }) : super(key: key);

  @override
  State<DropDownCustom> createState() => _DropDownCustomState();
}

class _DropDownCustomState extends State<DropDownCustom> {
 /// This is list of city which will pass to the drop down.
 /// 
  late AppLocalizations diccionary;
  bool isCitySelected = true;
  final TextEditingController _langController = TextEditingController();

  List<SelectedListItem> _listOfLangs = [
    SelectedListItem(false, "English"),
    SelectedListItem(false, "Spanish"),
  ];


  void onTextFieldTap(){
    DropDownState(
      DropDown(
        submitButtonText: "kDone",
        submitButtonColor: const Color.fromRGBO(70, 76, 222, 1),
        searchHintText: diccionary.dictionary(Strings.settingLanguaje),
        bottomSheetTitle: diccionary.dictionary(Strings.settingLanguajes),
        searchBackgroundColor: Colors.black12,
      
        dataList: _listOfLangs,
        // selectedItems: (List<dynamic> selectedList) {
        //   showSnackBar(selectedList.toString());
        // },
        selectedItem: (String selected) async {
          widget.textEditingController.text = selected;
          showSnackBar(selected);
          await widget.setting(selected); 
        },
        enableMultipleSelection: false,
        searchController: _langController,
      )
    ).showModal(context);
  }

   void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    final LanguajeProvider lang = Provider.of<LanguajeProvider>(context,listen: false);
    diccionary = AppLocalizations(lang.getLanguaje);
    
    _listOfLangs = [
      SelectedListItem(false, diccionary.dictionary(Strings.settingEnglish)),
      SelectedListItem(false, diccionary.dictionary(Strings.settingSpanish))
    ];

    return 
        TextFormField(
          controller: _langController,
          cursorColor: Colors.black,
          
          
          onTap: isCitySelected
              ? () {
                  FocusScope.of(context).unfocus();
                  onTextFieldTap();
                }
              : null,
          decoration:  InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            filled: true,
            fillColor: Colors.black12,
            contentPadding:  const EdgeInsets.only(left: 8, bottom: 0, top: 0, right: 15),
            hintText: "Select lang",
            
            border:  OutlineInputBorder(
              borderSide: const  BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            prefixIcon: const Icon(Icons.language_rounded)
          ),
        );
      }
}