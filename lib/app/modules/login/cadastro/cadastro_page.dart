import 'package:cuidapetcurso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cadastro_controller.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends ModularState<CadastroPage, CadastroController> {
  Widget _buildForm() {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
            key: controller.formKey,
            child: Column(children: [
              TextFormField(
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Login obrigatório';
                  } else if (!value.contains('@')) {
                    return 'E-mail inválido';
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
                  obscureText: controller.obscureTextSenha,
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
              SizedBox(
                height: 20,
              ),
              Observer(builder: (_) {
                return TextFormField(
                  obscureText: controller.obscureTextConfirmarSenha,
                  obscuringCharacter: 'x',
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Confirma senha obrigatória';
                    } else if (value.length < 6) {
                      return 'Confirma senha com 6 dígitos é obrigatório';
                    } else if (value.compareTo(controller.senhaController.text) != 0) {
                      return 'Senhas não conferem';
                    } else {
                      return null;
                    }
                  },
                  controller: controller.senhaConferirController,
                  decoration: InputDecoration(suffixIcon: IconButton(icon: Icon(Icons.lock), onPressed: () => controller.mostrarSenhaUsuarioConfirmar()), labelText: "Confirmar senha", border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), gapPadding: 0), labelStyle: TextStyle(fontSize: 15)),
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
                      "Cadastrar",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () async {
                      controller.cadastrarUsuario();
                    }),
              )
            ])));
  }

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
}
