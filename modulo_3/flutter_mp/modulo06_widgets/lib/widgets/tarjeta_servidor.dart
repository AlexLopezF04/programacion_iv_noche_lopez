import 'package:flutter/material.dart';
import '../models/servidor.dart';

class TarjetaServidor extends StatelessWidget {
  final Servidor servidor;
  const TarjetaServidor({super.key, required this.servidor});

  @override
  Widget build(BuildContext context) {
    final color = servidor.activo
        ? (servidor.esCritico ? Colors.orange : Colors.green)
        : Colors.red;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(servidor.activo ? Icons.circle : Icons.circle_outlined,
                    color: color, size: 12),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(servidor.nombre,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis),
                ),
                if (servidor.esCritico && servidor.activo)
                  const Icon(Icons.warning_amber, color: Colors.orange, size: 16),
              ],
            ),
            const SizedBox(height: 8),
            _Barra(label: 'CPU', valor: servidor.cpu, critico: servidor.cpu > 85),
            const SizedBox(height: 4),
            _Barra(label: 'RAM', valor: servidor.ram, critico: servidor.ram > 90),
            const SizedBox(height: 6),
            Text('${servidor.conexiones} conexiones',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }
}

class _Barra extends StatelessWidget {
  final String label;
  final double valor;
  final bool   critico;
  const _Barra({required this.label, required this.valor, required this.critico});

  @override
  Widget build(BuildContext context) {
    final color = critico ? Colors.orange : Colors.green;
    return Row(
      children: [
        SizedBox(width: 30, child: Text(label, style: const TextStyle(fontSize: 11))),
        Expanded(
          child: LinearProgressIndicator(
            value:           valor / 100,
            backgroundColor: Colors.grey.shade200,
            color:           color,
          ),
        ),
        const SizedBox(width: 6),
        SizedBox(
          width: 36,
          child: Text('${valor.toStringAsFixed(0)}%',
              style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600),
              textAlign: TextAlign.right),
        ),
      ],
    );
  }
}
