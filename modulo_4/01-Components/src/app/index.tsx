// app/index.tsx
import { SafeAreaView, ScrollView, StyleSheet, Text, View } from 'react-native'
import { Card } from './components/Card'
import { FilaInfo } from './components/FilaInfo'
import { TarjetaServidor } from './components/TarjetaServidor'

// ┌──────────────────────────────────────────────────────────────────┐
// │  Cambia este número y guarda (Ctrl+S) para navegar entre pasos. │
// │  1  Paso 1  Props tipadas — TarjetaServidor                     │
// │  2  Paso 2  children y composición — Card reutilizable          │
// │  3  Paso 3  Props opcionales y BadgeEstado                      │
// │  4  Paso 4  ScrollView y SafeAreaView                           │
// │  5  Paso 5  Modal de confirmación                               │
// │  6  Paso 6  Pantalla completa — detalle de servidor             │
// └──────────────────────────────────────────────────────────────────┘
const PASO = 6

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
        <View style={styles.centrado}>
          <Text>Paso {PASO}: crea el componente primero</Text>
        </View>
      )
  }
}

// ─── Paso 1 — Props tipadas ──────────────────────────────────────────


function Paso1() {
  return (
    <View style={styles.fondo}>
      <Text style={styles.encabezado}>Inventario de servidores</Text>
      <TarjetaServidor
        nombre="web-01"
        ip="10.0.2.10"
        sistema="Ubuntu 24.04 LTS"
        puerto={22}
      />
      <TarjetaServidor
        nombre="db-primary"
        ip="10.0.2.20"
        sistema="Debian 12"
        puerto={5432}
      />
      <TarjetaServidor
        nombre="cache-01"
        ip="10.0.2.30"
        sistema="Alpine 3.19"
        puerto={6379}
      />
      <TarjetaServidor
        nombre="react-app-01"
        ip="10.0.2.31"
        sistema="React 19"
        puerto={8081}
      />
    </View>
  )
}

function Paso2() {
  return (
    <View style={styles.fondo}>
      <Text style={styles.titulo}>Detalle de nodo</Text>
      <Card titulo="web-01" subtitulo="Servidor web principal">
        <FilaInfo etiqueta="IP" valor="10.0.2.10" />
        <FilaInfo etiqueta="Puerto" valor="22 (SSH)" />
        <FilaInfo etiqueta="OS" valor="Ubuntu 24.04 LTS" />
        <FilaInfo etiqueta="CPU" valor="4 vCPU · 48%" />
        <FilaInfo etiqueta="RAM" valor="8 GB · 3.1 GB usados" />
      </Card>
      <Card titulo="Conexiones activas">
        <FilaInfo etiqueta="HTTP" valor="142 req/s" />
        <FilaInfo etiqueta="SSH" valor="2 sesiones" />
        <FilaInfo etiqueta="Último acceso" valor="hace 3 minutos" />
      </Card>
      <Card titulo="Disco" color='#21df70'>
        <FilaInfo etiqueta="Type" valor="SSD" />
        <FilaInfo etiqueta="Cap." valor="1TB" />
        <FilaInfo etiqueta="Array" valor="RAID 1" />
      </Card>
    </View>
  )
}

const styles = StyleSheet.create({
  fondo: {
    flex: 1,
    backgroundColor: '#f0f4f8',
    padding: 20,
    paddingTop: 60,
    gap: 12,
  },
  centrado: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  encabezado: {
    fontSize: 20,
    fontWeight: '700',
    color: '#1a237e',
    marginBottom: 4,
  },
  titulo: {
    fontSize: 20,
    fontWeight: '700',
    color: '#1a237e',
  },
})


// app/index.tsx — agrega al archivo existente

// ─── Paso 3 — Props opcionales ───────────────────────────────────────

type EstadoServidor = 'activo' | 'degradado' | 'inactivo' | 'error'

interface BadgeEstadoProps {
  estado: EstadoServidor
  tamaño?: number          // opcional — valor por defecto: 12
  mostrarIcono?: boolean   // opcional — valor por defecto: false
}

