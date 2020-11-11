import 'package:cuidapetcurso/app/repository/enderecos_repository.dart';
import 'package:google_maps_webservice/places.dart';

class EnderecoService {
  EnderecoRepository _repository;

  EnderecoService(
    this._repository,
  );


  Future<bool> existeEnderecoCadastrado() async => (await _repository.buscarEnderecos()).isNotEmpty;


  Future<List<Prediction>> buscarEnderecosGooglePlaces(String endereco) async {
   return await  _repository.buscarEnderecoGooglePlaces(endereco);
  }
}
