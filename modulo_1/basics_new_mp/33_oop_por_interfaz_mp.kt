// =========================================================================
// INTERFAZ: Define el contrato arquitectónico de la plataforma
// =========================================================================
interface Transaccionable {
    // Las propiedades en una interfaz pueden ser abstractas (obligando a la clase a proveerlas)
    val pasarelaNombre: String
    
    // Firma del método: No tiene cuerpo {}, solo describe los parámetros y el tipo de retorno
    fun procesarPago(monto: Double): Boolean
}

// =========================================================================
// IMPLEMENTACIONES CONCRETAS (Definen el "CÓMO")
// =========================================================================

class TarjetaCreditoEcuador(val numeroMascara: String) : Transaccionable {
    override val pasarelaNombre = "Tarjeta de Crédito (Datafast / Medianet)"
    
    override fun procesarPago(monto: Double): Boolean {
        println("💳 Transacción Bancaria: Cargando \$${"%.2f".format(monto)} a la cuenta $numeroMascara")
        return true // Simulación de respuesta exitosa del banco
    }
}

class PagoPayPal(val correoEstudiante: String) : Transaccionable {
    override val pasarelaNombre = "PayPal Internacional"
    
    override fun procesarPago(monto: Double): Boolean {
        println("🅿️ Token de Seguridad: Enviando \$${"%.2f".format(monto)} desde el ID: $correoEstudiante")
        return true
    }
}

class TransferenciaPichincha(val numeroComprobante: String) : Transaccionable {
    override val pasarelaNombre = "Transferencia Directa Banco Pichincha"
    
    override fun procesarPago(monto: Double): Boolean {
        println("🏦 Verificación de Fondos: Procesando comprobante #$numeroComprobante por \$${"%.2f".format(monto)}")
        return true
    }
}

class PagoEfectivoGAD : Transaccionable {
    override val pasarelaNombre = "Depósito en Ventanilla Física (GAD)"
    
    override fun procesarPago(monto: Double): Boolean {
        println("💵 Recaudación: Efectivo recibido físicamente en ventanilla por \$${"%.2f".format(monto)}")
        return true
    }
}

// =========================================================================
// CONTROLADOR LOGÍSTICO (Polimorfismo Puro)
// =========================================================================

// Esta función es agnóstica a los detalles de bajo nivel. Cumple el principio Abierto/Cerrado (SOLID)
fun procesarInscripcionCurso(montoMatricula: Double, pasarela: Transaccionable) {
    println("\n[SISTEMA DE FACTURACIÓN]: Iniciando pasarela con: ${pasarela.pasarelaNombre}...")
    
    // Invocación polimórfica: El método se comporta distinto en tiempo de ejecución según la instancia real
    val transaccionCompletada = pasarela.procesarPago(montoMatricula)
    
    if (transaccionCompletada) {
        println("✅ Matrícula Exitosa: Acceso al curso concedido inmediatamente.")
    } else {
        println("❌ Pago Fallido: Transacción rechazada por el proveedor.")
    }
}

// =========================================================================
// HILO PRINCIPAL DE EJECUCIÓN (main)
// =========================================================================
fun main() {
    println("=== MÓDULO DE RECAUDACIÓN Y MATRÍCULAS (POLIMORFISMO DE INTERFACES) ===")

    // Creamos una lista polimórfica agrupada bajo el tipo de la interfaz común
    val pasarelasHabilitadas: List<Transaccionable> = listOf(
        TarjetaCreditoEcuador("**** **** **** 4504"),
        PagoPayPal("alexander@ecuador.dev"),
        TransferenciaPichincha("TRX-99821"),
        PagoEfectivoGAD()
    )

    // Iteración funcional: Mandamos la misma tarifa a diferentes métodos de pago
    val costoInscripcion = 99.99
    
    pasarelasHabilitadas.forEach { metodo -> 
        procesarInscripcionCurso(costoInscripcion, metodo) 
    }
}