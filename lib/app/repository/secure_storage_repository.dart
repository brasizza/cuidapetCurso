import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageRepository {
  static const  REFRESH_TOKEN = '/REFRESH_TOKEN/';
  

  void registerRefreshToken(String token){
    final store = FlutterSecureStorage();
    store.write(key: REFRESH_TOKEN, value: token);
  }

  Future<String> get refreshToken async{
        final store = FlutterSecureStorage();
        return await  store.read(key: REFRESH_TOKEN);

  }

}
