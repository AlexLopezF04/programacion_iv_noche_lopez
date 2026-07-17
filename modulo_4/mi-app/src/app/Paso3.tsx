import { useState } from 'react'
import { Image, Pressable, StyleSheet, Text, View } from 'react-native'

export function Paso3() {
  const [siguiendo, setSiguiendo] = useState(false)

  return (
    <View style={styles.contenedor}>
      <Image
        source={{ uri: 'https://reactnative.dev/img/tiny_logo.png' }}
        style={styles.avatar}
      />
      <Text style={styles.nombre}>React Native</Text>
      <Text style={styles.bio}>Desarrollo móvil multiplataforma</Text>

      <Pressable
        style={({ pressed }) => [
          styles.boton,
          siguiendo && styles.botonSiguiendo,
          pressed && styles.botonPresionado,
        ]}
        onPress={() => setSiguiendo(!siguiendo)}
      >
        <Text style={[styles.textoBoton, siguiendo && styles.textoBotonSiguiendo]}>
          {siguiendo ? 'Siguiendo' : 'Seguir'}
        </Text>
      </Pressable>
    </View>
  )
}

const styles = StyleSheet.create({
  contenedor: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f5f5f5',
    gap: 12,
  },
  avatar: {
    width: 120,
    height: 120,
    borderRadius: 999,
  },
  nombre: {
    fontSize: 22,
    fontWeight: 'bold',
    color: '#1a1a1a',
  },
  bio: {
    fontSize: 14,
    color: '#777',
  },
  boton: {
    marginTop: 8,
    backgroundColor: '#1565c0',
    paddingVertical: 12,
    paddingHorizontal: 32,
    borderRadius: 8,
  },
  botonPresionado: {
    backgroundColor: '#0d47a1',
  },
  botonSiguiendo: {
    backgroundColor: '#e0e0e0',
  },
  textoBoton: {
    color: '#fff',
    fontWeight: '600',
    fontSize: 16,
  },
  textoBotonSiguiendo: {
    color: '#333',
  },
})
