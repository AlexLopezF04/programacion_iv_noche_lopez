import { View, Text } from 'react-native'
import { Paso1 } from './components/Paso1'
import { Paso2 } from './components/Paso2'
import { Paso3 } from './components/Paso3'
import { Paso4 } from './components/Paso4'
import { Paso5 } from './components/Paso5'
import { Paso6 } from './components/Paso6'

const PASO: number = 6

export default function Index() {
  switch (PASO) {
    case 1:
      return <Paso1 />
    case 2:
      return <Paso2 />
    case 3:
      return <Paso3 />
    case 4:
      return <Paso4 />
    case 5:
      return <Paso5 />
    case 6:
      return <Paso6 />
    default:
      return (
        <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
          <Text>Paso {PASO}: crea la pantalla primero</Text>
        </View>
      )
  }
}
