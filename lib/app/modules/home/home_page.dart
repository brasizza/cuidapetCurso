import 'package:cuidapetcurso/app/repository/enderecos_repository.dart';
import 'package:cuidapetcurso/app/repository/shared_prefs_repository.dart';
import 'package:cuidapetcurso/app/shared/auth_store.dart';
import 'package:cuidapetcurso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          100,
        ),
        child: AppBar(
          backgroundColor: Colors.grey[100],
          title: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Text(
              'Cuida Pet',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => Modular.to.pushNamed('/home/enderecos'),
              icon: Icon(Icons.location_on),
            )
          ],
          elevation: 0,
          flexibleSpace: Stack(
            children: [
              Container(
                height: 90,
                width: double.infinity,
                color: ThemeUtils.primaryColor,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: ScreenUtil().screenWidth * .9,
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(30),
                    child: TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Icon(
                            Icons.search,
                            size: 30,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.grey[200],
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.grey[200],
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.grey[200],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 12.0),
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          child: Column(
            children: <Widget>[
              _buildEndereco(),
              _buildCategorias(),
              Expanded(child: _buildEstabelecimentos()),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildEndereco() {
    return Container(
      child: Column(
        children: [
          Text("Estabelecimentos próximos de "),
          Text(
            "Av Paulista 100",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCategorias() {
    return Container(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: ThemeUtils.primaryColorLight,
                  child: Icon(
                    Icons.pets,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("X")
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEstabelecimentos() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Text("Estabelecimentos"),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.view_headline),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.view_comfy),
              ),
            ],
          ),
        ),
        Expanded(
            child: PageView(
          children: [
            _buildEstabelecimentosLista(),
            _buildEstabelecimentosGrid(),
          ],
        )),
      ],
    );
  }

  Widget _buildEstabelecimentosLista() {
    return ListView.separated(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              Container(
                width: ScreenUtil().screenWidth,
                margin: EdgeInsets.only(left: 30),
                height: 80,
                color: Colors.red,
              )
            ],
          ),
        );
      },
      separatorBuilder: (_, index) => Divider(color: Colors.transparent),
    );
  }

  Widget _buildEstabelecimentosGrid() {
    return Container();
  }
}
