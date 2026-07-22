import 'dart:async';
import 'package:flutter/material.dart';

class CronometroVueltas extends StatefulWidget {
  const CronometroVueltas({super.key});

  @override
  State<CronometroVueltas> createState() => _CronometroVueltasState();
}

class _CronometroVueltasState extends State<CronometroVueltas> {
  late Timer _timer;
  int _segundos = 0;
  bool _pausado = false;
  final List<int> _vueltas = [];

  @override
  void initState() {
    super.initState();
    _iniciarTimer();
  }

  void _iniciarTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _segundos++);
    });
  }

  void _togglePausa() {
    setState(() {
      _pausado = !_pausado;
      if (_pausado) {
        _timer.cancel();
      } else {
        _iniciarTimer();
      }
    });
  }

  void _registrarVuelta() {
    setState(() => _vueltas.add(_segundos));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formato(int s) {
    final h = s ~/ 3600;
    final m = (s % 3600) ~/ 60;
    final sec = s % 60;
    return '$h:${m.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  Color get _colorTiempo {
    if (_segundos > 120) return Colors.deepPurple;
    if (_segundos > 60) return Colors.red;
    if (_segundos > 30) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cronómetro de sesión')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formato(_segundos),
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: _colorTiempo,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FilledButton.icon(
                  onPressed: _togglePausa,
                  icon: Icon(_pausado ? Icons.play_arrow : Icons.pause),
                  label: Text(_pausado ? 'Reanudar' : 'Pausar'),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: _pausado ? null : _registrarVuelta,
                  icon: const Icon(Icons.flag, size: 18),
                  label: const Text('Vuelta'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => setState(() {
                    _timer.cancel();
                    _segundos = 0;
                    _pausado = false;
                    _vueltas.clear();
                    _iniciarTimer();
                  }),
                  child: const Text('Reiniciar'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _pausado ? 'Pausado' : 'Corriendo',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            if (_vueltas.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text('Vueltas:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              SizedBox(
                height: 150,
                width: 200,
                child: ListView.builder(
                  itemCount: _vueltas.length,
                  itemBuilder: (_, i) => ListTile(
                    dense: true,
                    leading: Text('#${i + 1}',
                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade700)),
                    trailing: Text(_formato(_vueltas[i]),
                        style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
