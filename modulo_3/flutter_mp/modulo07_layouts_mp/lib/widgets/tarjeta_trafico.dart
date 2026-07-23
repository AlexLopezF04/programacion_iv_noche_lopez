import 'package:flutter/material.dart';

class TarjetaTrafico extends StatelessWidget {
  final String nombreInterfaz;
  final double uso; // 0.0 – 100.0

  const TarjetaTrafico({
    super.key,
    required this.nombreInterfaz,
    required this.uso,
  });

  @override
  Widget build(BuildContext context) {
    final porcentaje = (uso / 100).clamp(0.0, 1.0);
    final color = uso > 80 ? Colors.red : uso > 50 ? Colors.orange : Colors.green;

    return Container(
      width: 100,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
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
                      color: Colors.grey.shade200,
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
                  height: 160 * porcentaje,
                  color: color.withValues(alpha: 0.3),
                ),
              ),
            ),
            // Indicador de nivel (barra fina)
            Positioned(
              bottom: 160 * porcentaje,
              left: 0,
              right: 0,
              child: Container(height: 3, color: color),
            ),
            // Texto centrado
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${uso.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  nombreInterfaz,
                  style: TextStyle(
                    fontSize: 10,
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
