import 'package:cuidapetcurso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'enderecos_controller.dart';

class EnderecosPage extends StatefulWidget {
  final String title;
  const EnderecosPage({Key key, this.title = "Enderecos"}) : super(key: key);

  @override
  _EnderecosPageState createState() => _EnderecosPageState();
}

class _EnderecosPageState extends ModularState<EnderecosPage, EnderecosController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Text(
                "Adicione ou escolha um endereço",
                style: (ThemeUtils.theme.textTheme.headline5.copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(20),
                  child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: controller.enderecoTextController,
                      decoration: InputDecoration(
                          hintText: "Insira um endereço",
                          prefixIcon: Icon(Icons.location_on, color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(style: BorderStyle.none),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(style: BorderStyle.none),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(style: BorderStyle.none),
                          )),
                    ),
                    itemBuilder: (BuildContext context, Prediction itemData) {
                      return ListTile(

                        leading: Icon(Icons.location_on),
                        title: Text(itemData.description),
                      );
                    },
                    onSuggestionSelected: (Prediction suggestion) {
                     controller.enderecoTextController.text = suggestion.description;

                    },
                    suggestionsCallback: (String pattern) async {

                      return await controller.buscarEnderecos(pattern);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text("Localização atual"),
                onTap: () => controller.minhaLocalizacao(),
                trailing: Icon(Icons.arrow_forward_ios),
                leading: CircleAvatar(
                  child: Icon(
                    Icons.near_me,
                    color: Colors.white,
                  ),
                  radius: 30,
                  backgroundColor: Colors.red,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) => _buildItemEndereco(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemEndereco() {
    return ListTile(
      title: Text("Av. Paulista 100"),
      subtitle: Text("Sala 21"),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
            child: Icon(
              Icons.location_on,
              color: Colors.black,
            ),
            radius: 30,
            backgroundColor: Colors.white),
      ),
    );
  }
}
