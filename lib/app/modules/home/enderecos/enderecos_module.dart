import 'package:cuidapetcurso/app/modules/home/enderecos/detalhe/detalhe_page.dart';

import 'detalhe/detalhe_controller.dart';
import 'enderecos_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'enderecos_page.dart';

class EnderecosModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $DetalheController,
        $EnderecosController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => EnderecosPage()),

             ModularRouter('/detalhe',
            child: (_, args) => DetalhePage( enderecoModel: args.data,)),
      ];

  static Inject get to => Inject<EnderecosModule>.of();
}
