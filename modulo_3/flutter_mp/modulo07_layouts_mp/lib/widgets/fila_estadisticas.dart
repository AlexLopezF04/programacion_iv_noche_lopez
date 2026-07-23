import 'package:flutter/material.dart';

class FilaEstadisticas extends StatelessWidget {
  const FilaEstadisticas({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 80,
        child: Row(
          children: [
            _Seccion(valor: '45ms', etiqueta: 'Latencia'),
            const VerticalDivider(width: 1, thickness: 1),
            _Seccion(valor: '12.4k', etiqueta: 'Paquetes'),
            const VerticalDivider(width: 1, thickness: 1),
            _Seccion(valor: '99.8%', etiqueta: 'Uptime'),
          ],
        ),
      ),
    );
  }
}

class _Seccion extends StatelessWidget {
  final String valor;
  final String etiqueta;

  const _Seccion({required this.valor, required this.etiqueta});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            valor,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            etiqueta,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
