import 'package:cuidapetcurso/app/models/endereco_model.dart';
import 'package:cuidapetcurso/app/repository/enderecos_repository.dart';
import 'package:google_maps_webservice/places.dart';

class EnderecoService {
  EnderecoRepository _repository;

  EnderecoService(
    this._repository,
  );

  get buscarEnderecos => null;


  Future<bool> existeEnderecoCadastrado() async => (await _repository.buscarEnderecos()).isNotEmpty;


  Future<List<Prediction>> buscarEnderecosGooglePlaces(String endereco) async {
   return await  _repository.buscarEnderecoGooglePlaces(endereco);
  }

  Future<void> salvarEndereco(EnderecoModel endereco) async{
   await  _repository.salvarEndereco(endereco);


  }

  Future<List<EnderecoModel>> buscarEnderecosCadastrados() async {
    return await _repository.buscarEnderecos();
  }

  Future<PlacesDetailsResponse> buscarDetalheEnderecoGooglePlaces(String placeId) async{
   return  await _repository.recuperarDetalheEnderecoGooglePlaces(placeId);
  }
}
