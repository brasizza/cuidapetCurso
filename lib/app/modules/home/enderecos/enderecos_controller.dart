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
  final EnderecoService _enderecoService;
_EnderecosControllerBase(
    this._enderecoService,
  );

  TextEditingController enderecoTextController = TextEditingController();
  Future<List<Prediction>> buscarEnderecos(String endereco) {
    return _enderecoService.buscarEnderecosGooglePlaces(endereco);
  }

  Future<void> minhaLocalizacao() async {
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  var placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
  print(placemark);
  }

}
