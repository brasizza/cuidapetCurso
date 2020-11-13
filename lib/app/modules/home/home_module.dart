
import 'package:cuidapetcurso/app/modules/home/enderecos/enderecos_module.dart';
import 'package:cuidapetcurso/app/repository/categorias_repository.dart';
import 'package:cuidapetcurso/app/services/categoria_service.dart';

import 'home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i)=>CategoriasRepository()),
        Bind((i)=>CategoriaService(i.get())),
        $HomeController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
        ModularRouter('/enderecos',module: EnderecosModule()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
