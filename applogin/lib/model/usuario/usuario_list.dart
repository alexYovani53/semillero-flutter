
import 'package:applogin/model/usuario/usuario.dart';

class UsuarioList {


  late List<Usuario> usuarios;

  UsuarioList.fromList(List<dynamic> data){
    usuarios = [];

    for (var item in data) {
      usuarios.add(Usuario.fromServiceSpring(item));
    }

  }

}