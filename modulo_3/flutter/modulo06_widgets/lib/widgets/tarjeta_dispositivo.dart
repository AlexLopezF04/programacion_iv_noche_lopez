import 'package:flutter/material.dart';

class TarjetaDispositivo extends StatefulWidget {
  final String nombre;
  final String ip;
  final String mac;
  final bool activo;
  final int latencia;

  const TarjetaDispositivo({
    super.key,
    required this.nombre,
    required this.ip,
    required this.mac,
    required this.activo,
    required this.latencia,
  });

  @override
  State<TarjetaDispositivo> createState() => _TarjetaDispositivoState();
}

class _TarjetaDispositivoState extends State<TarjetaDispositivo> {
  bool _expandido = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.activo ? Colors.green : Colors.red;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          ListTile(
            leading: Icon(widget.activo ? Icons.wifi : Icons.wifi_off, color: color),
            title: Text(widget.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(widget.activo ? 'En línea' : 'Desconectado'),
            trailing: Icon(_expandido ? Icons.expand_less : Icons.expand_more),
            onTap: () => setState(() => _expandido = !_expandido),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  _detalle('IP', widget.ip),
                  _detalle('MAC', widget.mac),
                  _detalle('Estado', widget.activo ? 'En línea' : 'Desconectado'),
                  _detalle('Latencia', '${widget.latencia} ms'),
                ],
              ),
            ),
            crossFadeState: _expandido ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  Widget _detalle(String label, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ),
          Text(valor, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
