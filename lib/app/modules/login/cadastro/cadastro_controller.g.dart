// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $CadastroController = BindInject(
  (i) => CadastroController(i<UsuarioService>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CadastroController on _CadastroControllerBase, Store {
  final _$obscureTextSenhaAtom =
      Atom(name: '_CadastroControllerBase.obscureTextSenha');

  @override
  bool get obscureTextSenha {
    _$obscureTextSenhaAtom.reportRead();
    return super.obscureTextSenha;
  }

  @override
  set obscureTextSenha(bool value) {
    _$obscureTextSenhaAtom.reportWrite(value, super.obscureTextSenha, () {
      super.obscureTextSenha = value;
    });
  }

  final _$obscureTextConfirmarSenhaAtom =
      Atom(name: '_CadastroControllerBase.obscureTextConfirmarSenha');

  @override
  bool get obscureTextConfirmarSenha {
    _$obscureTextConfirmarSenhaAtom.reportRead();
    return super.obscureTextConfirmarSenha;
  }

  @override
  set obscureTextConfirmarSenha(bool value) {
    _$obscureTextConfirmarSenhaAtom
        .reportWrite(value, super.obscureTextConfirmarSenha, () {
      super.obscureTextConfirmarSenha = value;
    });
  }

  final _$cadastrarUsuarioAsyncAction =
      AsyncAction('_CadastroControllerBase.cadastrarUsuario');

  @override
  Future<void> cadastrarUsuario() {
    return _$cadastrarUsuarioAsyncAction.run(() => super.cadastrarUsuario());
  }

  final _$_CadastroControllerBaseActionController =
      ActionController(name: '_CadastroControllerBase');

  @override
  void mostrarSenhaUsuario() {
    final _$actionInfo = _$_CadastroControllerBaseActionController.startAction(
        name: '_CadastroControllerBase.mostrarSenhaUsuario');
    try {
      return super.mostrarSenhaUsuario();
    } finally {
      _$_CadastroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void mostrarSenhaUsuarioConfirmar() {
    final _$actionInfo = _$_CadastroControllerBaseActionController.startAction(
        name: '_CadastroControllerBase.mostrarSenhaUsuarioConfirmar');
    try {
      return super.mostrarSenhaUsuarioConfirmar();
    } finally {
      _$_CadastroControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
obscureTextSenha: ${obscureTextSenha},
obscureTextConfirmarSenha: ${obscureTextConfirmarSenha}
    ''';
  }
}
