import { StyleSheet, Text, View } from 'react-native';

export function FilaInfo({ etiqueta, valor }: { etiqueta: string; valor: string }) {
  return (
    <View style={styleFilaInfo.fila}>
      <Text style={styleFilaInfo.etiqueta}>{etiqueta}</Text>
      <Text style={styleFilaInfo.valor}>{valor}</Text>
    </View>
  )
}

const styleFilaInfo = StyleSheet.create({
  fila: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  etiqueta: {
    fontSize: 13,
    color: '#546e7a',
    fontWeight: '500',
  },
  valor: {
    fontSize: 13,
    color: '#1a1a1a',
    fontFamily: 'monospace',
  },
})