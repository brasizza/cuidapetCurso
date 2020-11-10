import 'package:dio/dio.dart';

class AcessoNegadoException extends DioError {
  String mensagem;

  AcessoNegadoException(this.mensagem, {DioError ecxception}) : super(request: ecxception.request, response: ecxception.response, type: ecxception.type, error: ecxception.error);

  @override
  String toString() => 'AcessoNegadoException(mensagem: $mensagem)';
}
