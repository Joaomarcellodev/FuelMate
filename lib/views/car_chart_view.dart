import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../viewmodels/car_viewmodel.dart';

class CarChartView extends StatelessWidget {
  const CarChartView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CarViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Gráfico de Consumo')),
      body: FutureBuilder(
        future: viewModel.loadCars(),
        builder: (_, __) => Consumer<CarViewModel>(
          builder: (_, model, __) {
            if (model.cars.isEmpty) {
              return Center(child: Text('Nenhum dado disponível.'));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: model.cars.asMap().entries.map((e) {
                        return FlSpot(e.key.toDouble(), e.value.consumo);
                      }).toList(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
