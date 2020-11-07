import 'package:cuidapetcurso/app/shared/components/facebook_button.dart';
import 'package:cuidapetcurso/app/shared/theme_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtils.primaryColor,
      body: Container(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          child: Stack(
            children: [
              Container(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenHeight < 700 ? 800 : ScreenUtil().screenHeight * .95,
                decoration: BoxDecoration(
                  image: new DecorationImage(image: AssetImage('lib/assets/images/login_background.png'), fit: BoxFit.fill),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top:  ScreenUtil().statusBarHeight + 10),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Image.asset(
                        'lib/assets/images/logo.png',
                        width: ScreenUtil().setWidth(400),
                        fit: BoxFit.fill,
                      ),
                      _buildForm()
                    ],
                  ))
            ],
          )),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Login", border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), gapPadding: 0), labelStyle: TextStyle(fontSize: 15)),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Senha", border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), gapPadding: 0), labelStyle: TextStyle(fontSize: 15)),
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: 60,
              width: ScreenUtil().screenWidth,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: ThemeUtils.primaryColor,
                  child: Text(
                    "Entrar",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onPressed: () {
                    FacebookLogin().logIn(['public_profile', 'email']);
                  // FirebaseAuth.instance.createUserWithEmailAndPassword(email: 'mvbdesenvolvimento@gmail.com', password: '123456');

                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: ThemeUtils.primaryColor,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("ou",
                    style: TextStyle(

                      fontWeight: FontWeight.bold,
                      fontSize:20,
                      color:ThemeUtils.primaryColor
                    ),
                    
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: ThemeUtils.primaryColor,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),
            FacebookButton(),
            FlatButton(onPressed: (){}, child: Text("Cadastre-se"))
          ],
        ),
      ),
    );
  }
}
