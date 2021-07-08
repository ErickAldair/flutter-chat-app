
import 'package:chat/models/usuarios_response.dart';
import 'package:http/http.dart' as http;

import 'package:chat/global/environment.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/models/usuario.dart';

class UsuarioService {

  Future<List<Usuario>>  getUsuarios ()async{

    try {

      final url = Uri.parse('${ Environment.apiUrl }/usuarios');

      final resp = await http.get(url,
         headers:  {
           'Content-Type' : 'application/json',
           'x-token' : await AuthService.getToken()
         }
      );

      final usuariosResponse = usuariosResponseFromJson(resp.body);
      return usuariosResponse.usuarios;
      
    } catch (e) {
      return[];
    }
    
  }
}