const COLOR_ESTADO: Record<EstadoServidor, { fondo: string; texto: string }> = {
  activo:    { fondo: '#e8f5e9', texto: '#2e7d32' },
  degradado: { fondo: '#fff8e1', texto: '#f57f17' },
  inactivo:  { fondo: '#f5f5f5', texto: '#616161' },
  error:     { fondo: '#fce4ec', texto: '#c62828' },
}

const ICONO_ESTADO: Record<EstadoServidor, string> = {
  activo:    '●',
  degradado: '◐',
  inactivo:  '○',
  error:     '✕',
}

function BadgeEstado({
  estado,
  tamaño = 12,
  mostrarIcono = false,
}: BadgeEstadoProps) {
  const colores = COLOR_ESTADO[estado]
  return (
    <View style={[estilos3.badge, { backgroundColor: colores.fondo }]}>
      {mostrarIcono && (
        <Text style={[estilos3.icono, { color: colores.texto, fontSize: tamaño }]}>
          {ICONO_ESTADO[estado]}{' '}
        </Text>
      )}
      <Text style={[estilos3.textoBadge, { color: colores.texto, fontSize: tamaño }]}>
        {estado.toUpperCase()}
      </Text>
    </View>
  )
}

interface FilaServidorProps {
  nombre: string
  ip: string
  estado: EstadoServidor
  latencia?: number        // ms — opcional
}

function FilaServidor({ nombre, ip, estado, latencia }: FilaServidorProps) {
  return (
    <View style={estilos3.fila}>
      <View style={estilos3.infoIzq}>
        <Text style={estilos3.nombreServidor}>{nombre}</Text>
        <Text style={estilos3.ipTexto}>{ip}</Text>
      </View>
      <View style={estilos3.infoDer}>
        {latencia !== undefined && (
          <Text style={estilos3.latencia}>{latencia} ms</Text>
        )}
        <BadgeEstado estado={estado} mostrarIcono tamaño={11} />
      </View>
    </View>
  )
}

function Paso3() {
  return (
    <View style={estilos3.fondo}>
      <Text style={estilos3.titulo}>Estado de la red</Text>
      <FilaServidor nombre="web-01"      ip="10.0.2.10" estado="activo"    latencia={8}   />
      <FilaServidor nombre="db-primary"  ip="10.0.2.20" estado="activo"    latencia={2}   />
      <FilaServidor nombre="cache-01"    ip="10.0.2.30" estado="degradado" latencia={340} />
      <FilaServidor nombre="worker-03"   ip="10.0.2.41" estado="error"                    />
      <FilaServidor nombre="backup-01"   ip="10.0.2.50" estado="inactivo"                 />
    </View>
  )
}

const estilos3 = StyleSheet.create({
  fondo: {
    flex: 1,
    backgroundColor: '#f0f4f8',
    padding: 20,
    paddingTop: 60,
    gap: 8,
  },
  titulo: {
    fontSize: 20,
    fontWeight: '700',
    color: '#1a237e',
    marginBottom: 8,
  },
  fila: {
    backgroundColor: '#ffffff',
    borderRadius: 10,
    paddingHorizontal: 16,
    paddingVertical: 14,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    shadowColor: '#000',
    shadowOpacity: 0.05,
    shadowRadius: 3,
    shadowOffset: { width: 0, height: 1 },
    elevation: 1,
  },
  infoIzq: { gap: 2 },
  infoDer: { alignItems: 'flex-end', gap: 4 },
  nombreServidor: { fontSize: 14, fontWeight: '600', color: '#1a1a1a' },
  ipTexto: { fontSize: 12, color: '#90a4ae', fontFamily: 'monospace' },
  latencia: { fontSize: 11, color: '#546e7a' },
  badge: {
    flexDirection: 'row',
    alignItems: 'center',
    borderRadius: 4,
    paddingHorizontal: 6,
    paddingVertical: 2,
  },
  icono: { fontWeight: '700' },
  textoBadge: { fontWeight: '600' },
})



// ─── Paso 4 — ScrollView y SafeAreaView ──────────────────────────────

