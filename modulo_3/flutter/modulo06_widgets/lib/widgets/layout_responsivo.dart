import 'package:flutter/material.dart';
import 'tarjeta_metrica.dart';

class LayoutResponsivo extends StatelessWidget {
  const LayoutResponsivo({super.key});

  @override
  Widget build(BuildContext context) {
    final esRetrato = MediaQuery.orientationOf(context) == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(title: const Text('Layout Responsivo')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (esRetrato) ...[
                const TarjetaMetrica(
                  titulo: 'Servidores activos',
                  valor: '12',
                  icono: Icons.dns,
                  colorIcono: Colors.green,
                ),
                const SizedBox(height: 12),
                const TarjetaMetrica(
                  titulo: 'Alertas',
                  valor: '3',
                  icono: Icons.warning_amber,
                  colorIcono: Colors.orange,
                ),
              ] else ...[
                const Row(
                  children: [
                    Expanded(
                      child: TarjetaMetrica(
                        titulo: 'Servidores activos',
                        valor: '12',
                        icono: Icons.dns,
                        colorIcono: Colors.green,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TarjetaMetrica(
                        titulo: 'Alertas',
                        valor: '3',
                        icono: Icons.warning_amber,
                        colorIcono: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 16),
              Text(
                'Modo: ${esRetrato ? "Retrato" : "Paisaje"}',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
