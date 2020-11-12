import 'dart:convert';

class EnderecoModel {
  int id;
  String endereco;
  double latitude;
  double longitude;
  String complemento;
  EnderecoModel({
    this.id,
    this.endereco,
    this.latitude,
    this.longitude,
    this.complemento,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'endereco': endereco,
      'latitude': latitude,
      'longitude': longitude,
      'complemento': complemento,
    };
  }

  factory EnderecoModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return EnderecoModel(
      id: map['id'],
      endereco: map['endereco'] as String,
      latitude: map['latitude'].runtimeType == String ? double.parse(map['latitude']) : map['latitude'] as double,
      longitude: map['longitude'].runtimeType == String ? double.parse(map['longitude']) : map['latitude'] as double,
      complemento: map['complemento'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EnderecoModel.fromJson(String source) => EnderecoModel.fromMap(json.decode(source));
}
