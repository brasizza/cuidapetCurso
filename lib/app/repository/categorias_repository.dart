import 'package:cuidapetcurso/app/core/dio/custom_dio.dart';
import 'package:cuidapetcurso/app/models/categoria_model.dart';

class CategoriasRepository {
  Future<List<CategoriaModel>> buscarCategorias()  async {
    var data = await  CustomDio.authInstance.get('/categorias').then((res) => res.data.map<CategoriaModel>((c) => CategoriaModel.fromJson(c)).toList());
    return data;
  }
}
