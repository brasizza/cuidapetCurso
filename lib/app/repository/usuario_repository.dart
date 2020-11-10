import 'dart:io';

import 'package:cuidapetcurso/app/core/dio/custom_dio.dart';
import 'package:cuidapetcurso/app/models/access_token_model.dart';
import 'package:cuidapetcurso/app/models/confirm_login_model.dart';
import 'package:cuidapetcurso/app/models/usuario_model.dart';
import 'package:cuidapetcurso/app/repository/shared_prefs_repository.dart';

class UsuarioRepository {
  Future<AccessTokenModel> login(String email, {String password, bool facebookLogin = false, String avatar}) async {
    return CustomDio.instance.post('/login', data: {'login': email, 'senha': password, 'facebookLogin': facebookLogin, 'avatar': avatar}).then((response) {
      return AccessTokenModel.fromJson(response.data);
    });
  }

  Future<ConfirmLoginModel> confirmLogin() async {
    final prefs = await SharedPrefsRepository.instance;
    final deviceId = prefs.deviceId;
    Map<String, String> dadosConfirmar = Map();
    if (Platform.isIOS) {
      dadosConfirmar['ios_token'] = deviceId;
    } else if (Platform.isAndroid) {
      dadosConfirmar['android_token'] = deviceId;
    }
    return CustomDio.authInstance.patch('/login/confirmar', data: dadosConfirmar).then((response) => ConfirmLoginModel.fromJson(response.data));
  }

  Future<UsuarioModel> recuperaDadosUsuarioLogado() async {
    return CustomDio.authInstance.get('/usuario').then((res) => UsuarioModel.fromJson(res.data));
  }


  Future<void> cadastrarUsuario(String email, String senha) async {
    await CustomDio.instance.post('/login/cadastrar' , data:{
      'email': email,
      'senha' : senha
    });
  }
}
