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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'Editar Carro' : 'Novo Carro',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primary.withOpacity(0.05),
              theme.colorScheme.background,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: widget.car?.nome,
                            decoration: InputDecoration(
                              labelText: 'Nome do Carro',
                              hintText: 'Ex.: Fiat Uno',
                              filled: true,
                              fillColor: theme.colorScheme.surface.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(
                                Icons.directions_car,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            validator: (value) =>
                                value == null || value.isEmpty ? 'Informe o nome' : null,
                            onSaved: (value) => nome = value!,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            initialValue: widget.car?.consumo.toString(),
                            decoration: InputDecoration(
                              labelText: 'Consumo (km/l)',
                              hintText: 'Ex.: 12.5',
                              filled: true,
                              fillColor: theme.colorScheme.surface.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(
                                Icons.local_gas_station,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                          const SizedBox(height: 16),
                          TextFormField(
                            initialValue: widget.car?.tanque.toString(),
                            decoration: InputDecoration(
                              labelText: 'Tanque (litros)',
                              hintText: 'Ex.: 50.0',
                              filled: true,
                              fillColor: theme.colorScheme.surface.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(
                                Icons.propane_tank,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
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

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isEdit
                                  ? 'Carro atualizado com sucesso!'
                                  : 'Carro adicionado com sucesso!',
                            ),
                            backgroundColor: theme.colorScheme.secondary,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );

                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      elevation: 6,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: Text(isEdit ? 'Salvar Alterações' : 'Adicionar Carro'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}