import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository{

static SharedPreferences prefs;
static SharedPrefsRepository _instanceRepository;


SharedPrefsRepository._();


static Future<SharedPrefsRepository> get instance async{
  prefs ??= await SharedPreferences.getInstance() ;
  _instanceRepository ??= SharedPrefsRepository._();
  return _instanceRepository;
}
  

}