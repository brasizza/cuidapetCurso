import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:cuidapetcurso/app/services/enderecos_service.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {


  final EnderecoService _enderecoService;

  _HomeControllerBase(
    this._enderecoService,
  );

@action
  Future<void> initPage() async {
      await temEnderecoCadastrado();
  }

  Future<void> temEnderecoCadastrado() async {
  var temEndereco =  await  _enderecoService.existeEnderecoCadastrado();

  if(!temEndereco){
    await Modular.to.pushNamed('/home/enderecos');
  }
  }
  
}
