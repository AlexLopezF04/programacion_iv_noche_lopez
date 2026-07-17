// app/index.tsx — agrega al archivo existente
import { ReactNode } from 'react'
import { StyleSheet, Text, View } from 'react-native'

interface CardProps {
  titulo: string
  subtitulo?: string
  children: ReactNode,
  color?: string
}

export function Card({ titulo, subtitulo, children, color }: CardProps) {
  return (
    <View style={styleCard.card}>
      <View style={[styleCard.cardCabecera, { backgroundColor: color ?? '#1565c0' }]}>
        <Text style={styleCard.cardTitulo}>{titulo}</Text>
        {subtitulo && (
          <Text style={styleCard.cardSubtitulo}>{subtitulo}</Text>
        )}
      </View>
      <View style={styleCard.cardCuerpo}>{children}</View>
    </View>
  )
}

const styleCard = StyleSheet.create({  
  card: {
    backgroundColor: '#ffffff',
    borderRadius: 12,
    overflow: 'hidden',
    shadowColor: '#000',
    shadowOpacity: 0.07,
    shadowRadius: 6,
    shadowOffset: { width: 0, height: 2 },
    elevation: 3,
  },
  cardCabecera: {
    paddingHorizontal: 16,
    paddingVertical: 12,
    gap: 2,
  },
  cardTitulo: {
    fontSize: 16,
    fontWeight: '700',
    color: '#ffffff',
  },
  cardSubtitulo: {
    fontSize: 12,
    color: '#bbdefb',
  },
  cardCuerpo: {
    padding: 12,
    gap: 8,
  },
})