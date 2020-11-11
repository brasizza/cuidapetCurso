import 'package:cuidapetcurso/app/repository/shared_prefs_repository.dart';
import 'package:cuidapetcurso/app/shared/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.initPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () => Modular.to.pushNamed('/home/enderecos'),
            icon: Icon(Icons.location_on),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Text(Modular.get<AuthStore>().usuarioLogado.email),
          FlatButton(
              onPressed: () async {
                var prefs = await SharedPrefsRepository.instance;
                await prefs.logout();
              },
              child: Text("Logout"))
        ],
      ),
    );
  }
}
