// lib/screens/pantalla_servidores.dart
import 'package:flutter/material.dart';
import '../models/servidor_ssh.dart';
import '../widgets/fila_servidor.dart';
import '../widgets/tarjeta_servidor_grid.dart';

class PantallaServidores extends StatefulWidget {
  const PantallaServidores({super.key});
  @override
  State<PantallaServidores> createState() => _PantallaServidoresState();
}

class _PantallaServidoresState extends State<PantallaServidores> {
  final _servidores = [
    ServidorSSH(id:'1', nombre:'Desarrollo Flutter y Dart', ip:'Alex López',   puerto:45,   usuario:'Móviles',   so:'Avanzado', ssl:true,  favorito:true),
    ServidorSSH(id:'2', nombre:'Bases de Datos Relacionales', ip:'Ing. Gómez',   puerto:20,   usuario:'Databases', so:'Intermedio',    ssl:true),
    ServidorSSH(id:'3', nombre:'Backend Node.js & Express', ip:'Lic. Ruiz',   puerto:35,   usuario:'Backend',   so:'Avanzado', ssl:false),
    ServidorSSH(id:'4', nombre:'Maquetación Web CSS & HTML', ip:'Profe Diaz', puerto:18,   usuario:'Frontend',  so:'Principiante', ssl:false),
  ];

  bool _modoGrid = false;

  void _toggleFavorito(int i) =>
      setState(() => _servidores[i].favorito = !_servidores[i].favorito);

  void _eliminar(int i) => setState(() => _servidores.removeAt(i));

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title:           Text('Cursos Disponibles (${_servidores.length})'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
        actions: [
          IconButton(
            icon:    Icon(_modoGrid ? Icons.list : Icons.grid_view),
            onPressed: () => setState(() => _modoGrid = !_modoGrid),
            tooltip: _modoGrid ? 'Vista lista' : 'Vista cuadrícula',
          ),
        ],
      ),
      body: _modoGrid
          ? GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:   2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 8,
                mainAxisSpacing:  8,
              ),
              itemCount:   _servidores.length,
              itemBuilder: (ctx, i) => TarjetaServidorGrid(
                servidor:   _servidores[i],
                onFavorito: () => _toggleFavorito(i),
                onEliminar: () => _eliminar(i),
              ),
            )
          : ListView.separated(
              itemCount:        _servidores.length,
              separatorBuilder: (_, _) =>
                  const Divider(height: 1, indent: 72),
              itemBuilder: (ctx, i) => FilaServidor(
                servidor:   _servidores[i],
                onFavorito: () => _toggleFavorito(i),
                onEliminar: () => _eliminar(i),
              ),
            ),
    );
  }
}
