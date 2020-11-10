import 'package:cuidapetcurso/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:cuidapetcurso/app/services/usuario_service.dart';
import 'package:cuidapetcurso/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

@Injectable(singleton:false)
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final UsuarioService _service;
  _LoginControllerBase(
    this._service,
  );

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  @observable
  bool obscureText = true;

  @action
  void mostrarSenhaUsuario() {
    obscureText = !obscureText;
  }

  @action
  Future<void> login() async {
    if (formKey.currentState.validate()) {
      try {
        Loader.show();
        await _service.login(false, email: loginController.text, password: senhaController.text);
        Loader.hide();
        Modular.to.pushNamedAndRemoveUntil('/', (_) => false);
      } on AcessoNegadoException catch (e) {
        print(e);
        Loader.hide();

        Get.snackbar('Erro', e.mensagem);
      } on Exception catch (e) {
        Loader.hide();

        Get.snackbar('Erro', 'Erro ao realizar o login');
      }
    } else {}
  }

  void facebookLogin() async {
    try {
      Loader.show();
      await _service.login(true);
      Loader.hide();

      Modular.to.pushNamedAndRemoveUntil('/', (_) => false);
    } on AcessoNegadoException catch (e) {
      print(e);
      Loader.hide();

      Get.snackbar('Erro', e.mensagem);
    } on Exception catch (e) {
            print(e);

      Loader.hide();

      Get.snackbar('Erro', 'Erro ao realizar o login');
    }
  }
}