const SERVIDORES_DEMO = [
  { id: '1',  nombre: 'web-01',       ip: '10.0.2.10', os: 'Ubuntu 24.04',  cpu: 48, ram: 62 },
  { id: '2',  nombre: 'web-02',       ip: '10.0.2.11', os: 'Ubuntu 24.04',  cpu: 51, ram: 58 },
  { id: '3',  nombre: 'db-primary',   ip: '10.0.2.20', os: 'Debian 12',     cpu: 12, ram: 74 },
  { id: '4',  nombre: 'db-replica',   ip: '10.0.2.21', os: 'Debian 12',     cpu: 8,  ram: 71 },
  { id: '5',  nombre: 'cache-01',     ip: '10.0.2.30', os: 'Alpine 3.19',   cpu: 4,  ram: 18 },
  { id: '6',  nombre: 'worker-01',    ip: '10.0.2.40', os: 'Ubuntu 22.04',  cpu: 89, ram: 45 },
  { id: '7',  nombre: 'worker-02',    ip: '10.0.2.41', os: 'Ubuntu 22.04',  cpu: 92, ram: 47 },
  { id: '8',  nombre: 'worker-03',    ip: '10.0.2.42', os: 'Ubuntu 22.04',  cpu: 3,  ram: 12 },
  { id: '9',  nombre: 'lb-01',        ip: '10.0.2.5',  os: 'Alpine 3.19',   cpu: 6,  ram: 9  },
  { id: '10', nombre: 'monitor-01',   ip: '10.0.2.60', os: 'Rocky Linux 9', cpu: 22, ram: 38 },
  { id: '11', nombre: 'backup-01',    ip: '10.0.2.50', os: 'Debian 12',     cpu: 2,  ram: 21 },
  { id: '12', nombre: 'git-server',   ip: '10.0.2.70', os: 'Ubuntu 22.04',  cpu: 15, ram: 33 },
]

interface BarraUsoProps {
  porcentaje: number
  etiqueta: string
}

function BarraUso({ porcentaje, etiqueta }: BarraUsoProps) {
  const color = porcentaje > 85 ? '#c62828'
              : porcentaje > 60 ? '#f57f17'
              : '#2e7d32'
  return (
    <View style={estilos4.barraFila}>
      <Text style={estilos4.barraEtiqueta}>{etiqueta}</Text>
      <View style={estilos4.barraFondo}>
        <View style={[estilos4.barraRelleno, { width: `${porcentaje}%` as any, backgroundColor: color }]} />
      </View>
      <Text style={[estilos4.barraPct, { color }]}>{porcentaje}%</Text>
    </View>
  )
}

function TarjetaNodo({ nombre, ip, os, cpu, ram }: typeof SERVIDORES_DEMO[0]) {
  return (
    <View style={estilos4.nodo}>
      <View style={estilos4.nodoEncabezado}>
        <Text style={estilos4.nodoNombre}>{nombre}</Text>
        <Text style={estilos4.nodoIp}>{ip}</Text>
      </View>
      <Text style={estilos4.nodoOs}>{os}</Text>
      <BarraUso porcentaje={cpu} etiqueta="CPU" />
      <BarraUso porcentaje={ram} etiqueta="RAM" />
    </View>
  )
}

function Paso4() {
  return (
    <SafeAreaView style={estilos4.safeArea}>
      <View style={estilos4.header}>
        <Text style={estilos4.headerTitulo}>Nodos del clúster</Text>
        <Text style={estilos4.headerSub}>{SERVIDORES_DEMO.length} servidores</Text>
      </View>
      <ScrollView
        style={estilos4.scroll}
        contentContainerStyle={estilos4.scrollContenido}
        showsVerticalScrollIndicator={false}
      >
        {SERVIDORES_DEMO.map((srv) => (
          <TarjetaNodo key={srv.id} {...srv} />
        ))}
      </ScrollView>
    </SafeAreaView>
  )
}

