import 'package:cuidapetcurso/app/models/categoria_model.dart';
import 'package:cuidapetcurso/app/modules/home/components/home_appbar.dart';
import 'package:cuidapetcurso/app/repository/enderecos_repository.dart';
import 'package:cuidapetcurso/app/repository/shared_prefs_repository.dart';
import 'package:cuidapetcurso/app/shared/auth_store.dart';
import 'package:cuidapetcurso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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

  var appBar; // HomeAppBar(controller);
  Map<String,IconData> categoriasIcons = {

    'P': Icons.pets,
    'V' : Icons.local_hospital,
    'C': Icons.store_mall_directory
  };
  _HomePageState() {
    appBar = HomeAppBar(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Colors.grey[100],
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 12.0),
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight - (appBar.preferredSize.height + ScreenUtil().statusBarHeight),
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
          Observer(builder: (_) {
            return Text(
              controller.enderecoSelecionado?.endereco ?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCategorias() {
    return FutureBuilder<List<CategoriaModel>>(
        future: controller.categoriasFuture,
        builder: (context, snapshot) {
          print(snapshot.connectionState.toString());
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active:
              return Container();
              break;
            case ConnectionState.done:
              if (!snapshot.hasData) {
                return Container();
              }

              if (snapshot.hasError) {
                return Container(child: Text("Erro ao buscar a categoria"));
              }

              var cats = snapshot.data;
              return Container(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cats.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var cat  = cats[index];
                    return Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: ThemeUtils.primaryColorLight,
                            child: Icon(
                              categoriasIcons[cat.tipo],
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(cat.nome)
                        ],
                      ),
                    );
                  },
                ),
              );
              break;

            default:
              return Container();
              break;
          }
        });
  }

  Widget _buildEstabelecimentos() {
    return Container(
      child: Column(
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
      ),
    );
  }

  Widget _buildEstabelecimentosLista() {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              Container(
                width: ScreenUtil().screenWidth,
                margin: EdgeInsets.only(left: 30),
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Petshop x "),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16, color: Colors.grey[500]),
                              Text("20km de distância"),
                            ],
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: CircleAvatar(
                          maxRadius: 15,
                          backgroundColor: ThemeUtils.primaryColor,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Colors.grey[100],
                        width: 5,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://petshopcontrol.blob.core.windows.net/blog/blog/wp-content/uploads/fachada-pet.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent, width: 1),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, index) => Divider(color: Colors.transparent),
    );
  }

  Widget _buildEstabelecimentosGrid() {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
        ),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.only(
                  top: 40,
                  left: 10,
                  right: 10,
                ),
                elevation: 5,
                child: Container(
                  width: double.infinity,
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("PET X", style: ThemeUtils.theme.textTheme.subtitle2),
                          Text("20km de distancia"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[200],
                ),
              ),
              Positioned(
                top: 4,
                left: 0,
                right: 0,
                child: Center(
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                      'https://petshopcontrol.blob.core.windows.net/blog/blog/wp-content/uploads/fachada-pet.png',
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
