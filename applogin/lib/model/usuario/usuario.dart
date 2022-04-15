
class Usuario{
  late int idUsuario;
  late String usuario;
  late String correo;
  late String password;

  Usuario.fromServiceSpring(Map<String,dynamic> data ){
    idUsuario =  data['idUsuario'];
    usuario =  data['usuario'];
    correo =  data['correo'];
    password =  data['password'];

  }
}