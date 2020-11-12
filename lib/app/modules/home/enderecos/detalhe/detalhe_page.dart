import 'dart:async';
import 'dart:io';

import 'package:cuidapetcurso/app/models/endereco_model.dart';
import 'package:cuidapetcurso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'detalhe_controller.dart';

class DetalhePage extends StatefulWidget {
  final String title;
  final EnderecoModel enderecoModel;
  const DetalhePage({Key key, @required this.enderecoModel, this.title}) : super(key: key);

  @override
  _DetalhePageState createState() => _DetalhePageState();
}

class _DetalhePageState extends ModularState<DetalhePage, DetalheController> {
  //use 'controller' variable to access controller

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    var model = widget.enderecoModel;
    final appBar = AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: recuperarTamanhoTela(appBar),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: <Widget>[
              Text(
                "Confirme seu endereço ${model.endereco}",
                style: ThemeUtils.theme.textTheme.headline5.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(model.latitude, model.longitude),
                    zoom: 16,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: {
                    Marker(
                      markerId: MarkerId('end'),
                      position: LatLng(model.latitude, model.longitude),
                      infoWindow: InfoWindow(
                        title: model.endereco,
                      ),
                    ),
                  },
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                ),
              ),
              TextFormField(
                initialValue: model.endereco,
                readOnly: false,
                decoration: InputDecoration(
                  labelText: 'Endereço',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => Modular.to.pop(model)
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controller.complementoTextController,
                decoration: InputDecoration(labelText: 'Complemento'),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: ScreenUtil().screenWidth * .9,
                height: 50,
                child: RaisedButton(
                  color: ThemeUtils.primaryColor,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Salvar",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: ()  =>  controller.salvarEndereco(model)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double recuperarTamanhoTela(AppBar appBar) {
    var bottomBar = 0.0;
    if (Platform.isIOS) {
      bottomBar = ScreenUtil().bottomBarHeight;
    }
    return ScreenUtil().screenHeight - (ScreenUtil().statusBarHeight + appBar.preferredSize.height + bottomBar);
  }
}
