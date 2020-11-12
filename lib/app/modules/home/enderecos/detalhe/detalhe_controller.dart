import 'package:cuidapetcurso/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

import 'package:cuidapetcurso/app/models/endereco_model.dart';
import 'package:cuidapetcurso/app/services/enderecos_service.dart';

part 'detalhe_controller.g.dart';

@Injectable()
class DetalheController = _DetalheControllerBase with _$DetalheController;

abstract class _DetalheControllerBase with Store {
  


TextEditingController complementoTextController = TextEditingController();
final EnderecoService _service;
  _DetalheControllerBase(
    this._service,
  );

Future<void> salvarEndereco(EnderecoModel model) async {
  Loader.show();
  try {
    model.complemento = complementoTextController.text;
    await _service.salvarEndereco(model);
    Loader.hide();
    Modular.to.pop();
  } on Exception catch (e) {
    print(e);
    Loader.hide();
    Get.snackbar("Erro", 'Erro ao salvar o endereço');
  }
}
}
