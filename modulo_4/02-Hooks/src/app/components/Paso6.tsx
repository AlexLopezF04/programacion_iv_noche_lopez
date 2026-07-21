import { useRef, useState, useEffect } from 'react'
import {
  Pressable,
  ScrollView,
  StyleSheet,
  Text,
  TextInput,
  View,
  TextInput as RNTextInput,
} from 'react-native'
import { useConexionSimulada } from '@/hooks/useConexionSimulada'

export function Paso6() {
  const { estado, intentos, latencia, reconectar, reiniciar } =
    useConexionSimulada('postgres-01')

  const inputFiltroRef = useRef<RNTextInput>(null)
  const [filtro, setFiltro] = useState<string>('')

  useEffect(() => {
    const timer = setTimeout(() => {
      inputFiltroRef.current?.focus()
    }, 300)
    return () => clearTimeout(timer)
  }, [])

  const [logs, setLogs] = useState<string[]>([])

  useEffect(() => {
    if (estado !== 'conectado') return

    const intervalo = setInterval(() => {
      const ahora = new Date().toLocaleTimeString()
      const eventos = [
        `[${ahora}] Query completada en ${Math.floor(Math.random() * 50) + 5}ms`,
        `[${ahora}] Conexión aceptada desde 10.0.2.1`,
        `[${ahora}] Checkpoint completado — WAL sincronizado`,
        `[${ahora}] Vacío automático en tabla sessions`,
      ]
      const evento = eventos[Math.floor(Math.random() * eventos.length)]
      setLogs(prev => [evento, ...prev].slice(0, 20))
    }, 1500)

    return () => clearInterval(intervalo)
  }, [estado])

  const logsFiltrados = filtro.trim()
    ? logs.filter(l => l.toLowerCase().includes(filtro.toLowerCase()))
    : logs

  const colorConexion: Record<string, string> = {
    desconectado: '#757575',
    conectando:   '#1565c0',
    conectado:    '#2e7d32',
    error:        '#c62828',
  }

  return (
    <View style={styles.contenedor}>
      <Text style={styles.titulo}>Estado del Servidor</Text>

      <View style={[styles.tarjeta, { borderColor: colorConexion[estado], width: '100%' }]}>
        <View style={{ flexDirection: 'row', justifyContent: 'space-between' }}>
          <Text style={styles.nombreServidor}>postgres-01</Text>
          <Text style={[styles.etiqueta, { color: colorConexion[estado] }]}>
            {estado.toUpperCase()}
          </Text>
        </View>

        <Text style={styles.detalle}>
          10.0.2.50 · PostgreSQL 16 · Puerto 5432
        </Text>

        <Text style={styles.detalle}>
          Intentos: {intentos}
          {latencia !== null ? `  ·  ${latencia} ms` : ''}
        </Text>

        <View style={{ flexDirection: 'row', gap: 8, marginTop: 10 }}>
          <Pressable
            style={({ pressed }) => [
              styles.boton,
              estado === 'conectando'
                ? styles.botonDeshabilitado
                : styles.botonActivo,
              pressed && { opacity: 0.75 },
              { flex: 1 },
            ]}
            onPress={reconectar}
            disabled={estado === 'conectando'}
          >
            <Text style={styles.textoBoton}>
              {estado === 'conectando' ? 'Conectando…' : 'Conectar / Reconectar'}
            </Text>
          </Pressable>

          <Pressable
            style={({ pressed }) => [
              {
                paddingHorizontal: 14,
                borderRadius: 8,
                borderWidth: 1,
                borderColor: '#ccc',
                justifyContent: 'center',
              },
              pressed && { opacity: 0.6 },
            ]}
            onPress={reiniciar}
          >
            <Text style={{ color: '#666', fontSize: 13 }}>Reset</Text>
          </Pressable>
        </View>
      </View>

      <TextInput
        ref={inputFiltroRef}
        style={styles.input}
        value={filtro}
        onChangeText={setFiltro}
        placeholder="Filtrar logs…"
        placeholderTextColor="#aaa"
        autoCapitalize="none"
      />

      <ScrollView
        style={styles.logContenedor}
        showsVerticalScrollIndicator={false}
      >
        {estado !== 'conectado' ? (
          <Text style={styles.logVacio}>
            {estado === 'desconectado' || estado === 'error'
              ? 'Sin conexión — los logs aparecen al conectar'
              : 'Estableciendo conexión…'}
          </Text>
        ) : logsFiltrados.length === 0 ? (
          <Text style={styles.logVacio}>Sin entradas que coincidan con "{filtro}"</Text>
        ) : (
          logsFiltrados.map((log, i) => (
            <Text key={i} style={styles.logLinea}>{log}</Text>
          ))
        )}
      </ScrollView>
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
  input: {
    borderWidth: 1,
    borderColor: '#ccc',
    borderRadius: 8,
    paddingHorizontal: 12,
    paddingVertical: 10,
    fontSize: 14,
    backgroundColor: '#fff',
    color: '#1a1a1a',
    width: '100%',
  },
  logContenedor: {
    borderRadius: 8,
    padding: 12,
    maxHeight: 220,
    width: '100%',
    backgroundColor: '#1e1e1e',
  },
  logLinea: {
    fontSize: 11,
    fontFamily: 'monospace',
    color: '#a8d8a8',
    lineHeight: 18,
  },
  logVacio: {
    fontSize: 12,
    color: '#666',
    fontStyle: 'italic',
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
})
