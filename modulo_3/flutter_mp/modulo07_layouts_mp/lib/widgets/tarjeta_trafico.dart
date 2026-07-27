import 'package:flutter/material.dart';

class TarjetaTrafico extends StatelessWidget {
  final String nombreInterfaz; // Nombre del día (e.g., "Lun")
  final double uso; // Minutos de estudio

  const TarjetaTrafico({
    super.key,
    required this.nombreInterfaz,
    required this.uso,
  });

  @override
  Widget build(BuildContext context) {
    // Meta diaria: 60 minutos
    final porcentaje = (uso / 60).clamp(0.0, 1.0);
    final color = uso >= 60 ? Colors.green : uso >= 30 ? Colors.orange : Colors.red;

    return Container(
      width: 68,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Fondo: barra vertical vacía
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Column(
                  children: [
                    const Spacer(),
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.grey.shade100,
                    ),
                  ],
                ),
              ),
            ),
            // Barra de progreso vertical
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                child: Container(
                  height: 140 * porcentaje,
                  color: color.withValues(alpha: 0.15),
                ),
              ),
            ),
            // Indicador de nivel (barra fina)
            Positioned(
              bottom: 140 * porcentaje,
              left: 0,
              right: 0,
              child: Container(height: 3, color: color),
            ),
            // Texto centrado
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  uso.toStringAsFixed(0),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  'min',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  nombreInterfaz,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
