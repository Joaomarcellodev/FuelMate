import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import sqflite_common_ffi
import 'viewmodels/car_viewmodel.dart';
import 'views/car_list_view.dart';

void main() {
  // Initialize sqflite_common_ffi for Linux
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
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