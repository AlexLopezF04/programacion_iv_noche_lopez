import 'package:flutter/material.dart';

class ChipResumen extends StatelessWidget {
  final IconData icono;
  final String   texto;
  final Color    color;

  const ChipResumen({
    super.key,
    required this.icono,
    required this.texto,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icono, size: 14, color: color),
        const SizedBox(width: 4),
        Text(texto,
            style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
