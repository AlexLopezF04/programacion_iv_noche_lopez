// lib/screens/pantalla_gestor.dart
import 'package:flutter/material.dart';
import '../models/servidor_ssh.dart';
import '../widgets/formulario_servidor.dart';
import '../widgets/fila_servidor.dart';
import '../widgets/tarjeta_servidor_grid.dart';

class PantallaGestor extends StatefulWidget {
  const PantallaGestor({super.key});
  @override
  State<PantallaGestor> createState() => _PantallaGestorState();
}

class _PantallaGestorState extends State<PantallaGestor> {
  final _servidores = [
    ServidorSSH(id:'1', nombre:'prod-web-01',  ip:'10.0.2.10',   puerto:22,   usuario:'deploy',   so:'Ubuntu 24.04', ssl:true,  favorito:true),
    ServidorSSH(id:'2', nombre:'prod-db-01',   ip:'10.0.2.20',   puerto:22,   usuario:'postgres', so:'Debian 12',    ssl:true),
    ServidorSSH(id:'3', nombre:'staging-api',  ip:'10.0.3.10',   puerto:2222, usuario:'ubuntu',   so:'Ubuntu 24.04', ssl:false),
    ServidorSSH(id:'4', nombre:'dev-sandbox',  ip:'192.168.1.5', puerto:22,   usuario:'vagrant',  so:'Alpine Linux', ssl:false),
  ];

  String _busqueda    = '';
  bool   _mostrarForm = false;
  bool   _modoGrid    = false;

  List<ServidorSSH> get _filtrados => _servidores
      .where((s) =>
          s.nombre.toLowerCase().contains(_busqueda.toLowerCase()) ||
          s.ip.contains(_busqueda) ||
          s.usuario.toLowerCase().contains(_busqueda.toLowerCase()))
      .toList();

  void _agregarServidor(Map<String, String> datos) {
    setState(() {
      _servidores.add(ServidorSSH(
        id:      DateTime.now().millisecondsSinceEpoch.toString(),
        nombre:  datos['nombre']!,
        ip:      datos['ip']!,
        puerto:  int.parse(datos['puerto']!),
        usuario: datos['usuario']!,
        so:      datos['so']!,
        ssl:     datos['ssl'] == 'true',
      ));
      _mostrarForm = false;
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:  Text('Servidor "${datos['nombre']}" agregado'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _confirmarEliminar(ServidorSSH s) async {
    final confirma = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon:    const Icon(Icons.warning_amber, color: Colors.orange),
        title:   const Text('Eliminar servidor'),
        content: Text('¿Eliminar "${s.nombre}" (${s.ip})?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child:     const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirma == true) {
      setState(() => _servidores.removeWhere((x) => x.id == s.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs      = Theme.of(context).colorScheme;
    final filtrados = _filtrados;

    return Scaffold(
      appBar: AppBar(
        title: _mostrarForm
            ? const Text('Nuevo servidor')
            : Text('Servidores SSH (${_servidores.length})'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
        leading: _mostrarForm
            ? IconButton(
                icon:      const Icon(Icons.arrow_back),
                onPressed: () => setState(() => _mostrarForm = false),
              )
            : null,
        actions: _mostrarForm
            ? []
            : [
                IconButton(
                  icon:      Icon(_modoGrid ? Icons.list : Icons.grid_view),
                  onPressed: () =>
                      setState(() => _modoGrid = !_modoGrid),
                  tooltip:   _modoGrid ? 'Vista lista' : 'Vista cuadrícula',
                ),
              ],
      ),

      body: _mostrarForm
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: FormularioServidor(onGuardar: _agregarServidor),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: SearchBar(
                    hintText: 'Buscar por nombre, IP o usuario...',
                    leading:  const Icon(Icons.search),
                    trailing: _busqueda.isNotEmpty
                        ? [
                            IconButton(
                              icon:      const Icon(Icons.clear),
                              onPressed: () =>
                                  setState(() => _busqueda = ''),
                            ),
                          ]
                        : null,
                    onChanged: (v) => setState(() => _busqueda = v),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),

                if (_busqueda.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 4),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${filtrados.length} resultado${filtrados.length == 1 ? '' : 's'}',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(color: cs.onSurfaceVariant),
                      ),
                    ),
                  ),

                Expanded(
                  child: filtrados.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.search_off,
                                  size: 56, color: cs.onSurfaceVariant),
                              const SizedBox(height: 12),
                              Text(
                                'Sin resultados para "$_busqueda"',
                                style:
                                    TextStyle(color: cs.onSurfaceVariant),
                              ),
                              const SizedBox(height: 8),
                              TextButton(
                                onPressed: () =>
                                    setState(() => _busqueda = ''),
                                child: const Text('Limpiar búsqueda'),
                              ),
                            ],
                          ),
                        )
                      : _modoGrid
                          ? GridView.builder(
                              padding: const EdgeInsets.all(12),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:   2,
                                childAspectRatio: 1.1,
                                crossAxisSpacing: 8,
                                mainAxisSpacing:  8,
                              ),
                              itemCount:   filtrados.length,
                              itemBuilder: (ctx, i) =>
                                  TarjetaServidorGrid(
                                servidor:   filtrados[i],
                                onFavorito: () => setState(() =>
                                    filtrados[i].favorito =
                                        !filtrados[i].favorito),
                                onEliminar: () =>
                                    _confirmarEliminar(filtrados[i]),
                              ),
                            )
                          : ListView.separated(
                              itemCount:        filtrados.length,
                              separatorBuilder: (_, _) =>
                                  const Divider(height: 1, indent: 72),
                              itemBuilder: (ctx, i) => FilaServidor(
                                servidor:   filtrados[i],
                                onFavorito: () => setState(() =>
                                    filtrados[i].favorito =
                                        !filtrados[i].favorito),
                                onEliminar: () =>
                                    _confirmarEliminar(filtrados[i]),
                              ),
                            ),
                ),
              ],
            ),

      floatingActionButton: _mostrarForm
          ? null
          : FloatingActionButton.extended(
              onPressed: () => setState(() => _mostrarForm = true),
              icon:  const Icon(Icons.add),
              label: const Text('Nuevo servidor'),
            ),
    );
  }
}
