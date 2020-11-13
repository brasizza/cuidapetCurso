import 'package:cuidapetcurso/app/models/categoria_model.dart';
import 'package:cuidapetcurso/app/repository/categorias_repository.dart';

class CategoriaService {

final CategoriasRepository _repository;
  CategoriaService(
    this._repository,
  );



  Future<List<CategoriaModel>> buscarCategorias() async {
    return _repository.buscarCategorias();
  }


}
