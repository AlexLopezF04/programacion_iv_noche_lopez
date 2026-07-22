import 'dart:async';
import 'package:flutter/material.dart';
import '../models/servidor.dart';
import '../widgets/tarjeta_metrica.dart';
import '../widgets/tarjeta_servidor.dart';

class PantallaDashboard extends StatefulWidget {
  const PantallaDashboard({super.key});
  @override
  State<PantallaDashboard> createState() => _PantallaDashboardState();
}

class _PantallaDashboardState extends State<PantallaDashboard> {
  late Timer     _timer;
  List<Servidor> _servidores = [];
  bool           _cargando   = true;
  int            _ciclo      = 0;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) => _cargarDatos());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _cargarDatos() {
    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      setState(() {
        _ciclo++;
        _cargando   = false;
        _servidores = [
          Servidor(nombre: 'web-01', cpu: 45 + (_ciclo * 3 % 30), ram: 62, conexiones: 230, activo: true),
          Servidor(nombre: 'web-02', cpu: 38 + (_ciclo * 7 % 20), ram: 55, conexiones: 180, activo: true),
          Servidor(nombre: 'api-primary', cpu: 72 + (_ciclo * 5 % 25), ram: 78, conexiones: 450, activo: true),
          Servidor(nombre: 'db-primary', cpu: 88 + (_ciclo % 10), ram: 91, conexiones: 80, activo: true),
          Servidor(nombre: 'cache', cpu: 15, ram: 40, conexiones: 1200, activo: true),
          Servidor(nombre: 'worker-01', cpu: 0, ram: 0, conexiones: 0, activo: false),
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final activos = _servidores.where((s) => s.activo).length;
    final alertas = _servidores.where((s) => s.esCritico).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitor de Infraestructura'),
        actions: [
          if (_cargando)
            const Padding(
              padding: EdgeInsets.all(12),
              child: SizedBox(width: 20, height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2)),
            ),
          IconButton(icon: const Icon(Icons.refresh), onPressed: _cargarDatos),
        ],
      ),
      body: _cargando && _servidores.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(child: TarjetaMetrica(
                        titulo: 'Activos', valor: '$activos/${_servidores.length}',
                        icono: Icons.dns, colorIcono: Colors.green,
                      )),
                      const SizedBox(width: 8),
                      Expanded(child: TarjetaMetrica(
                        titulo:    'Alertas', valor: '$alertas',
                        icono:     Icons.warning_amber,
                        colorIcono: alertas > 0 ? Colors.orange : Colors.green,
                        subtitulo:  alertas > 0 ? 'Requieren atención' : null,
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.3,
                      crossAxisSpacing: 8, mainAxisSpacing: 8,
                    ),
                    itemCount:   _servidores.length,
                    itemBuilder: (_, i) => TarjetaServidor(servidor: _servidores[i]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text('Ciclo #$_ciclo · actualiza cada 3 s',
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                ),
              ],
            ),
    );
  }
}
