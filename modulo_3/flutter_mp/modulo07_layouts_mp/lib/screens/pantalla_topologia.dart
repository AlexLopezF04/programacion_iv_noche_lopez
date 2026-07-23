import 'package:flutter/material.dart';
import '../models/dispositivo.dart';
import '../widgets/chip_resumen.dart';
import '../widgets/fila_dispositivo.dart';

class PantallaTopologia extends StatelessWidget {
  const PantallaTopologia({super.key});

  @override
  Widget build(BuildContext context) {
    final dispositivos = [
      const InfoDispositivo(
        nombre: 'core-router', tipo: 'router',
        ip: '10.0.0.1', activo: true, alertas: 2,
        etiquetas: ['BGP', 'OSPF', 'Gateway'],
      ),
      const InfoDispositivo(
        nombre: 'sw-distribucion', tipo: 'switch',
        ip: '10.0.1.1', activo: true, alertas: 0,
        etiquetas: ['L3', 'VLAN 10', 'VLAN 20'],
      ),
      const InfoDispositivo(
        nombre: 'prod-web-01', tipo: 'server',
        ip: '10.0.2.10', activo: true, alertas: 1,
        etiquetas: ['nginx', 'TLS'],
      ),
      const InfoDispositivo(
        nombre: 'prod-db-01', tipo: 'server',
        ip: '10.0.2.20', activo: true, alertas: 3,
        etiquetas: ['PostgreSQL', 'Primary'],
      ),
      const InfoDispositivo(
        nombre: 'backup-srv', tipo: 'server',
        ip: '10.0.3.5', activo: false, alertas: 0,
        etiquetas: ['Backup', 'Offsite'],
      ),
    ];

    final totalAlertas = dispositivos.fold(0, (s, d) => s + d.alertas);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Topología de Red'),
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
          IconButton(icon: const Icon(Icons.refresh),     onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Cabecera — Container con Row de ChipResumen (Pasos 1 + 3)
          Container(
            color:   Theme.of(context).colorScheme.surfaceContainerHighest,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                ChipResumen(
                  icono: Icons.hub,
                  texto: '${dispositivos.length} dispositivos',
                  color: Colors.indigo,
                ),
                const SizedBox(width: 16),
                ChipResumen(
                  icono: Icons.circle,
                  texto: '${dispositivos.where((d) => d.activo).length} activos',
                  color: Colors.green,
                ),
                const SizedBox(width: 16),
                ChipResumen(
                  icono: Icons.warning_amber,
                  texto: '$totalAlertas alertas',
                  color: Colors.orange,
                ),
              ],
            ),
          ),

          // Lista — Expanded para que ocupe el espacio restante (Paso 3)
          Expanded(
            child: ListView.separated(
              padding:          const EdgeInsets.symmetric(vertical: 8),
              itemCount:        dispositivos.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder:      (_, i)  => FilaDispositivo(dispositivo: dispositivos[i]),
            ),
          ),
        ],
      ),
    );
  }
}
