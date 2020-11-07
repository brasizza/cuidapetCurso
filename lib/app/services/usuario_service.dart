import 'package:cuidapetcurso/app/repository/usuario_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UsuarioService {
  final UsuarioRepository _repository;
  UsuarioService(
    this._repository,
  );

  login(String email, {String password, bool facebookLogin = false, String avatar}) async {
    try {
      final accessToken = await _repository.login(email, password: password, facebookLogin: facebookLogin, avatar: avatar);
      if (facebookLogin) {
      } else {
        var result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        
      }
    } on PlatformException catch (e) {
      print("Erro ao fazer o login no firebase $e");
    } catch (e) {
      print("Erro ao fazer o login $e");
      rethrow;
    }
  }
}
