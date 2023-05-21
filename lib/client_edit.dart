import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'vehicle_list.dart';

class EditClientScreen extends StatefulWidget {
  final QueryDocumentSnapshot? client;

  const EditClientScreen({Key? key, this.client}) : super(key: key);

  @override
  _EditClientScreenState createState() => _EditClientScreenState();
}

class _EditClientScreenState extends State<EditClientScreen> {
  late String name;
  late String lastName;
  late String address;
  late String city;

  @override
  void initState() {
    super.initState();
    name = widget.client?['Name'];
    lastName = widget.client?['LastName'];
    address = widget.client?['Address'];
    city = widget.client?['City'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Cliente'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: name,
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextFormField(
              initialValue: lastName,
              onChanged: (value) {
                setState(() {
                  lastName = value;
                });
              },
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            TextFormField(
              initialValue: address,
              onChanged: (value) {
                setState(() {
                  address = value;
                });
              },
              decoration: InputDecoration(labelText: 'Dirección'),
            ),
            TextFormField(
              initialValue: city,
              onChanged: (value) {
                setState(() {
                  city = value;
                });
              },
              decoration: InputDecoration(labelText: 'Ciudad'),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('Guardar'),
                  onPressed: () {
                    updateClient(widget.client!.id);
                  },
                ),
                ElevatedButton(
                  child: Text('Eliminar'),
                  onPressed: () {
                    deleteClient(widget.client!.id);
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: const Text('Asignar Vehículos'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VehicleListScreen(clientId: widget.client!.id),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateClient(String clientId) async {
    await FirebaseFirestore.instance
        .collection('clients')
        .doc(clientId)
        .update({
      'Name': name,
      'LastName': lastName,
      'Address': address,
      'City': city,
    });
  }

  Future<void> deleteClient(String clientId) async {
    await FirebaseFirestore.instance
        .collection('clients')
        .doc(clientId)
        .delete();
  }
}
