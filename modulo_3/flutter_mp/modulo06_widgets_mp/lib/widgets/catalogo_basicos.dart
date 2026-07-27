import 'package:flutter/material.dart';

class CatalogoBasicos extends StatelessWidget {
  const CatalogoBasicos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Componentes de Cursos')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // ── Bloque 1: Text (Información de Curso) ──────────────────────
          const Text(
            'Curso de Flutter & Dart: Activo',
            style: TextStyle(
              fontSize:      20,
              fontWeight:    FontWeight.bold,
              color:         Colors.indigo,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          const SizedBox(
            width: double.infinity,
            child: Text(
              'Instructor: Ing. Alex López · 12 Módulos',
              textAlign: TextAlign.center,
              maxLines:  1,
              overflow:  TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 8),
          const Text.rich(
            TextSpan(children: [
              TextSpan(text: 'Progreso actual: ',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              TextSpan(text: '75% COMPLETADO',
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              TextSpan(text: ' — último acceso hace 2 horas',
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
            ]),
          ),
          const SizedBox(height: 8),
          const SelectableText('ID de Matrícula: CURS-FLUTTER-2026',
              style: TextStyle(fontFamily: 'monospace', fontSize: 14)),
          const Divider(height: 32),

          // ── Bloque 2: Icon (Iconografía del Curso) ────────────────────
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.school,          size: 40, color: Colors.indigo),
              Icon(Icons.menu_book,       size: 40, color: Colors.blue),
              Icon(Icons.workspace_premium,size: 40, color: Colors.amber),
              Icon(Icons.play_circle_fill,size: 40, color: Colors.green),
              Icon(Icons.timer,           size: 40, color: Colors.orange),
            ],
          ),
          const SizedBox(height: 8),
          const Icon(Icons.settings, size: 24, color: Colors.blueGrey,
              semanticLabel: 'Configuración del reproductor'),
          const Divider(height: 32),

          // ── Bloque 3: Botones (Acciones del estudiante) ───────────────
          Wrap(
            spacing: 8, runSpacing: 8,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('Iniciar Clase')),
              FilledButton(  onPressed: () {}, child: const Text('Marcar como Vista')),
              OutlinedButton(onPressed: () {}, child: const Text('Descargar PDF')),
              TextButton(    onPressed: () {}, child: const Text('Ver Notas')),
              ElevatedButton(onPressed: null,  child: const Text('Examen Cerrado')),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon:  const Icon(Icons.refresh, size: 18),
                label: const Text('Repetir Lección'),
              ),
              FilledButton.icon(
                onPressed: () {},
                icon:  const Icon(Icons.star, size: 18),
                label: const Text('Calificar Curso'),
              ),
              IconButton(
                onPressed: () {},
                icon:     const Icon(Icons.share),
                color:    Colors.indigo,
                iconSize: 28,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              padding:     const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              elevation:   4,
              minimumSize: const Size(double.infinity, 0),
            ),
            child: const Text('Dar de baja del curso',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const Divider(height: 32),

          // ── Bloque 4: Card y ListTile (Módulos de Curso) ──────────────
          Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading:  const Icon(Icons.play_lesson, color: Colors.indigo),
              title:    const Text('Módulo 1: Introducción a Dart'),
              subtitle: const Text('8 Clases · Duración: 2h 15m'),
              trailing: const Icon(Icons.circle, color: Colors.green, size: 12),
              onTap:    () {},
            ),
          ),
          Card(
            elevation: 1,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigo.shade100,
                child: const Icon(Icons.lock, color: Colors.indigo, size: 20),
              ),
              title:    const Text('Módulo 2: State Management Avanzado'),
              subtitle: const Text('Bloqueado · Requiere Módulo 1'),
              trailing: TextButton(
                  onPressed: () {}, child: const Text('Ver requisitos')),
            ),
          ),
          const Divider(height: 32),

          // ── Bloque 5: Chip (Etiquetas de Tecnologías) ─────────────────
          Wrap(
            spacing: 8, runSpacing: 8,
            children: [
              const Chip(label: Text('Dart')),
              const Chip(
                avatar:          Icon(Icons.check, size: 16, color: Colors.white),
                label:           Text('Flutter 3.x'),
                backgroundColor: Colors.indigo,
                labelStyle: TextStyle(color: Colors.white, fontSize: 12),
              ),
              FilterChip(
                label: const Text('Riverpod'),
                selected: true, onSelected: (_) {},
              ),
              ActionChip(
                label:     const Text('Ver temario'),
                avatar:    const Icon(Icons.open_in_new, size: 16),
                onPressed: () {},
              ),
            ],
          ),
          const Divider(height: 32),

          // ── Bloque 6: Indicadores de progreso del estudiante ──────────
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 48, height: 48,
                  child: CircularProgressIndicator()),
              SizedBox(width: 48, height: 48,
                  child: CircularProgressIndicator(
                    value: 0.75, color: Colors.indigo, strokeWidth: 6)),
              SizedBox(width: 48, height: 48,
                  child: CircularProgressIndicator(
                    value: 0.3, color: Colors.orange,
                    strokeWidth: 3, strokeCap: StrokeCap.round)),
            ],
          ),
          const SizedBox(height: 16),
          const LinearProgressIndicator(),
          const SizedBox(height: 8),
          const LinearProgressIndicator(value: 0.75, color: Colors.indigo),
          const SizedBox(height: 8),
          const LinearProgressIndicator(
              value: 1.0, color: Colors.green, minHeight: 6),
        ],
      ),
    );
  }
}

