import { useRef, useState } from 'react'
import {
  Pressable,
  StyleSheet,
  Text,
  TextInput,
  View,
  TextInput as RNTextInput,
} from 'react-native'

export function Paso4() {
  const inputHostRef = useRef<RNTextInput>(null)
  const inputPuertoRef = useRef<RNTextInput>(null)

  const [host, setHost] = useState<string>('')
  const [puerto, setPuerto] = useState<string>('22')

  const intentosSilenciosRef = useRef<number>(0)
  const [ultimaConexion, setUltimaConexion] = useState<string>('—')

  function intentarConexion() {
    intentosSilenciosRef.current += 1
    setUltimaConexion(
      `${host || 'servidor'}:${puerto} — intento #${intentosSilenciosRef.current}`
    )
  }

  return (
    <View style={styles.contenedor}>
      <Text style={styles.titulo}>Configurar Conexión SSH</Text>

      <View style={styles.formulario}>
        <Text style={styles.etiqueta}>Host o IP</Text>
        <TextInput
          ref={inputHostRef}
          style={styles.input}
          value={host}
          onChangeText={setHost}
          placeholder="10.0.2.10"
          placeholderTextColor="#aaa"
          autoCapitalize="none"
          returnKeyType="next"
          onSubmitEditing={() => inputPuertoRef.current?.focus()}
        />

        <Text style={styles.etiqueta}>Puerto SSH</Text>
        <TextInput
          ref={inputPuertoRef}
          style={styles.input}
          value={puerto}
          onChangeText={setPuerto}
          placeholder="22"
          placeholderTextColor="#aaa"
          keyboardType="number-pad"
          returnKeyType="done"
        />
      </View>

      <Pressable
        style={({ pressed }) => [styles.boton, styles.botonActivo, pressed && { opacity: 0.75 }]}
        onPress={intentarConexion}
      >
        <Text style={styles.textoBoton}>Conectar</Text>
      </Pressable>

      <Text style={styles.detalle}>Último intento: {ultimaConexion}</Text>
      <Text style={styles.detalle}>
        (los reintentos silenciosos no causan re-renders)
      </Text>
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
    gap: 16,
  },
  titulo: {
    fontSize: 20,
    fontWeight: '700',
    color: '#1a1a1a',
  },
  formulario: {
    width: '100%',
    gap: 6,
  },
  etiqueta: {
    fontSize: 13,
    fontWeight: '600',
    color: '#333',
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
  },
  boton: {
    width: '100%',
    paddingVertical: 14,
    borderRadius: 8,
    alignItems: 'center',
  },
  botonActivo: {
    backgroundColor: '#1565c0',
  },
  textoBoton: {
    color: '#fff',
    fontWeight: '600',
    fontSize: 15,
  },
  detalle: {
    fontSize: 13,
    color: '#666',
    textAlign: 'center',
  },
})
