import 'package:flutter/material.dart';

class Semaforo extends StatefulWidget {
  const Semaforo({super.key});

  @override
  State<Semaforo> createState() => _SemaforoState();
}

class _SemaforoState extends State<Semaforo> {
  int _estado = 0;

  static const List<Color> _colores = [Colors.red, Colors.amber, Colors.green];
  static const List<String> _textos = ['STOP', 'PRECAUCIÓN', 'GO'];

  void _avanzar() {
    setState(() => _estado = (_estado + 1) % 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Semáforo interactivo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: List.generate(3, (i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Opacity(
                      opacity: i == _estado ? 1.0 : 0.25,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _colores[i],
                          boxShadow: i == _estado
                              ? [BoxShadow(color: _colores[i].withValues(alpha: 0.5), blurRadius: 20)]
                              : null,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _textos[_estado],
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: _colores[_estado],
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _avanzar,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Avanzar'),
            ),
          ],
        ),
      ),
    );
  }
}
