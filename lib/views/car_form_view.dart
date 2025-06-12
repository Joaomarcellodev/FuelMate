import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/car_model.dart';
import '../viewmodels/car_viewmodel.dart';

class CarFormView extends StatefulWidget {
  final CarModel? car;
  const CarFormView({super.key, this.car});

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
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o nome' : null,
                onSaved: (value) => nome = value!,
              ),
              TextFormField(
                initialValue: widget.car?.consumo.toString(),
                decoration: InputDecoration(labelText: 'Consumo (km/l)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o consumo';
                  }
                  final parsed = double.tryParse(value);
                  return (parsed == null || parsed <= 0)
                      ? 'Valor inválido'
                      : null;
                },
                onSaved: (value) => consumo = double.parse(value!),
              ),
              TextFormField(
                initialValue: widget.car?.tanque.toString(),
                decoration: InputDecoration(labelText: 'Tanque (litros)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o tamanho do tanque';
                  }
                  final parsed = double.tryParse(value);
                  return (parsed == null || parsed <= 0)
                      ? 'Valor inválido'
                      : null;
                },
                onSaved: (value) => tanque = double.parse(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(isEdit ? 'Salvar' : 'Adicionar'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newCar = CarModel(
                      id: widget.car?.id,
                      nome: nome,
                      consumo: consumo,
                      tanque: tanque,
                    );

                    final viewModel = context.read<CarViewModel>();

                    if (isEdit) {
                      await viewModel.updateCar(newCar);
                    } else {
                      await viewModel.addCar(newCar);
                    }

                    // Mostrar o SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isEdit
                              ? 'Carro atualizado com sucesso!'
                              : 'Carro adicionado com sucesso!',
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );

                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
