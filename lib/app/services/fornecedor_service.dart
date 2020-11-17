import 'package:cuidapetcurso/app/models/endereco_model.dart';
import 'package:cuidapetcurso/app/models/fornecedor_model.dart';
import 'package:cuidapetcurso/app/repository/fornecedor_repository.dart';

class FornecedorService {
  final FornecedorRepository _repository;
  FornecedorService(
    this._repository,
  );

  Future<List<FornecedorBuscaModel>> buscarFornecedoresProximos(EnderecoModel endereco)   {
    return    _repository.buscarFornecedoresProximos(endereco.latitude, endereco.longitude);
  }
}
