// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $HomeController = BindInject(
  (i) => HomeController(i<EnderecoService>(), i<CategoriaService>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$enderecoSelecionadoAtom =
      Atom(name: '_HomeControllerBase.enderecoSelecionado');

  @override
  EnderecoModel get enderecoSelecionado {
    _$enderecoSelecionadoAtom.reportRead();
    return super.enderecoSelecionado;
  }

  @override
  set enderecoSelecionado(EnderecoModel value) {
    _$enderecoSelecionadoAtom.reportWrite(value, super.enderecoSelecionado, () {
      super.enderecoSelecionado = value;
    });
  }

  final _$categoriasFutureAtom =
      Atom(name: '_HomeControllerBase.categoriasFuture');

  @override
  ObservableFuture<List<CategoriaModel>> get categoriasFuture {
    _$categoriasFutureAtom.reportRead();
    return super.categoriasFuture;
  }

  @override
  set categoriasFuture(ObservableFuture<List<CategoriaModel>> value) {
    _$categoriasFutureAtom.reportWrite(value, super.categoriasFuture, () {
      super.categoriasFuture = value;
    });
  }

  final _$initPageAsyncAction = AsyncAction('_HomeControllerBase.initPage');

  @override
  Future<void> initPage() {
    return _$initPageAsyncAction.run(() => super.initPage());
  }

  final _$buscarCategoriasAsyncAction =
      AsyncAction('_HomeControllerBase.buscarCategorias');

  @override
  Future<void> buscarCategorias() {
    return _$buscarCategoriasAsyncAction.run(() => super.buscarCategorias());
  }

  final _$temEnderecoCadastradoAsyncAction =
      AsyncAction('_HomeControllerBase.temEnderecoCadastrado');

  @override
  Future<void> temEnderecoCadastrado() {
    return _$temEnderecoCadastradoAsyncAction
        .run(() => super.temEnderecoCadastrado());
  }

  final _$recuperarEnderecoSelecionadoAsyncAction =
      AsyncAction('_HomeControllerBase.recuperarEnderecoSelecionado');

  @override
  Future<void> recuperarEnderecoSelecionado() {
    return _$recuperarEnderecoSelecionadoAsyncAction
        .run(() => super.recuperarEnderecoSelecionado());
  }

  @override
  String toString() {
    return '''
enderecoSelecionado: ${enderecoSelecionado},
categoriasFuture: ${categoriasFuture}
    ''';
  }
}
