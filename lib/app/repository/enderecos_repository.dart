import 'package:cuidapetcurso/app/core/database/connection.dart';
import 'package:cuidapetcurso/app/models/endereco_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_webservice/places.dart';

class EnderecoRepository {
  Future<List<EnderecoModel>> buscarEnderecos() async {
    final conn = await Connection().instance;
    var result = await conn.rawQuery("Select * from endereco");
    return  result.map((e) => EnderecoModel.fromMap(e)).toList();
  }

  Future<void> salvarEndereco(EnderecoModel enderecoModel) async {
    final conn = await Connection().instance;
    await conn.rawInsert("Insert into endereco values (?,?,?,?,?) ", [null, enderecoModel.endereco, enderecoModel.latitude, enderecoModel.longitude, enderecoModel.complemento]);
  }

  Future<void> limparEnderecosCadastrados() async {
    final conn = await Connection().instance;
    conn.rawDelete("Delete from endereco");
  }

Future<PlacesDetailsResponse> recuperarDetalheEnderecoGooglePlaces(String placeId) async{
    final places = GoogleMapsPlaces(apiKey: DotEnv().env['googleApiKey']);
    return await places.getDetailsByPlaceId(placeId);
}

  Future<List<Prediction>> buscarEnderecoGooglePlaces(String endereco) async {
    final places = GoogleMapsPlaces(apiKey: DotEnv().env['googleApiKey']);
    var response =  await places.autocomplete(endereco, language: 'pt');
    return response.predictions;


  }
}
