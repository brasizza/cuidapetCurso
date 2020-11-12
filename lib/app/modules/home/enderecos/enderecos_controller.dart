import 'package:cuidapetcurso/app/models/endereco_model.dart';
import 'package:cuidapetcurso/app/repository/shared_prefs_repository.dart';
import 'package:cuidapetcurso/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mobx/mobx.dart';

import 'package:cuidapetcurso/app/services/enderecos_service.dart';

part 'enderecos_controller.g.dart';


@Injectable()
class EnderecosController = _EnderecosControllerBase with _$EnderecosController;

abstract class _EnderecosControllerBase with Store {
  FocusNode enderecoFocusNode = FocusNode();
  final EnderecoService _enderecoService;
  _EnderecosControllerBase(
    this._enderecoService,
  );
  @observable
  ObservableFuture<List<EnderecoModel>> enderecosFuture;
  TextEditingController enderecoTextController = TextEditingController();
  Future<List<Prediction>> buscarEnderecos(String endereco) {
    return _enderecoService.buscarEnderecosGooglePlaces(endereco);
  }

  @action
  void buscarEnderecosCadastrados() {
    enderecosFuture = ObservableFuture(_enderecoService.buscarEnderecosCadastrados());
  }

  @action
  Future<void> selecionarEndereco(EnderecoModel model) async {
    await (await SharedPrefsRepository.instance).registrarEnderecoSelecionado(model);
    Modular.to.pop();
  }

  

Future<bool> enderecoFoiSelecionado()  async {
    var prefs = await SharedPrefsRepository.instance;
   return (prefs.enderecoSelecionado != null );

  }


  @action
  Future<void> enviarDetalhe(Prediction pred) async {
    Loader.show();
    var resultado = await _enderecoService.buscarDetalheEnderecoGooglePlaces(pred.placeId);
    var detalhe = resultado.result;
    var enderecoModel = EnderecoModel(id: null, endereco: detalhe.formattedAddress, latitude: detalhe.geometry.location.lat, longitude: detalhe.geometry.location.lng, complemento: null);
    Loader.hide();
    var enderecoEdicao = await Modular.to.pushNamed('/home/enderecos/detalhe', arguments: enderecoModel) as EnderecoModel;
    verificaEdicaoEndereco(enderecoEdicao);
  }

  @action
  Future<void> minhaLocalizacao() async {
    Loader.show();
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
    var endereco = placemark.first.street;
    var enderecoModel = EnderecoModel(id: null, endereco: endereco, latitude: position.latitude, longitude: position.longitude, complemento: null);
    Loader.hide();
    var enderecoEdicao = await Modular.to.pushNamed('/home/enderecos/detalhe', arguments: enderecoModel) as EnderecoModel;
    verificaEdicaoEndereco(enderecoEdicao);
  }

  @action
  void verificaEdicaoEndereco(EnderecoModel enderecoEdicao) {
    if (enderecoEdicao == null) {
      enderecoTextController.clear();
      buscarEnderecosCadastrados();
    } else {
      enderecoTextController.text = enderecoEdicao.endereco;
      enderecoFocusNode.requestFocus();
    }
  }
}
