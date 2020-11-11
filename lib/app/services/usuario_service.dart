import 'package:cuidapetcurso/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:cuidapetcurso/app/models/access_token_model.dart';
import 'package:cuidapetcurso/app/repository/facebook_repository.dart';
import 'package:cuidapetcurso/app/repository/secure_storage_repository.dart';
import 'package:cuidapetcurso/app/repository/shared_prefs_repository.dart';
import 'package:cuidapetcurso/app/repository/usuario_repository.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UsuarioService {
  final UsuarioRepository _repository;
  UsuarioService(
    this._repository,
  );

  login(
    bool facebookLogin, {
    String email,
    String password,
  }) async {
    try {
      final prefs = await SharedPrefsRepository.instance;
      final fireAuth = FirebaseAuth.instance;
      AccessTokenModel accessTokenModel;
      if (facebookLogin) {
        var facebookModel = await FacebookRepository().login();
        if (facebookModel != null) {
          accessTokenModel = await _repository.login(facebookModel.email, facebookLogin: facebookLogin, avatar: facebookModel.picture);
          prefs.registerAccessToken(accessTokenModel.accessToken);

          final facebookCredential = FacebookAuthProvider.getCredential(accessToken: facebookModel.token);
          await fireAuth.signInWithCredential(facebookCredential);
        } else {
          throw AcessoNegadoException('Acesso negado');
        }
      } else {
        accessTokenModel = await _repository.login(email, password: password, facebookLogin: facebookLogin, avatar: '');
        prefs.registerAccessToken(accessTokenModel.accessToken);

        fireAuth.signInWithEmailAndPassword(email: email, password: password);
      }

      final confirmModel = await _repository.confirmLogin();
      prefs.registerAccessToken(confirmModel.accessToken);
      await SecureStorageRepository().registerRefreshToken(confirmModel.accessToken);
      final dadosUsuario = await _repository.recuperaDadosUsuarioLogado();
      await prefs.registetrDadosUsuario(dadosUsuario);
    } on PlatformException catch (e) {
      print("Erro ao fazer o login no firebase $e");
      rethrow;
    } on DioError catch (e) {
      if (e.response.statusCode == 403) {
        throw AcessoNegadoException(e.response.data['message'], ecxception: e);
      }
      rethrow;
    } catch (e) {
      print("Erro ao fazer o login $e");
      rethrow;
    }
  }

  Future<void> cadastrarUsuario(String email, String senha) async {
    await _repository.cadastrarUsuario(email, senha);
    var fireAuth = FirebaseAuth.instance;
    await fireAuth.createUserWithEmailAndPassword(email: email, password: senha);
  }
}
