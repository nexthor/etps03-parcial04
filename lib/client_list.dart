import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'client_add.dart';
import 'client_edit.dart';

class ClientMaintenanceScreen extends StatelessWidget {
  const ClientMaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddClientScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('clients').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final clients = snapshot.data?.docs;
          return ListView.builder(
            itemCount: clients?.length,
            itemBuilder: (context, index) {
              final client = clients?[index];
              return ListTile(
                title: Text(client?['Name']),
                subtitle: Text(client?['LastName']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditClientScreen(client: client),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
