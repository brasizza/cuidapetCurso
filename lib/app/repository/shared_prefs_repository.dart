import 'dart:convert';

import 'package:cuidapetcurso/app/models/endereco_model.dart';
import 'package:cuidapetcurso/app/models/usuario_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
  static const _ACCESS_TOKEN = '/_ACCESS_TOKEN/';
  static const _DEVICE_ID = '/_DEVIDE_ID/';
  static const _DADOS_USUARIO = '/_DADOS_USUARIO/';
  static const _ENDERECO_SELECIONADO = '/_ENDERECO_SELECIONADO/';

  static SharedPreferences prefs;
  static SharedPrefsRepository _instanceRepository;

  SharedPrefsRepository._();

  static Future<SharedPrefsRepository> get instance async {
    prefs ??= await SharedPreferences.getInstance();
    _instanceRepository ??= SharedPrefsRepository._();
    return _instanceRepository;
  }

  //REGISTER TOKEN
  Future<void> registerAccessToken(String token) async {
    await prefs.setString(_ACCESS_TOKEN, token);
  }

  String get accessToken => prefs.get(_ACCESS_TOKEN);

  //REGISTER DEVICE ID
  void registerDeviceId(String deviceId) async {
    await prefs.setString(_DEVICE_ID, deviceId);
  }

  String get deviceId => prefs.get(_DEVICE_ID);

  //REGISTER DADOS USUARIO
  Future<void> registerDadosUsuario(UsuarioModel usuario) async {
    await prefs.setString(_DADOS_USUARIO, jsonEncode(usuario.toJson()));
  }

  UsuarioModel get dadosUsuario {
    return UsuarioModel.fromJson(jsonDecode(prefs.getString(_DADOS_USUARIO)));
  }

  Future<void> registrarEnderecoSelecionado(EnderecoModel endereco) async {
    await prefs.setString(_ENDERECO_SELECIONADO, (endereco.toJson()));
  }

  EnderecoModel get enderecoSelecionado {
    var enderecoJson = prefs.getString(_ENDERECO_SELECIONADO);
    if(enderecoJson != null){
    return EnderecoModel.fromJson(enderecoJson);

    }
      return null;

  }

  Future<void> logout() async {
    await prefs.clear();
    await Modular.to.pushNamedAndRemoveUntil('/', (_) => false);
  }
}
