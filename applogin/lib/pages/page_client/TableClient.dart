import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:applogin/widgets/scroll_widget.dart';
import 'package:flutter/material.dart';

class TableClient extends StatefulWidget{

  ClienteList listaCliente;
  VoidCallback actualizar;
  Function(Cliente) editar;

  TableClient({ 
    Key? key ,
    required this.listaCliente,
    required this.actualizar,
    required this.editar
  }) : super(key: key);

  @override
  State<TableClient> createState() => _TableClientState();
}

class _TableClientState extends State<TableClient> {
  
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  Widget build(BuildContext context) {
    return ScrollWidget(child:  buildDataTable());
  }

  Widget buildDataTable(){
    final columns  = ['nombreCl',"apellido1","apellido2","ciudad","Cod Postal","Clase Via","Nombre Via","Numero Via", "telefono","observaciones",""];

    return DataTable(
      columnSpacing: 5.0,
      decoration: BoxDecoration(border: Border.all(color: Colors.green, width: 10)),
      dividerThickness: 5,
      showBottomBorder: true,
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: getColumns(columns),
      rows: getRows(widget.listaCliente),
    );
  }

  List<DataColumn> getColumns(List<String> columns){
    return columns.map((String columna) => DataColumn(
      label: Text(columna),
      onSort: onSort
    )).toList();
  }

  List<DataRow> getRows(ClienteList lista){ 
    return lista.clientes.map((Cliente client){
      final cells = [client.nombreCl, client.apellido1,client.apellido2,client.ciudad,client.codPostal,client.claseVia,client.nombreVia,client.numeroVia,client.telefono,client.observaciones];
      
      List<DataCell> celdas = getCells(cells);
      celdas.add(botones(client.dniCl,client));

      return DataRow(cells: celdas,selected: true,color:  MaterialStateColor.resolveWith((states) => Colors.amber));
    }).toList();
  }

  List<DataCell> getCells(List<dynamic> cells){
    return cells.map((campo) => DataCell(Text('$campo'))).toList();
  }

  void onSort(int columnIndex, bool ascending){
    if (columnIndex == 0){
      widget.listaCliente.clientes.sort((client1,client2)=>
        compareString(ascending,client1.nombreCl,client2.nombreCl)
      );
    }else{
      widget.listaCliente.clientes.sort((client1,client2)=>
        compareString(ascending,client1.nombreCl,client2.nombreCl)
      );
    }
  }

  int compareString(bool ascending, String value1, String value2){
    return ascending? value1.compareTo(value2): value2.compareTo(value1);
  }

  DataCell botones(int dniCl, Cliente client){
    return DataCell(
      Row(
        children: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: ()async{
              final data =  await ApiManager.shared.request(baseUrl: '3.19.244.228:8585', uri: 'cliente/Delete/$dniCl', type: HttpType.DELETE);
              widget.actualizar();
          }),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: ()async{
              widget.editar(client);
          })
        ],
      )
    );
  }

}