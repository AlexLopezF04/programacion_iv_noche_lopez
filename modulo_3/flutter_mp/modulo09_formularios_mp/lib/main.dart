// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/formulario_servidor.dart';
import 'models/servidor_ssh.dart';
import 'widgets/fila_servidor.dart';
import 'screens/pantalla_servidores.dart';
import 'screens/pantalla_busqueda.dart';

// ┌──────────────────────────────────────────────────────────────────┐
// │  Cambia este número y guarda (Ctrl+S) para navegar entre pasos. │
// │  1  Paso 1  TextField + TextEditingController + FocusNode       │
// │  2  Paso 2  Form + TextFormField + validación (Nuevo Curso)     │
// │  3  Paso 3  Modelo + ListView.builder + ListTile (Lista)         │
// │  4  Paso 4  GridView.builder + toggle lista/grid (Catálogo)      │
// │  5  Paso 5  SearchBar + filtrado en tiempo real (Búsqueda)       │
// └──────────────────────────────────────────────────────────────────┘
const int paso = 5;

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
    ),
    useMaterial3: true,
  ),
  home: switch (paso) {
    1 => const _Paso1(),
    2 => const _Paso2(),
    3 => const _Paso3(),
    4 => const PantallaServidores(),
    5 => const PantallaBusqueda(),
    _ => Scaffold(body: Center(child: Text('Paso $paso no definido'))),
  },
));

// ─── Paso 1 ────────────────────────────────────────────────────────────
class _Paso1 extends StatefulWidget {
  const _Paso1();
  @override
  State<_Paso1> createState() => _Paso1State();
}

class _Paso1State extends State<_Paso1> {
  final _ctrlHostname = TextEditingController();
  final _ctrlIp       = TextEditingController();
  final _ctrlPuerto   = TextEditingController(text: '12');
  final _focusIp      = FocusNode();
  final _focusPuerto  = FocusNode();

  @override
  void dispose() {
    _ctrlHostname.dispose();
    _ctrlIp.dispose();
    _ctrlPuerto.dispose();
    _focusIp.dispose();
    _focusPuerto.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title:           const Text('Registrar Curso (Básico)'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller:      _ctrlHostname,
              decoration:      const InputDecoration(
                labelText:  'Título del Curso',
                hintText:   'Desarrollo Flutter y Dart',
                prefixIcon: Icon(Icons.school),
                border:     OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
              onSubmitted:     (_) => _focusIp.requestFocus(),
            ),
            const SizedBox(height: 12),
            TextField(
              controller:      _ctrlIp,
              focusNode:       _focusIp,
              decoration:      const InputDecoration(
                labelText:  'Nombre del Instructor',
                hintText:   'Alex López',
                prefixIcon: Icon(Icons.person),
                border:     OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
              onSubmitted:     (_) => _focusPuerto.requestFocus(),
            ),
            const SizedBox(height: 12),
            TextField(
              controller:      _ctrlPuerto,
              focusNode:       _focusPuerto,
              decoration:      const InputDecoration(
                labelText:  'Cantidad de Lecciones',
                prefixIcon: Icon(Icons.list),
                border:     OutlineInputBorder(),
              ),
              keyboardType:    TextInputType.number,
              textInputAction: TextInputAction.done,
              onSubmitted:     (_) => FocusScope.of(context).unfocus(),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {
                FocusScope.of(context).unfocus();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Curso registrado: ${_ctrlHostname.text} '
                      'por ${_ctrlIp.text} (${_ctrlPuerto.text} lecciones)',
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon:  const Icon(Icons.save),
              label: const Text('Crear Curso'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {
                _ctrlHostname.clear();
                _ctrlIp.clear();
                _ctrlPuerto.text = '12';
              },
              child: const Text('Limpiar campos'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Paso 2 ────────────────────────────────────────────────────────────
class _Paso2 extends StatelessWidget {
  const _Paso2();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo curso'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FormularioServidor(
          onGuardar: (datos) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'Guardado: ${datos['nombre']} — ${datos['ip']} (${datos['puerto']} clases)'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      ),
    );
  }
}

// ─── Paso 3 ────────────────────────────────────────────────────────────
class _Paso3 extends StatefulWidget {
  const _Paso3();
  @override
  State<_Paso3> createState() => _Paso3State();
}

class _Paso3State extends State<_Paso3> {
  final _servidores = [
    ServidorSSH(id:'1', nombre:'Desarrollo Flutter y Dart', ip:'Alex López',   puerto:45,   usuario:'Móviles',   so:'Avanzado', ssl:true,  favorito:true),
    ServidorSSH(id:'2', nombre:'Bases de Datos Relacionales', ip:'Ing. Gómez',   puerto:20,   usuario:'Databases', so:'Intermedio',    ssl:true),
    ServidorSSH(id:'3', nombre:'Backend Node.js & Express', ip:'Lic. Ruiz',   puerto:35,   usuario:'Backend',   so:'Avanzado', ssl:false),
    ServidorSSH(id:'4', nombre:'Maquetación Web CSS & HTML', ip:'Profe Diaz', puerto:18,   usuario:'Frontend',  so:'Principiante', ssl:false),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title:           Text('Cursos (${_servidores.length})'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: _servidores.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.school_outlined, size: 56, color: cs.onSurfaceVariant),
                  const SizedBox(height: 12),
                  Text('Sin cursos',
                      style: TextStyle(color: cs.onSurfaceVariant)),
                ],
              ),
            )
          : ListView.separated(
              itemCount:        _servidores.length,
              separatorBuilder: (_, _) =>
                  const Divider(height: 1, indent: 72),
              itemBuilder: (ctx, i) => FilaServidor(
                servidor:   _servidores[i],
                onFavorito: () => setState(() =>
                    _servidores[i].favorito = !_servidores[i].favorito),
                onEliminar: () =>
                    setState(() => _servidores.removeAt(i)),
              ),
            ),
    );
  }
}

