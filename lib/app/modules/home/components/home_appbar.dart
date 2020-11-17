import 'package:cuidapetcurso/app/modules/home/home_controller.dart';
import 'package:cuidapetcurso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppBar extends PreferredSize {
  final HomeController controller;
  HomeAppBar(this.controller)
      : super(
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
                  onPressed: () async {
                    await Modular.to.pushNamed('/home/enderecos');
                    await controller.recuperarEnderecoSelecionado();
                    await controller.buscarEstabelecimentos();
                  },
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
                        child: Observer(builder: (_) {
                          return TextFormField(
                            onChanged: (_) => controller.filtrarEstabelecimentoPorNome(),
                            controller: controller.filtroNomeController,
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
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ));
}
