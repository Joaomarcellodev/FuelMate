import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../database/car_database.dart';

class CarViewModel extends ChangeNotifier {
  List<CarModel> _cars = [];

  List<CarModel> get cars => _cars;

  Future loadCars() async {
    _cars = await CarDatabase.instance.getAllCars();
    notifyListeners();
  }

  Future addCar(CarModel car) async {
    await CarDatabase.instance.insertCar(car);
    await loadCars();
  }

  Future updateCar(CarModel car) async {
    await CarDatabase.instance.updateCar(car);
    await loadCars();
  }

  Future deleteCar(int id) async {
    await CarDatabase.instance.deleteCar(id);
    await loadCars();
  }
}
