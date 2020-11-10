import 'package:cuidapetcurso/app/repository/shared_prefs_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthInterceptorWrapper extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    var prefs = await  SharedPrefsRepository.instance;
    //Adicionando o token ao shared
     options.headers['Authorization'] =  prefs.accessToken;
    if (DotEnv().env['profile'] == 'dev') {
      print("*************** REQUEST LOG ***************  ");
      print( 'url ${options.uri} ');
      print( 'method ${options.method} ');
      print( 'data ${options.data} ');
      print( 'headers ${options.headers} ');
    }
  }

  @override
  Future onResponse(Response response) async {

      print("*************** RESPONSE LOG ***************  ");
      print( 'data ${response.data} ');

  }
  @override
  Future onError(DioError error) async {
      print("*************** ERROR LOG ***************  ");

    print('error:  ${error.response}' );
    //*Verificar o statusCode


  }
}
