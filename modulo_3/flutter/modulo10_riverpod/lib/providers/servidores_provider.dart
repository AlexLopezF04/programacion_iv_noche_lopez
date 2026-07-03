import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/servidor_ssh.dart';

class ServidoresNotifier extends Notifier<List<ServidorSSH>> {
  @override
  List<ServidorSSH> build() {
    return _servidoresIniciales();
  }

  List<ServidorSSH> _servidoresIniciales() {
    return [
      ServidorSSH(id: '1', nombre: 'Servidor Principal', host: '192.168.1.10'),
      ServidorSSH(id: '2', nombre: 'Servidor Backup', host: '192.168.1.20'),
      ServidorSSH(id: '3', nombre: 'Servidor Web', host: '192.168.1.30', esFavorito: true),
      ServidorSSH(id: '4', nombre: 'Base de Datos', host: '192.168.1.40'),
    ];
  }

  void agregar(ServidorSSH servidor) {
    state = [...state, servidor];
  }

  void eliminar(String id) {
    state = state.where((s) => s.id != id).toList();
  }

  void toggleFavorito(String id) {
    state = state.map((s) {
      if (s.id == id) {
        return s.copyWith(esFavorito: !s.esFavorito);
      }
      return s;
    }).toList();
  }
}

final servidoresProvider =
    NotifierProvider<ServidoresNotifier, List<ServidorSSH>>(
  ServidoresNotifier.new,
);

class BusquedaNotifier extends Notifier<String> {
  @override
  String build() => '';

  void cambiar(String valor) => state = valor;
}

final busquedaProvider =
    NotifierProvider<BusquedaNotifier, String>(BusquedaNotifier.new);

final servidoresFiltradosProvider = Provider<List<ServidorSSH>>((ref) {
  final busqueda = ref.watch(busquedaProvider).toLowerCase();
  final servidores = ref.watch(servidoresProvider);
  if (busqueda.isEmpty) return servidores;
  return servidores
      .where((s) =>
          s.nombre.toLowerCase().contains(busqueda) ||
          s.host.toLowerCase().contains(busqueda))
      .toList();
});
