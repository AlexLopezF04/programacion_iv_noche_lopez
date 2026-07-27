import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/servidor_ssh.dart';

class ServidoresNotifier extends Notifier<List<ServidorSSH>> {
  @override
  List<ServidorSSH> build() {
    return _servidoresIniciales();
  }

  List<ServidorSSH> _servidoresIniciales() {
    return [
      const ServidorSSH(id: '1', nombre: 'Desarrollo Flutter & Dart', host: 'Alex López', puerto: 45),
      const ServidorSSH(id: '2', nombre: 'Bases de Datos SQL', host: 'Ing. Gómez', puerto: 20),
      const ServidorSSH(id: '3', nombre: 'Backend Node.js & Express', host: 'Lic. Ruiz', puerto: 35, esFavorito: true),
      const ServidorSSH(id: '4', nombre: 'Maquetación Web CSS & HTML', host: 'Profe Diaz', puerto: 18),
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
