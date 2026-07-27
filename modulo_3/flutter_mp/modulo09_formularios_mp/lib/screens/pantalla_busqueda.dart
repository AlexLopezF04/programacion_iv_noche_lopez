// lib/screens/pantalla_busqueda.dart
import 'package:flutter/material.dart';
import '../models/servidor_ssh.dart';
import '../widgets/fila_servidor.dart';
import '../widgets/tarjeta_servidor_grid.dart';

class PantallaBusqueda extends StatefulWidget {
  const PantallaBusqueda({super.key});
  @override
  State<PantallaBusqueda> createState() => _PantallaBusquedaState();
}

class _PantallaBusquedaState extends State<PantallaBusqueda> {
  final _servidores = [
    ServidorSSH(id:'1', nombre:'Desarrollo Flutter y Dart', ip:'Alex López',   puerto:45,   usuario:'Móviles',   so:'Avanzado', ssl:true,  favorito:true),
    ServidorSSH(id:'2', nombre:'Bases de Datos Relacionales', ip:'Ing. Gómez',   puerto:20,   usuario:'Databases', so:'Intermedio',    ssl:true),
    ServidorSSH(id:'3', nombre:'Backend Node.js & Express', ip:'Lic. Ruiz',   puerto:35,   usuario:'Backend',   so:'Avanzado', ssl:false),
    ServidorSSH(id:'4', nombre:'Maquetación Web CSS & HTML', ip:'Profe Diaz', puerto:18,   usuario:'Frontend',  so:'Principiante', ssl:false),
  ];

  String _busqueda = '';
  bool   _modoGrid = false;

  List<ServidorSSH> get _filtrados => _servidores
      .where((s) =>
          s.nombre.toLowerCase().contains(_busqueda.toLowerCase()) ||
          s.ip.toLowerCase().contains(_busqueda.toLowerCase()) ||
          s.usuario.toLowerCase().contains(_busqueda.toLowerCase()))
      .toList();

  void _toggleFavorito(ServidorSSH s) =>
      setState(() => s.favorito = !s.favorito);

  void _eliminar(ServidorSSH s) =>
      setState(() => _servidores.removeWhere((x) => x.id == s.id));

  @override
  Widget build(BuildContext context) {
    final cs       = Theme.of(context).colorScheme;
    final filtrados = _filtrados;

    return Scaffold(
      appBar: AppBar(
        title:           Text('Buscar Cursos (${_servidores.length})'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
        actions: [
          IconButton(
            icon:      Icon(_modoGrid ? Icons.list : Icons.grid_view),
            onPressed: () => setState(() => _modoGrid = !_modoGrid),
            tooltip:   _modoGrid ? 'Vista lista' : 'Vista cuadrícula',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: SearchBar(
              hintText: 'Buscar por título, instructor o categoría...',
              leading:  const Icon(Icons.search),
              trailing: _busqueda.isNotEmpty
                  ? [
                      IconButton(
                        icon:      const Icon(Icons.clear),
                        onPressed: () => setState(() => _busqueda = ''),
                      ),
                    ]
                  : null,
              onChanged: (v) => setState(() => _busqueda = v),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),

          if (_busqueda.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${filtrados.length} resultado${filtrados.length == 1 ? '' : 's'}',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ),
            ),

          Expanded(
            child: filtrados.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off,
                            size: 56, color: cs.onSurfaceVariant),
                        const SizedBox(height: 12),
                        Text(
                          'Sin resultados para "$_busqueda"',
                          style: TextStyle(color: cs.onSurfaceVariant),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () => setState(() => _busqueda = ''),
                          child: const Text('Limpiar búsqueda'),
                        ),
                      ],
                    ),
                  )
                : _modoGrid
                    ? GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:   2,
                          childAspectRatio: 1.1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing:  8,
                        ),
                        itemCount:   filtrados.length,
                        itemBuilder: (ctx, i) => TarjetaServidorGrid(
                          servidor:   filtrados[i],
                          onFavorito: () => _toggleFavorito(filtrados[i]),
                          onEliminar: () => _eliminar(filtrados[i]),
                        ),
                      )
                    : ListView.separated(
                        itemCount:        filtrados.length,
                        separatorBuilder: (_, _) =>
                            const Divider(height: 1, indent: 72),
                        itemBuilder: (ctx, i) => FilaServidor(
                          servidor:   filtrados[i],
                          onFavorito: () => _toggleFavorito(filtrados[i]),
                          onEliminar: () => _eliminar(filtrados[i]),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
