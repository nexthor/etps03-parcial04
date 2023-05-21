import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'vehicle_add.dart';

class VehicleListScreen extends StatelessWidget {
  final String clientId;

  const VehicleListScreen({Key? key, required this.clientId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehículos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddVehicleScreen(clientId: clientId),
                ),
              ).then((value) {
                if (value != null && value) {
                  // Refresh data
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VehicleListScreen(clientId: clientId),
                    ),
                  );
                }
              });
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('vehicles').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final vehicles = snapshot.data?.docs;
          return ListView.builder(
            itemCount: vehicles?.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles?[index];
              return ListTile(
                title: Text(vehicle?['BrandName']),
                subtitle: Text(vehicle?['ModelName']),
                onTap: () {
                  assignVehicle(vehicle!.id, clientId, vehicle['BrandName'],
                      vehicle['ModelName']);
                  Navigator.pop(context, true);
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<void> assignVehicle(String vehicleId, String clientId,
      String brandName, String modelName) async {
    await FirebaseFirestore.instance.collection('client_vehicles').add({
      'IdClient': clientId,
      'IdVehicle': vehicleId,
      'VehicleRegistration': brandName + ' ' + modelName,
      'Kilometers': 0,
    });
  }
}
