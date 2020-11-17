import 'package:cuidapetcurso/app/models/categoria_model.dart';
import 'package:cuidapetcurso/app/models/endereco_model.dart';
import 'package:cuidapetcurso/app/models/fornecedor_model.dart';
import 'package:cuidapetcurso/app/repository/shared_prefs_repository.dart';
import 'package:cuidapetcurso/app/services/categoria_service.dart';
import 'package:cuidapetcurso/app/services/fornecedor_service.dart';
import 'package:flutter/material.dart';
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
  final FornecedorService _fornecedorService;
  final TextEditingController filtroNomeController = TextEditingController();

  @observable
  int categoriaSelecionada ;



  _HomeControllerBase(this._enderecoService, this._categoriaService, this._fornecedorService);

  @observable
  ObservableFuture<List<CategoriaModel>> categoriasFuture;

  @observable
  ObservableFuture<List<FornecedorBuscaModel>> estabelecimentosFuture;

  @observable
  List<FornecedorBuscaModel> estabelecimentosOriginais;

  @action
  Future<void> initPage() async {
    await temEnderecoCadastrado();
    await recuperarEnderecoSelecionado();
    buscarCategorias();
    buscarEstabelecimentos();
  }

  @observable
  int paginaSelecionada = 0;
  @action
  void alterarPaginaSelecionada(int pagina) => paginaSelecionada = pagina;

  @action
  void buscarCategorias() {
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
    try {
      enderecoSelecionado = prefs.enderecoSelecionado;
    } catch (e) {
      print(e.toString());
    }
  }

  @action
  Future<void> buscarEstabelecimentos() async {
    categoriaSelecionada = null;
    filtroNomeController.clear();
    estabelecimentosFuture = ObservableFuture(_fornecedorService.buscarFornecedoresProximos(enderecoSelecionado));
    estabelecimentosOriginais = await estabelecimentosFuture;
  }

  @action
  void filtrarPorCategoria(int id) {
    if (categoriaSelecionada == id) {
      categoriaSelecionada = null;
    } else {
      categoriaSelecionada = id;
    }
    _filtrarEstabelecimento();
  }

  @action
  void filtrarEstabelecimentoPorNome() {
    _filtrarEstabelecimento();
  }

  @action
  void _filtrarEstabelecimento() {
    var fornecedores = estabelecimentosOriginais;
    if (categoriaSelecionada != null) {
      fornecedores = fornecedores.where((element) => element.categoria.id == categoriaSelecionada).toList();
    }

    if (filtroNomeController.text.isNotEmpty) {
      fornecedores = fornecedores.where((element) => element.nome.toLowerCase().contains(filtroNomeController.text.toLowerCase())).toList();
    }

    estabelecimentosFuture = ObservableFuture(Future.value(fornecedores));
  }
}
