import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/car_viewmodel.dart';
import 'views/car_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CarViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Carros',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: CarListView(),
      ),
    );
  }
}
