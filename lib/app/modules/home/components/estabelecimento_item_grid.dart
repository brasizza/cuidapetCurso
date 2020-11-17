


import 'package:cuidapetcurso/app/models/fornecedor_model.dart';
import 'package:cuidapetcurso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';

class EstabelecimentoItemGrid extends StatelessWidget {

  final FornecedorBuscaModel _fornecedor;

  const EstabelecimentoItemGrid(this._fornecedor,{Key key}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return 
    Stack(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.only(
                  top: 40,
                  left: 10,
                  right: 10,
                ),
                elevation: 5,
                child: Container(
                  width: double.infinity,
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(_fornecedor.nome, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold), softWrap: true,),
                          Text(_fornecedor.distancia.toStringAsFixed(2) +   ' Km de distancia'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[200],
                ),
              ),
              Positioned(
                top: 4,
                left: 0,
                right: 0,
                child: Center(
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                     _fornecedor.logo,
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}