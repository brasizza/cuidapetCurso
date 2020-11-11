import 'package:cuidapetcurso/app/core/database/connection.dart';
import 'package:cuidapetcurso/app/core/dio/custom_dio.dart';
import 'package:cuidapetcurso/app/shared/components/facebook_button.dart';
import 'package:cuidapetcurso/app/shared/theme_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
                  margin: EdgeInsets.only(top: ScreenUtil().statusBarHeight + 10),
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
        key: controller.formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Login obrigatório';
                } else {
                  return null;
                }
              },
              controller: controller.loginController,
              decoration: InputDecoration(labelText: "Login", border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), gapPadding: 0), labelStyle: TextStyle(fontSize: 15)),
            ),
            SizedBox(
              height: 20,
            ),
            Observer(builder: (_) {
              return TextFormField(
                obscureText: controller.obscureText,
                obscuringCharacter: 'x',
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Senha obrigatória';
                  } else if (value.length < 6) {
                    return 'Senha com 6 dígitos é obrigatório';
                  } else {
                    return null;
                  }
                },
                controller: controller.senhaController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.lock),
                      onPressed: () => controller.mostrarSenhaUsuario(),
                    ),
                    labelText: "Senha",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), gapPadding: 0),
                    labelStyle: TextStyle(fontSize: 15)),
              );
            }),
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
                  onPressed: () async {
                    controller.login();
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
                    child: Text(
                      "ou",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: ThemeUtils.primaryColor),
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
            FacebookButton(
              onTap: () {
                controller.facebookLogin();
              },
            ),
            FlatButton(onPressed: () => Modular.to.pushNamed('/login/cadastro'), child: Text("Cadastre-se"))
          ],
        ),
      ),
    );
  }
}
