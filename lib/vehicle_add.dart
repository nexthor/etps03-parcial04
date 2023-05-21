import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddVehicleScreen extends StatelessWidget {
  final String? clientId;
  final TextEditingController brandNameController = TextEditingController();
  final TextEditingController modelNameController = TextEditingController();

  AddVehicleScreen({Key? key, this.clientId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Vehículo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: brandNameController,
              decoration: InputDecoration(labelText: 'Marca'),
            ),
            TextFormField(
              controller: modelNameController,
              decoration: InputDecoration(labelText: 'Modelo'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Guardar'),
              onPressed: () {
                addVehicle().then((value) {
                  if (value) {
                    Navigator.pop(context, true);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> addVehicle() async {
    final response =
        await FirebaseFirestore.instance.collection('vehicles').add({
      'BrandName': brandNameController.text,
      'ModelName': modelNameController.text,
    });
    // ignore: unnecessary_null_comparison
    return response != null;
  }
}
