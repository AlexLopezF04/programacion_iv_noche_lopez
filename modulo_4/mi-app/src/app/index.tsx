// app/index.tsx
import { Text, View } from 'react-native'
import { Paso1 } from './Paso1'
import { Paso2 } from './Paso2'


// ┌──────────────────────────────────────────────────────────────────┐
// │  Cambia este número y guarda (Ctrl+S) para navegar entre pasos. │
// │  1  Paso 1  Texto y vistas básicas                               │
// │  2  Paso 2  Imágenes y botones                                   │
// └──────────────────────────────────────────────────────────────────┘
const PASO: number = 2

export default function Index() {
  switch (PASO) {
      case 1:
      return <Paso1 />
      case 2:
      return <Paso2 />
      case 3:
      return <Paso3 />
    default:
      return (
        <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
          <Text>Paso {PASO}: crea la pantalla primero</Text>
        </View>
      )
  }
}

