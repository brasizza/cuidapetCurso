import 'package:cuidapetcurso/app/core/dio/custom_dio.dart';
import 'package:cuidapetcurso/app/models/access_token_model.dart';

class UsuarioRepository {
  Future<AccessTokenModel> login(String email, {String password, bool facebookLogin = false, String avatar}) {
    CustomDio.instance.post('/login', data: 
    {
      'login': email,
     'senha': password, 
     'facebookLogin': facebookLogin, 
     'avatar': avatar
     }
    ).then((response) {
      AccessTokenModel.fromJson(response.data);
    });
  }
}
