import 'package:cuidapetcurso/app/models/categoria_model.dart';
import 'package:cuidapetcurso/app/modules/home/components/estabelecimento_item_grid.dart';
import 'package:cuidapetcurso/app/modules/home/components/estabelecimento_item_list.dart';
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

  HomeAppBar appBar; // HomeAppBar(controller);
  final categoriasIcons = {'P': Icons.pets, 'V': Icons.local_hospital, 'C': Icons.store_mall_directory};
  final _estabelecimentoPageController = PageController(initialPage: 0);
  _HomePageState() {
    appBar = HomeAppBar(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Colors.grey[100],
      appBar: appBar,
      body:
      RefreshIndicator(child: 
         SingleChildScrollView(
           physics: AlwaysScrollableScrollPhysics(),
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
      )
      
      , onRefresh: ()=>controller.buscarEstabelecimentos())
      ,
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
    return Observer(builder: (_) {
      return FutureBuilder<List<CategoriaModel>>(
          future: controller.categoriasFuture,
          builder: (context, snapshot) {
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
                      var cat = cats[index];
                      return Observer(builder: (_) {
                        return InkWell(
                          onTap: () => controller.filtrarPorCategoria(cat.id),
                          child: Container(
                            margin: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: controller.categoriaSelecionada == cat.id ? ThemeUtils.primaryColor : ThemeUtils.primaryColorLight,
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
                          ),
                        );
                      });
                    },
                  ),
                );
                break;

              default:
                return Container();
                break;
            }
          });
    });
  }

  Widget _buildEstabelecimentos() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Observer(builder: (_) {
              return Row(
                children: [
                  Text("Estabelecimentos"),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      _estabelecimentoPageController.previousPage(duration: Duration(microseconds: 200), curve: Curves.ease);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.view_headline,
                        color: controller.paginaSelecionada == 0 ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _estabelecimentoPageController.nextPage(duration: Duration(microseconds: 200), curve: Curves.ease);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.view_comfy,
                        color: controller.paginaSelecionada == 1 ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
          Expanded(
              child: PageView(

            onPageChanged: (int pagina) {
              controller.alterarPaginaSelecionada(pagina);
            },
            controller: _estabelecimentoPageController,
             physics: NeverScrollableScrollPhysics(),
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
    return Observer(builder: (_) {
      return FutureBuilder(
          future: controller.estabelecimentosFuture,
          builder: (context, snapshot) {
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
                if (snapshot.hasError) {
                  return Container(child: Text("Erro ao buscar a categoria"));
                }

                if (snapshot.hasData) {
                  var fornecs = snapshot.data;
                  return ListView.separated(
                  //  physics: NeverScrollableScrollPhysics(),
                    itemCount: fornecs.length,
                    itemBuilder: (context, index) {
                      var fornec = fornecs[index];
                      return EstabelecimentoItemLista(fornec);
                    },
                    separatorBuilder: (_, index) => Divider(color: Colors.transparent),
                  );
                }else{
                                    return Container(child: Text("Erro ao buscar a categoria"));

                }

                break;
              default:
                return Container();
            }
          });
    });
  }

  Widget _buildEstabelecimentosGrid() {
    return Observer(builder: (_) {
      return FutureBuilder(
          future: controller.estabelecimentosFuture,
          builder: (context, snapshot) {
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
                if (snapshot.hasError) {
                  return Container(child: Text("Erro ao buscar a categoria"));
                }
                if (snapshot.hasData) {
                  var fornecs = snapshot.data;
                  return GridView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                      itemCount: fornecs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.1,
                      ),
                      itemBuilder: (context, index) {
                        var fornec = fornecs[index];
                        return EstabelecimentoItemGrid(fornec);
                      });
                }
                break;
              default:
                return Container();
                break;
            }
          });
    });
  }
}
