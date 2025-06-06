class CarModel {
  int? id;
  String nome;
  double consumo; 
  double tanque;  

  CarModel({this.id, required this.nome, required this.consumo, required this.tanque});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'consumo': consumo,
      'tanque': tanque,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      id: map['id'],
      nome: map['nome'],
      consumo: map['consumo'],
      tanque: map['tanque'],
    );
  }
}