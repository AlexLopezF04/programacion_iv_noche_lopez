import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'api_error.dart';
import 'producto.dart';
import 'providers.dart';

class PantallaPaso5 extends ConsumerStatefulWidget {
  const PantallaPaso5({super.key});

  @override
  ConsumerState<PantallaPaso5> createState() => _PantallaPaso5State();
}

class _PantallaPaso5State extends ConsumerState<PantallaPaso5> {
  final _busqueda = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(catalogoProvider.notifier).cargar());
  }

  @override
  void dispose() {
    _busqueda.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final estado = ref.watch(catalogoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paso 5 · Arquitectura completa'),
        leading: BackButton(onPressed: () => context.go('/')),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: SearchBar(
              controller: _busqueda,
              hintText: 'Buscar producto…',
              leading: const Icon(Icons.search),
              trailing: [
                if (_busqueda.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _busqueda.clear();
                      ref.read(catalogoProvider.notifier).cargar();
                    },
                  ),
              ],
              onChanged: (v) =>
                  ref.read(catalogoProvider.notifier).buscar(v),
            ),
          ),
        ),
      ),
      body: _buildBody(estado),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.refresh),
        label: const Text('Recargar'),
        onPressed: () {
          _busqueda.clear();
          ref.read(catalogoProvider.notifier).cargar();
        },
      ),
    );
  }

  Widget _buildBody(CatalogoState estado) {
    if (estado.cargando) {
      return const Center(child: CircularProgressIndicator());
    }
    if (estado.error != null) return _buildError(estado.error!);
    if (estado.productos.isEmpty) {
      return const Center(
          child: Text('Sin resultados', style: TextStyle(fontSize: 18)));
    }
    return _buildLista(estado.productos);
  }

  Widget _buildLista(List<Producto> productos) => ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: productos.length,
    itemBuilder: (context, i) {
      final p = productos[i];
      return Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor:
                p.activo ? Colors.green[100] : Colors.grey[200],
            child: Text(
              p.id.toString(),
              style: TextStyle(
                color: p.activo ? Colors.green[800] : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
          title: Text(p.nombre),
          subtitle: Text(p.categoria ?? 'Sin categoría'),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$${p.precio.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
              Text(
                p.activo ? 'Activo' : 'Inactivo',
                style: TextStyle(
                    color: p.activo ? Colors.green : Colors.grey,
                    fontSize: 11),
              ),
            ],
          ),
        ),
      );
    },
  );

  Widget _buildError(ApiError error) {
    final (icono, color) = switch (error) {
      SinConexion()    => (Icons.wifi_off,   Colors.red),
      Timeout()        => (Icons.timer_off,  Colors.orange),
      ServidorError()  => (Icons.cloud_off,  Colors.purple),
      FormatoError()   => (Icons.data_array, Colors.brown),
    };

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icono, size: 64, color: color),
            const SizedBox(height: 16),
            Text(error.mensaje,
                style: TextStyle(
                    fontSize: 18,
                    color: color,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
              onPressed: () =>
                  ref.read(catalogoProvider.notifier).cargar(),
            ),
          ],
        ),
      ),
    );
  }
}
