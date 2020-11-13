import 'package:cuidapetcurso/app/models/categoria_model.dart';
import 'package:cuidapetcurso/app/models/endereco_model.dart';
import 'package:cuidapetcurso/app/repository/shared_prefs_repository.dart';
import 'package:cuidapetcurso/app/services/categoria_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:cuidapetcurso/app/services/enderecos_service.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  EnderecoModel enderecoSelecionado;
  final CategoriaService _categoriaService;

  final EnderecoService _enderecoService;

  _HomeControllerBase(
    this._enderecoService,
    this._categoriaService,
  );

  @observable
  ObservableFuture<List<CategoriaModel>> categoriasFuture;

  @action
  Future<void> initPage() async {
    try {
       await  buscarCategorias();

      await temEnderecoCadastrado();

       await recuperarEnderecoSelecionado();



    } on Exception catch (e) {

      print(e);
    }
  }

  @action
  Future<void> buscarCategorias()   async {
    categoriasFuture = ObservableFuture(_categoriaService.buscarCategorias());
  }

  @action
  Future<void> temEnderecoCadastrado() async {
    var temEndereco = await _enderecoService.existeEnderecoCadastrado();

    if (!temEndereco) {
      await Modular.to.pushNamed('/home/enderecos');
    }
  }
  @action
  Future<void> recuperarEnderecoSelecionado() async {
    var prefs = await SharedPrefsRepository.instance;
    try{
    enderecoSelecionado = prefs.enderecoSelecionado;
    }catch(e){
      print(e.toString());
    }
  }
}
