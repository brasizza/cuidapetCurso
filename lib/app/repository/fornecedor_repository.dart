import 'package:cuidapetcurso/app/core/dio/custom_dio.dart';
import 'package:cuidapetcurso/app/models/fornecedor_model.dart';

class FornecedorRepository {
  Future<List<FornecedorBuscaModel>> buscarFornecedoresProximos(double lat, double lng) async{
    return  await CustomDio.authInstance.get('/fornecedores', queryParameters: {'lat': lat, 'long': lng}).then((res) =>
     res.data.map<FornecedorBuscaModel>((f) => FornecedorBuscaModel.fromJson(f)).toList());
  }
}