const estilos4 = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: '#0d1b2a',
  },
  header: {
    paddingHorizontal: 20,
    paddingTop: 16,
    paddingBottom: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#1c2e40',
  },
  headerTitulo: {
    fontSize: 20,
    fontWeight: '700',
    color: '#e3f2fd',
  },
  headerSub: {
    fontSize: 12,
    color: '#78909c',
    marginTop: 2,
  },
  scroll: { flex: 1 },
  scrollContenido: {
    padding: 16,
    gap: 10,
    paddingBottom: 40,
  },
  nodo: {
    backgroundColor: '#132232',
    borderRadius: 10,
    padding: 14,
    gap: 8,
    borderWidth: 1,
    borderColor: '#1c3548',
  },
  nodoEncabezado: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'baseline',
  },
  nodoNombre: {
    fontSize: 14,
    fontWeight: '700',
    color: '#e3f2fd',
  },
  nodoIp: {
    fontSize: 12,
    color: '#4fc3f7',
    fontFamily: 'monospace',
  },
  nodoOs: {
    fontSize: 11,
    color: '#546e7a',
    marginBottom: 2,
  },
  barraFila: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
  },
  barraEtiqueta: {
    fontSize: 11,
    color: '#78909c',
    width: 28,
  },
  barraFondo: {
    flex: 1,
    height: 4,
    backgroundColor: '#1c3548',
    borderRadius: 2,
    overflow: 'hidden',
  },
  barraRelleno: {
    height: '100%',
    borderRadius: 2,
  },
  barraPct: {
    fontSize: 11,
    fontWeight: '600',
    width: 34,
    textAlign: 'right',
  },
})


// app/index.tsx — agrega al archivo existente
import { useState } from 'react'
import { Modal, Pressable } from 'react-native'

// ─── Paso 5 — Modal de confirmación ──────────────────────────────────

interface ModalConfirmProps {
  visible: boolean
  titulo: string
  mensaje: string
  etiquetaConfirmar?: string
  etiquetaCancelar?: string
  onConfirmar: () => void
  onCancelar: () => void
}

function ModalConfirm({
  visible,
  titulo,
  mensaje,
  etiquetaConfirmar = 'Confirmar',
  etiquetaCancelar = 'Cancelar',
  onConfirmar,
  onCancelar,
}: ModalConfirmProps) {
  return (
    <Modal
      visible={visible}
      transparent
      animationType="fade"
      onRequestClose={onCancelar}
    >
      <Pressable style={estilos5.fondo} onPress={onCancelar}>
        <Pressable style={estilos5.dialogo} onPress={() => {}}>
          <Text style={estilos5.dialogoTitulo}>{titulo}</Text>
          <Text style={estilos5.dialogoMensaje}>{mensaje}</Text>
          <View style={estilos5.botones}>
            <Pressable
              style={[estilos5.boton, estilos5.botonCancelar]}
              onPress={onCancelar}
            >
              <Text style={estilos5.textoCancelar}>{etiquetaCancelar}</Text>
            </Pressable>
            <Pressable
              style={[estilos5.boton, estilos5.botonConfirmar]}
              onPress={onConfirmar}
            >
              <Text style={estilos5.textoConfirmar}>{etiquetaConfirmar}</Text>
            </Pressable>
          </View>
        </Pressable>
      </Pressable>
    </Modal>
  )
}

function Paso5() {
  const [modalVisible, setModalVisible] = useState(false)
  const [accionEjecutada, setAccionEjecutada] = useState<string | null>(null)

  return (
    <SafeAreaView style={estilos5.safeArea}>
      <Text style={estilos5.titulo}>Gestión de servidor</Text>
      <Text style={estilos5.subtitulo}>web-01 · 10.0.2.10</Text>

      <View style={estilos5.acciones}>
        <Pressable
          style={estilos5.botonAccion}
          onPress={() => {
            setAccionEjecutada(null)
            setModalVisible(true)
          }}
        >
          <Text style={estilos5.textoAccion}>Reiniciar servidor</Text>
        </Pressable>
      </View>

      {accionEjecutada && (
        <View style={estilos5.resultado}>
          <Text style={estilos5.textoResultado}>{accionEjecutada}</Text>
        </View>
      )}

      <ModalConfirm
        visible={modalVisible}
        titulo="Reiniciar servidor"
        mensaje={`¿Confirmas el reinicio de web-01?\nTodas las conexiones activas se interrumpirán.`}
        etiquetaConfirmar="Reiniciar"
        onConfirmar={() => {
          setModalVisible(false)
          setAccionEjecutada('Reinicio enviado a web-01 a las ' + new Date().toLocaleTimeString())
        }}
        onCancelar={() => setModalVisible(false)}
      />
    </SafeAreaView>
  )
}

