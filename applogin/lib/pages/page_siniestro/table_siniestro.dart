import 'package:applogin/model/siniestro/siniestro.dart';
import 'package:applogin/model/siniestro/siniestro_list.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:applogin/widgets/scroll_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class TableSiniestro extends StatefulWidget {

  SiniestroList listaSiniestro;
  VoidCallback actualizar;

  TableSiniestro({ 
    Key? key ,
    required this.listaSiniestro,
    required this.actualizar
  }) : super(key: key);

  @override
  State<TableSiniestro> createState() => _TableSiniestroState();
}

class _TableSiniestroState extends State<TableSiniestro> {
@override
  Widget build(BuildContext context) {
    return ScrollWidget(child:  buildDataTable());
  }

  Widget buildDataTable(){
    final columns  = ['Fecha',"Causas","Aceptado?","Indemnización","NúmeroPoliza","DNI Perito",""];

    return DataTable(      
      headingRowColor: MaterialStateColor.resolveWith((states) => Color.fromARGB(255, 183, 233, 125)),

      border:TableBorder.symmetric(inside: BorderSide(width: 2, color: Colors.blue), outside: BorderSide(width: 3, color: Colors.blue)),
    
      headingTextStyle: const TextStyle(
        color: Colors.black87
      ),
      dataTextStyle: const TextStyle(
        color: Colors.black54
      ),
      
      sortColumnIndex: 1,
      columns: getColumns(columns),
      rows: getRows(widget.listaSiniestro),
    );
  }

  List<DataColumn> getColumns(List<String> columns){
    return columns.map((String columna) => DataColumn(
      label: Text(columna,overflow: TextOverflow.fade),
      //onSort: onSort
    )).toList();
  }

  List<DataRow> getRows(SiniestroList lista){ 
    return lista.siniestros.map((Siniestro siniestro){
      
      final DateFormat  formatter = DateFormat('yyyy-MM-dd');
      final cells = [formatter.format(siniestro.fechaSiniestro), siniestro.causas,siniestro.aceptado,siniestro.indemnizacion,siniestro.numeroPoliza,siniestro.dniPerito];
      
      List<DataCell> celdas = getCells(cells);
      celdas.add(botones(siniestro.idSiniestro));

      return DataRow(cells: celdas);
    }).toList();
  }

  List<DataCell> getCells(List<dynamic> cells){
    
    
    return cells.map((campo) => DataCell(Text('$campo'))).toList();
  }

  DataCell botones(int siniestro){

    return DataCell(
      Row(
        children: [
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.black87,
            onPressed: ()async{
              final data =  await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: 'siniestros/delete/$siniestro', type: HttpType.DELETE);
              widget.actualizar();
          }),
        ],
      )
    );

  }

}