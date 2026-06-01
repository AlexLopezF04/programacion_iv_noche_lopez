// =========================================================================
// SUPERCLASE ABSTRACTA: Define la plantilla y lógica común reutilizable
// =========================================================================
abstract class NotificacionCanal(val canalNombre: String) {
    
    // Propiedades y métodos abstractos: Las subclases DEBEN darles un comportamiento real (Herencia obligatoria)
    abstract val tarifaEnvioCreditos: Double
    abstract fun generarContenidoFormateado(): String

    // Método concreto (Implementado): Disponible inmediatamente para todos los hijos por igual
    fun compararCostoInversion(otraNotificacion: NotificacionCanal): String {
        return when {
            tarifaEnvioCreditos > otraNotificacion.tarifaEnvioCreditos -> 
                "⚠️ [$canalNombre] consume más créditos de infraestructura que [${otraNotificacion.canalNombre}]."
            tarifaEnvioCreditos < otraNotificacion.tarifaEnvioCreditos -> 
                "⚡ [$canalNombre] es económicamente más eficiente que [${otraNotificacion.canalNombre}]."
            else -> 
                "💼 Ambos canales ([$canalNombre] y [${otraNotificacion.canalNombre}]) tienen la misma tarifa de consumo."
        }
    }

    // Polimorfismo en acción: El método toString() nativo utiliza propiedades que se computarán en el hijo
    override fun toString(): String {
        return "📡 Canal: $canalNombre | Tarifa: $tarifaEnvioCreditos XP | Vista Previa: '${generarContenidoFormateado()}'"
    }
}

// =========================================================================
// SUBCLASES CONCRETAS: Implementan el comportamiento obligatorio
// =========================================================================

class NotificacionPush(val tokenDispositivo: String, val alertaTexto: String) : NotificacionCanal("Firebase Push Notification") {
    // Implementación usando getters calculados dinámicos
    override val tarifaEnvioCreditos: Double get() = 0.05 // Tarifa baja por consumo de sockets internos
    override fun generarContenidoFormateado() = "📱 PUSH -> $alertaTexto"
}

class NotificacionEmail(val correoDestino: String, val asunto: String) : NotificacionCanal("SMTP Email Server") {
    override val tarifaEnvioCreditos: Double get() = 0.25 // Mayor costo por verificación de entregabilidad
    override fun generarContenidoFormateado() = "📧 EMAIL [$asunto] -> Enviado a $correoDestino"
}

class NotificacionSMS(val numeroCelular: String, val mensajeCorto: String) : NotificacionCanal("Twilio SMS Gateway") {
    // Cálculo matemático simulado: La tarifa varía según la longitud del mensaje SMS
    override val tarifaEnvioCreditos: Double get() = if (mensajeCorto.length > 160) 0.80 else 0.40
    override fun generarContenidoFormateado() = "💬 SMS -> $mensajeCorto"
}

// =========================================================================
// HILO PRINCIPAL DE EJECUCIÓN (main)
// =========================================================================
fun main() {
    println("=== MÓDULO CORE: MICROSERVICIO DE NOTIFICACIONES (CLASES ABSTRACTAS) ===\n")

    // POLIMORFISMO TOTAL: La lista se tipa con la clase abstracta superior, pero almacena instancias reales de los hijos
    val bandejaSalida: List<NotificacionCanal> = listOf(
        NotificacionPush("tok_4504_dev", "¡Tu reto de Kotlin ha sido aprobado!"),
        NotificacionEmail("alexander@ecuador.dev", "Confirmación de Matrícula - Modulo Odoo 18"),
        NotificacionSMS("+593999999999", "Alerta: Tu entorno Sandbox de Azure expirará en 24 horas.")
    )

    // Iteración limpia: Se ejecuta el toString() sobreescrito de la clase abstracta
    bandejaSalida.forEach { notificacion -> println(notificacion) }

    // Uso de operadores funcionales avanzados sobre la jerarquía abstracta
    println("\n--- Análisis de Métricas de Infraestructura ---")
    val canalMasCostoso = bandejaSalida.maxByOrNull { it.tarifaEnvioCreditos }
    println("🚨 Canal que requiere mayor presupuesto técnico: ${canalMasCostoso?.canalNombre}")

    // Prueba del método concreto compartido por herencia pura
    println("\n--- Comparador de Costos en Caliente ---")
    println(bandejaSalida[0].compararCostoInversion(bandejaSalida[1]))
}