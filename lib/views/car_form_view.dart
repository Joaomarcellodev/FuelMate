import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/car_model.dart';
import '../viewmodels/car_viewmodel.dart';

class CarFormView extends StatefulWidget {
  final CarModel? car;
  CarFormView({this.car});

  @override
  _CarFormViewState createState() => _CarFormViewState();
}

class _CarFormViewState extends State<CarFormView> {
  final _formKey = GlobalKey<FormState>();
  late String nome;
  late double consumo;
  late double tanque;

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.car != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Editar Carro' : 'Novo Carro')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.car?.nome,
                decoration: InputDecoration(labelText: 'Nome'),
                onSaved: (value) => nome = value!,
              ),
              TextFormField(
                initialValue: widget.car?.consumo.toString(),
                decoration: InputDecoration(labelText: 'Consumo (km/l)'),
                keyboardType: TextInputType.number,
                onSaved: (value) => consumo = double.parse(value!),
              ),
              TextFormField(
                initialValue: widget.car?.tanque.toString(),
                decoration: InputDecoration(labelText: 'Tanque (litros)'),
                keyboardType: TextInputType.number,
                onSaved: (value) => tanque = double.parse(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(isEdit ? 'Salvar' : 'Adicionar'),
                onPressed: () {
                  _formKey.currentState!.save();
                  final newCar = CarModel(
                    id: widget.car?.id,
                    nome: nome,
                    consumo: consumo,
                    tanque: tanque,
                  );

                  final viewModel = context.read<CarViewModel>();
                  isEdit ? viewModel.updateCar(newCar) : viewModel.addCar(newCar);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}