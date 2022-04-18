import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/model/seguro/seguro.dart';
import 'package:applogin/model/seguro/seguro_list.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:applogin/widgets/scroll_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class TableSeguro extends StatefulWidget{

  SeguroList listaSeguros;
  VoidCallback actualizar;

  TableSeguro({ 
    Key? key ,
    required this.listaSeguros,
    required this.actualizar
  }) : super(key: key);

  @override
  State<TableSeguro> createState() => _TableSeguroState();
}

class _TableSeguroState extends State<TableSeguro> {
     

  @override
  Widget build(BuildContext context) {
    return ScrollWidget(child:  buildDataTable());
  }

  Widget buildDataTable(){
    final columns  = ['Ramo',"Fecha Inico","Fecha Vencimiendo","Condiciones","Dni cliente",""];

    return DataTable(
      headingRowColor: MaterialStateColor.resolveWith((states) => Color.fromARGB(255, 183, 233, 125)),
      border: TableBorder.all(color: Colors.black,width: 1.0),
      headingTextStyle: TextStyle(
        color: Colors.black87
      ),
      dataTextStyle: TextStyle(
        color: Colors.black54
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50.0))       
        //color:  MaterialStateColor.resolveWith((states) => Colors.amber)
      ),
      sortColumnIndex: 1,     
      showBottomBorder: true,
      columns: getColumns(columns),
      rows: getRows(widget.listaSeguros),
    );
  }

  List<DataColumn> getColumns(List<String> columns){
    return columns.map((String columna) => DataColumn(
      label: Text(columna),
      //onSort: onSort
    )).toList();
  }

  List<DataRow> getRows(SeguroList lista){ 
    return lista.seguros.map((Seguro seguro_){
      
      final DateFormat  formatter = DateFormat('yyyy-MM-dd');
      final cells = [seguro_.ramo, formatter.format(seguro_.fechaInicio),formatter.format(seguro_.fechaVencimiento),seguro_.condicionesParticulares,seguro_.dniCl];
      
      List<DataCell> celdas = getCells(cells);
      celdas.add(botones(seguro_.numeroPoliza));
      
      return DataRow(cells:celdas);
    }).toList();
  }

  List<DataCell> getCells(List<dynamic> cells){
    return cells.map((campo) => DataCell(Text('$campo'))).toList();
  }

    DataCell botones(int poliza){
    return DataCell(
      Row(
        children: [
          IconButton(
            color: Colors.black87,
            icon: const Icon(Icons.delete),
            onPressed: ()async{
              final data =  await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: 'seguros/Delete/$poliza', type: HttpType.DELETE);
              widget.actualizar();
          })
        ],
      )
    );
  }

}