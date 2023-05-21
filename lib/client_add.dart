import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddClientScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Cliente'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Dirección'),
            ),
            TextFormField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'Ciudad'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Guardar'),
              onPressed: () {
                addClient();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addClient() async {
    await FirebaseFirestore.instance.collection('clients').add({
      'Name': nameController.text,
      'LastName': lastNameController.text,
      'Address': addressController.text,
      'City': cityController.text,
    });
  }
}
