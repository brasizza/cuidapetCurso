import 'dart:convert';

import 'package:cuidapetcurso/app/models/usuario_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
  static const _ACCESS_TOKEN = '/_ACCESS_TOKEN/';
  static const _DEVICE_ID = '/_DEVIDE_ID/';
  static const _DADOS_USUARIO = '/_DADOS_USUARIO/';

  static SharedPreferences prefs;
  static SharedPrefsRepository _instanceRepository;

  SharedPrefsRepository._();

  static Future<SharedPrefsRepository> get instance async {
    prefs ??= await SharedPreferences.getInstance();
    _instanceRepository ??= SharedPrefsRepository._();
    return _instanceRepository;
  }

  //REGISTER TOKEN
  void registerAccessToken(String token) async {
    await prefs.setString(_ACCESS_TOKEN, token);
  }

  String get accessToken => prefs.get(_ACCESS_TOKEN);

  //REGISTER DEVICE ID
  void registerDeviceId(String deviceId) async {
    await prefs.setString(_DEVICE_ID, deviceId);
  }

  String get deviceId => prefs.get(_DEVICE_ID);

  //REGISTER DADOS USUARIO
  void registetrDadosUsuario(UsuarioModel usuario) async {
    await prefs.setString(_DADOS_USUARIO, jsonEncode(usuario.toJson()));
  }
  UsuarioModel get dadosUsuario {
    return UsuarioModel.fromJson(jsonDecode(prefs.getString(_DADOS_USUARIO)));
  }
}
