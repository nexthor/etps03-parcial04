import 'package:flutter/material.dart';

import 'client_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clientes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ClientMaintenanceScreen(),
    );
  }
}