const estilos5 = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: '#f0f4f8',
    padding: 24,
    paddingTop: 60,
  },
  titulo: {
    fontSize: 22,
    fontWeight: '700',
    color: '#1a237e',
  },
  subtitulo: {
    fontSize: 14,
    color: '#546e7a',
    marginTop: 4,
    marginBottom: 32,
    fontFamily: 'monospace',
  },
  acciones: { gap: 12 },
  botonAccion: {
    backgroundColor: '#b71c1c',
    borderRadius: 10,
    paddingVertical: 14,
    alignItems: 'center',
  },
  textoAccion: {
    color: '#fff',
    fontWeight: '700',
    fontSize: 15,
  },
  resultado: {
    marginTop: 24,
    backgroundColor: '#e8f5e9',
    borderRadius: 8,
    padding: 14,
  },
  textoResultado: {
    color: '#2e7d32',
    fontSize: 13,
    fontFamily: 'monospace',
  },
  // Modal
  fondo: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.55)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  dialogo: {
    backgroundColor: '#ffffff',
    borderRadius: 16,
    padding: 24,
    width: '85%',
    gap: 12,
    shadowColor: '#000',
    shadowOpacity: 0.2,
    shadowRadius: 12,
    shadowOffset: { width: 0, height: 6 },
    elevation: 10,
  },
  dialogoTitulo: {
    fontSize: 17,
    fontWeight: '700',
    color: '#1a1a1a',
  },
  dialogoMensaje: {
    fontSize: 14,
    color: '#546e7a',
    lineHeight: 20,
  },
  botones: {
    flexDirection: 'row',
    gap: 10,
    marginTop: 4,
  },
  boton: {
    flex: 1,
    borderRadius: 8,
    paddingVertical: 12,
    alignItems: 'center',
  },
  botonCancelar: {
    backgroundColor: '#f5f5f5',
  },
  botonConfirmar: {
    backgroundColor: '#b71c1c',
  },
  textoCancelar: {
    color: '#424242',
    fontWeight: '600',
    fontSize: 14,
  },
  textoConfirmar: {
    color: '#ffffff',
    fontWeight: '700',
    fontSize: 14,
  },
})


// app/index.tsx — agrega al archivo existente

// ─── Paso 6 — Pantalla completa de detalle ───────────────────────────

interface AccionProps {
  etiqueta: string
  color: string
  onPress: () => void
}

function BotonAccion({ etiqueta, color, onPress }: AccionProps) {
  return (
    <Pressable
      style={({ pressed }) => [
        estilos6.botonAccion,
        { backgroundColor: color },
        pressed && { opacity: 0.75 },
      ]}
      onPress={onPress}
    >
      <Text style={estilos6.textoBotonAccion}>{etiqueta}</Text>
    </Pressable>
  )
}

