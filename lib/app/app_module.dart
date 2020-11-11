import 'package:cuidapetcurso/app/core/database/connection.dart';
import 'package:cuidapetcurso/app/core/database/connection_adm.dart';
import 'package:cuidapetcurso/app/modules/home/home_module.dart';
import 'package:cuidapetcurso/app/modules/login/login_module.dart';
import 'package:cuidapetcurso/app/modules/main_page/main_page.dart';
import 'package:cuidapetcurso/app/repository/enderecos_repository.dart';
import 'package:cuidapetcurso/app/repository/usuario_repository.dart';
import 'package:cuidapetcurso/app/services/enderecos_service.dart';
import 'package:cuidapetcurso/app/services/usuario_service.dart';
import 'package:cuidapetcurso/app/shared/auth_store.dart';

import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:cuidapetcurso/app/app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        $AppController,
        Bind((i) => ConnectionADM(), lazy: false),
        Bind((i) => UsuarioRepository()),
        Bind((i) => UsuarioService(i.get())),
        Bind((i) => EnderecoRepository()),
        Bind((i) => EnderecoService(i.get())),
        Bind((i) => AuthStore()),

      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,child: (context,arg) => MainPage()),
        ModularRouter('/home', module: HomeModule()),
        ModularRouter('/login', module: LoginModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
