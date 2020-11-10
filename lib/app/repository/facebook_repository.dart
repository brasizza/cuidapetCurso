import 'dart:convert';

import 'package:cuidapetcurso/app/core/dio/custom_dio.dart';
import 'package:cuidapetcurso/app/models/facebook_model.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FacebookRepository {
  Future<FacebookModel> login() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['public_profile', 'email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        var url = 'https://graph.facebook.com/v4.0/me?fields=name,first_name,last_name,email,picture&access_token=$token';
        print(url);
        final resultFacebook = await CustomDio.instance.get(url);
        var model = FacebookModel.fromJson(json.decode(resultFacebook.data));
        model.token = token;
        return model;
        // model.largeImage = 'https://graph.facebook.com/${model.id}/picture?type=large';
        break;
      case FacebookLoginStatus.cancelledByUser:
        return null;
        break;
      case FacebookLoginStatus.error:
        throw Exception(result.errorMessage);

      default:
      return null;
      break;
    }
  }
}
