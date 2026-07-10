import { Alert, Image, Pressable, StyleSheet, Text, View } from 'react-native'

export function Paso2() {
  return (
    <View style={styles.contenedor}>
      <Image
        source={{ uri: 'https://reactnative.dev/img/tiny_logo.png' }}
        style={styles.logo}
      />
      <Text style={styles.titulo}>Conectar servidor</Text>

      <Pressable
        style={({ pressed }) => [
          styles.boton,
          pressed && styles.botonPresionado,
        ]}
        onPress={() => Alert.alert('Conectando', 'Estableciendo conexión SSH...')}
      >
        <Text style={styles.textoBoton}>Conectar SSH</Text>
      </Pressable>
    </View>
  )
}

const styles = StyleSheet.create({
  contenedor: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    gap: 16,
  },
  logo: {
    width: 80,
    height: 80,
  },
  titulo: {
    fontSize: 20,
    fontWeight: '600',
  },
  boton: {
    backgroundColor: '#1565c0',
    paddingVertical: 12,
    paddingHorizontal: 24,
    borderRadius: 8,
  },
  botonPresionado: {
    backgroundColor: '#0d47a1',
  },
  textoBoton: {
    color: '#fff',
    fontWeight: '600',
    fontSize: 16,
  },
})