function Paso6() {
  const [modalVisible, setModalVisible] = useState(false)
  const [accionPendiente, setAccionPendiente] = useState<string>('')
  const [log, setLog] = useState<string[]>([])

  function pedirConfirmacion(accion: string) {
    setAccionPendiente(accion)
    setModalVisible(true)
  }

  function ejecutarAccion() {
    const entrada = `[${new Date().toLocaleTimeString()}] ${accionPendiente} ejecutado en web-01`
    setLog((prev) => [entrada, ...prev])
    setModalVisible(false)
  }

  return (
    <SafeAreaView style={estilos6.safeArea}>
      {/* Cabecera fija — fuera del scroll */}
      <View style={estilos6.cabecera}>
        <View>
          <Text style={estilos6.cabNombre}>web-01</Text>
          <Text style={estilos6.cabIp}>10.0.2.10 · Ubuntu 24.04 LTS</Text>
        </View>
        <BadgeEstado estado="activo" mostrarIcono tamaño={12} />
      </View>

      {/* Contenido desplazable */}
      <ScrollView
        contentContainerStyle={estilos6.scrollContenido}
        showsVerticalScrollIndicator={false}
      >
        {/* Card de métricas */}
        <Card titulo="Métricas en tiempo real" subtitulo="Última actualización: hace 30 s">
          <FilaInfo etiqueta="CPU" valor="48% · 4 vCPU" />
          <FilaInfo etiqueta="RAM" valor="3.1 / 8 GB (38%)" />
          <FilaInfo etiqueta="Disco /" valor="42 / 100 GB (42%)" />
          <FilaInfo etiqueta="Red E/S" valor="12.4 Mbps ↓ · 3.1 Mbps ↑" />
          <FilaInfo etiqueta="Uptime" valor="47 días, 6 horas" />
        </Card>

        {/* Card de configuración */}
        <Card titulo="Configuración">
          <FilaInfo etiqueta="Hostname" valor="web-01.cluster.local" />
          <FilaInfo etiqueta="SSH" valor="Puerto 22 · clave RSA-4096" />
          <FilaInfo etiqueta="Firewall" valor="ufw activo · 3 reglas" />
          <FilaInfo etiqueta="Zona" valor="us-east-1a" />
          <FilaInfo etiqueta="Proveedor" valor="Bare-metal DC2" />
        </Card>

        {/* Card de acciones */}
        <Card titulo="Acciones">
          <View style={estilos6.gridAcciones}>
            <BotonAccion
              etiqueta="Reiniciar"
              color="#1565c0"
              onPress={() => pedirConfirmacion('Reinicio')}
            />
            <BotonAccion
              etiqueta="Apagar"
              color="#b71c1c"
              onPress={() => pedirConfirmacion('Apagado')}
            />
            <BotonAccion
              etiqueta="SSH"
              color="#2e7d32"
              onPress={() => pedirConfirmacion('Conexión SSH')}
            />
            <BotonAccion
              etiqueta="Ver logs"
              color="#6a1b9a"
              onPress={() => pedirConfirmacion('Descarga de logs')}
            />
          </View>
        </Card>

        {/* Card de log de actividad */}
        {log.length > 0 && (
          <Card titulo="Actividad reciente">
            {log.map((entrada, i) => (
              <Text key={i} style={estilos6.entradaLog}>{entrada}</Text>
            ))}
          </Card>
        )}
      </ScrollView>

      {/* Modal reutilizado del Paso 5 */}
      <ModalConfirm
        visible={modalVisible}
        titulo={`Confirmar: ${accionPendiente}`}
        mensaje={`¿Ejecutar "${accionPendiente}" en web-01?\nEsta acción afectará el servicio.`}
        etiquetaConfirmar="Ejecutar"
        onConfirmar={ejecutarAccion}
        onCancelar={() => setModalVisible(false)}
      />
    </SafeAreaView>
  )
}

const estilos6 = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: '#f0f4f8',
  },
  cabecera: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 20,
    paddingVertical: 14,
    backgroundColor: '#ffffff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e7ef',
  },
  cabNombre: {
    fontSize: 18,
    fontWeight: '700',
    color: '#1a237e',
  },
  cabIp: {
    fontSize: 12,
    color: '#78909c',
    fontFamily: 'monospace',
    marginTop: 2,
  },
  scrollContenido: {
    padding: 16,
    gap: 14,
    paddingBottom: 40,
  },
  gridAcciones: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 10,
  },
  botonAccion: {
    borderRadius: 8,
    paddingVertical: 10,
    paddingHorizontal: 16,
    minWidth: '45%',
    alignItems: 'center',
  },
  textoBotonAccion: {
    color: '#ffffff',
    fontWeight: '600',
    fontSize: 14,
  },
  entradaLog: {
    fontSize: 11,
    color: '#2e7d32',
    fontFamily: 'monospace',
    lineHeight: 18,
  },
})