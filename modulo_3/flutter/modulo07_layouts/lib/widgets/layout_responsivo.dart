import 'package:flutter/material.dart';

class LayoutResponsivo extends StatelessWidget {
  const LayoutResponsivo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Layout Responsivo')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: List.generate(6, (i) => _tarjeta(i)),
            );
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: 6,
              itemBuilder: (_, i) => _tarjeta(i),
            );
          }
        },
      ),
    );
  }

  Widget _tarjeta(int i) {
    final nombres = [
      'Servidor web-01', 'Servidor web-02', 'Base de datos',
      'Cache Redis', 'Worker-01', 'Balanceador',
    ];
    return Card(
      child: ListTile(
        leading: const Icon(Icons.dns, color: Colors.indigo),
        title: Text(nombres[i]),
        subtitle: const Text('En línea'),
        trailing: const Icon(Icons.circle, color: Colors.green, size: 12),
      ),
    );
  }
}
