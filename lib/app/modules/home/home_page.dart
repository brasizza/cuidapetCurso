import 'package:cuidapetcurso/app/repository/shared_prefs_repository.dart';
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

    SharedPrefsRepository.instance.then((pref) {

    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[

          FlatButton(onPressed: () async{

             ( await SharedPreferences.getInstance()).clear();
            Modular.to.pushNamedAndRemoveUntil('/', (_) => false);


          //  Get.snackbar('oi', 'ooooi');
         
          }, child: Text("Logout"))
        ],
      ),
    );
  }
}
