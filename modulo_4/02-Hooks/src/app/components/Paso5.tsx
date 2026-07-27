import { StyleSheet, Text, View, Pressable } from 'react-native'
import { useConexionSimulada } from '@/hooks/useConexionSimulada'

interface PropsTarjeta {
  nombre: string
  hook: ReturnType<typeof useConexionSimulada>
}

function TarjetaServidor({ nombre, hook }: PropsTarjeta) {
  const { estado, intentos, latencia, reconectar, reiniciar } = hook

  const colorEstado: Record<string, string> = {
    desconectado: '#757575',
    conectando:   '#1565c0',
    conectado:    '#2e7d32',
    error:        '#c62828',
  }

  const textoBoton: Record<string, string> = {
    desconectado: 'Conectar',
    conectando:   'Conectando…',
    conectado:    'Reconectar',
    error:        'Reintentar',
  }

  return (
    <View style={[styles.tarjeta, { borderColor: colorEstado[estado], width: '100%' }]}>
      <View style={{ flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center' }}>
        <Text style={styles.nombreServidor}>{nombre}</Text>
        <Text style={[styles.etiqueta, { color: colorEstado[estado] }]}>
          {estado.toUpperCase()}
        </Text>
      </View>

      <Text style={styles.detalle}>
        Intentos: {intentos}
        {latencia !== null ? `  ·  Latencia: ${latencia} ms` : ''}
      </Text>

      <View style={{ flexDirection: 'row', gap: 8, marginTop: 8 }}>
        <Pressable
          style={({ pressed }) => [
            styles.boton,
            styles.botonActivo,
            estado === 'conectando' && styles.botonDeshabilitado,
            pressed && { opacity: 0.75 },
            { flex: 1 },
          ]}
          onPress={reconectar}
          disabled={estado === 'conectando'}
        >
          <Text style={styles.textoBoton}>{textoBoton[estado]}</Text>
        </Pressable>

        <Pressable
          style={({ pressed }) => [
            styles.botonSecundario,
            pressed && { opacity: 0.75 },
            { paddingHorizontal: 16, borderRadius: 8, borderWidth: 1, borderColor: '#1565c0', justifyContent: 'center' },
          ]}
          onPress={reiniciar}
        >
          <Text style={[styles.textoSecundario, { fontSize: 13 }]}>Reiniciar</Text>
        </Pressable>
      </View>
    </View>
  )
}

export function Paso5() {
  const webHook = useConexionSimulada('web-02')
  const cacheHook = useConexionSimulada('cache-02')

  return (
    <View style={styles.contenedor}>
      <Text style={styles.titulo}>Estado de Servicios</Text>

      <TarjetaServidor nombre="web-02" hook={webHook} />
      <TarjetaServidor nombre="cache-02" hook={cacheHook} />
    </View>
  )
}

const styles = StyleSheet.create({
  contenedor: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 24,
    backgroundColor: '#f5f5f5',
    gap: 14,
  },
  titulo: {
    fontSize: 20,
    fontWeight: '700',
    color: '#1a1a1a',
  },
  tarjeta: {
    padding: 16,
    borderRadius: 10,
    borderWidth: 2,
    backgroundColor: '#fff',
    gap: 6,
  },
  etiqueta: {
    fontSize: 12,
    fontWeight: '600',
    letterSpacing: 0.5,
  },
  detalle: {
    fontSize: 13,
    color: '#666',
  },
  nombreServidor: {
    fontSize: 15,
    fontWeight: '600',
    color: '#1a1a1a',
  },
  boton: {
    paddingVertical: 12,
    borderRadius: 8,
    alignItems: 'center',
    paddingHorizontal: 20,
  },
  botonActivo: {
    backgroundColor: '#1565c0',
  },
  botonDeshabilitado: {
    backgroundColor: '#90a4ae',
  },
  textoBoton: {
    color: '#fff',
    fontWeight: '600',
    fontSize: 14,
  },
  botonSecundario: {
    paddingVertical: 10,
  },
  textoSecundario: {
    color: '#1565c0',
    fontSize: 14,
  },
})
