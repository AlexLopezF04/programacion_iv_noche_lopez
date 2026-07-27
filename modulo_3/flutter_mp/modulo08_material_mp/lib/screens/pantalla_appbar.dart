// lib/screens/pantalla_appbar.dart
import 'package:flutter/material.dart';

class PantallaAppBar extends StatelessWidget {
  const PantallaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar — colapsa al hacer scroll
          SliverAppBar.large(
            title:           const Text('Cursos Disponibles'),
            pinned:          true,
            backgroundColor: cs.primaryContainer,
            foregroundColor: cs.onPrimaryContainer,
            actions: [
              IconButton(
                icon:      const Icon(Icons.filter_list),
                onPressed: () {},
                tooltip:   'Filtrar por categoría',
              ),
              IconButton(
                icon:      const Icon(Icons.search),
                onPressed: () {},
                tooltip:   'Buscar cursos',
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: cs.primaryContainer,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 56),
                    Icon(Icons.school, size: 48, color: cs.onPrimaryContainer),
                    const SizedBox(height: 8),
                    Text(
                      '10 cursos activos en tu cuenta',
                      style: TextStyle(color: cs.onPrimaryContainer),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Lista de servidores -> Cursos
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => Card(
                  child: ListTile(
                    leading:  Icon(Icons.menu_book, color: cs.primary),
                    title:    Text('Especialidad en Flutter - Módulo 0${i + 1}'),
                    subtitle: Text('Instructor: Alex López · ${i + 5} lecciones'),
                    trailing: Chip(
                      label:           Text('Clase ${i + 1}'),
                      backgroundColor: cs.primaryContainer,
                      labelStyle:      TextStyle(color: cs.onPrimaryContainer),
                    ),
                    onTap: () {},
                  ),
                ),
                childCount: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

