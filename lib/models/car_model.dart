class CarModel {
  final int? id;
  final String name;
  final double consumption;

  CarModel({this.id, required this.name, required this.consumption});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'consumption': consumption,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      id: map['id'],
      name: map['name'],
      consumption: map['consumption'],
    );
  }

  CarModel copyWith({int? id, String? name, double? consumption}) {
    return CarModel(
      id: id ?? this.id,
      name: name ?? this.name,
      consumption: consumption ?? this.consumption,
    );
  }
}