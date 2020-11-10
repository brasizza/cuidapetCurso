import 'package:cuidapetcurso/app/services/usuario_service.dart';
import 'package:cuidapetcurso/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'cadastro_controller.g.dart';

@Injectable()
class CadastroController = _CadastroControllerBase with _$CadastroController;

abstract class _CadastroControllerBase with Store {
  final UsuarioService _service;

  _CadastroControllerBase(this._service);

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController senhaConferirController = TextEditingController();
  @observable
  bool obscureTextSenha = true;
  @observable
  bool obscureTextConfirmarSenha = true;

  @action
  void mostrarSenhaUsuario() {
    obscureTextSenha = !obscureTextSenha;
  }

  @action
  void mostrarSenhaUsuarioConfirmar() {
    obscureTextConfirmarSenha = !obscureTextConfirmarSenha;
  }

  @action
  Future<void> cadastrarUsuario() async {
    Loader.show();
    if (formKey.currentState.validate()) {
      try {
        await _service.cadastrarUsuario(loginController.text.trim(), senhaController.text);
        Loader.hide();
        Modular.to.pop();
      } on Exception catch (e) {
        Loader.hide();

        Get.snackbar('Erro', 'Erro ao cadastrar usuário');
        print(e.toString());
      }
    }
  }
}
