import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';

class UsuariosPage extends StatefulWidget {

  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  
  final usuarios = [
    Usuario(uid: '1', nombre: 'Maria', email: 'test1@test.com', online: true),
    Usuario(uid: '2', nombre: 'Melissa', email: 'test2@test.com', online: false),
    Usuario(uid: '3', nombre: 'Fernando', email: 'test3@test.com', online: true)
  ];

  
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text(usuario.nombre,style: TextStyle(color: Colors.black87)),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){

            //desconectarnos del socket server
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
           icon: Icon(Icons.exit_to_app, color: Colors.black87),
           ),
           actions: [
             Container(
               margin: EdgeInsets.only(right: 10),
               child: Icon(Icons.check_circle, color: Colors.blue[400]),
               // child: Icon(Icons.offline_bolt, color: Colors.red),
             )
           ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue[400],
        ),
        child: _listViewUsuarios(),
        )
   );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_,i) => _usuarioListTile(usuarios[i]),
      separatorBuilder: (_,i) =>Divider(), 
      itemCount: usuarios.length
      );
  }

  ListTile _usuarioListTile(Usuario usuario ) {
    return ListTile(
        title: Text(usuario.nombre),
        subtitle: Text(usuario.email),
        leading: CircleAvatar(
          child: Text(usuario.nombre.substring(0,2)),   
          backgroundColor: Colors.blue[100],        
          ),
          trailing: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: usuario.online ? Colors.green[300] : Colors. red,
              borderRadius: BorderRadius.circular(100)
            ),
          ),
      );
  }

  _cargarUsuarios()async{
  
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  
  }
}