import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/car_viewmodel.dart';
import 'car_form_view.dart';
import 'car_chart_view.dart';

class CarListView extends StatelessWidget {
  const CarListView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CarViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Automóveis'),
        actions: [
          IconButton(
            icon: Icon(Icons.show_chart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CarChartView()),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: viewModel.loadCars(),
        builder: (_, __) => Consumer<CarViewModel>(
          builder: (_, model, __) => ListView.builder(
            itemCount: model.cars.length,
            itemBuilder: (_, index) {
              final car = model.cars[index];
              return ListTile(
                title: Text(car.nome),
                subtitle: Text(
                    'Consumo: ${car.consumo} km/l - Tanque: ${car.tanque} L'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CarFormView(car: car),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        await model.deleteCar(car.id!);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Carro removido com sucesso!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CarFormView()),
        ),
      ),
    );
  }
}
