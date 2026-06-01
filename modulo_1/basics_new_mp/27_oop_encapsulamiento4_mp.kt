class CargaHorariaBootcamp(val horasTeoria: Double, val horasPractica: Double) {

    // Propiedades calculadas dinámicamente mediante GET personalizado
    val horasTotales: Double get() = horasTeoria + horasPractica
    val factorIntensidad: Double get() = 2 * (horasTeoria + horasPractica)

    // =========================================================================
    // CONSTRUCTORES SECUNDARIOS (Sobrecarga de inicialización)
    // =========================================================================
    
    // Constructor Secundario 1: Si el bootcamp es equilibrado, recibe un solo valor y lo duplica usando this(lado, lado)
    constructor(horasEquilibradas: Double) : this(horasEquilibradas, horasEquilibradas)

    // Constructor Secundario 2: Si el backend envía números enteros (Int), los convierte a Double de forma transparente
    constructor(horasTeoriaInt: Int, horasPracticaInt: Int) : this(horasTeoriaInt.toDouble(), horasPracticaInt.toDouble())

    // Sobreescritura del método clásico toString() para formatear la salida en logs de auditoría
    override fun toString() = "📚 Distribución Bootcamp: (${horasTeoria}h Teoría x ${horasPractica}h Práctica) | Carga Total = ${horasTotales} hrs."
}

// =========================================================================
// HILO PRINCIPAL DE EJECUCIÓN (main)
// =========================================================================
fun main() {
    println("=== MÓDULO DE PLANIFICACIÓN ACADÉMICA (CONSTRUCTORES SECUNDARIOS) ===\n")

    // 1. Instanciación usando el Constructor Primario (Double, Double)
    val rutaBackend = CargaHorariaBootcamp(40.0, 60.0)
    
    // 2. Instanciación usando el Constructor Secundario 1 (Un solo Double - Estructura simétrica)
    val tallerExpreso = CargaHorariaBootcamp(15.0) 
    
    // 3. Instanciación usando el Constructor Secundario 2 (Int, Int - Casteo automático interno)
    val moduloOdoo = CargaHorariaBootcamp(20, 30) 

    // Al imprimir las instancias, Kotlin invoca automáticamente nuestro método 'toString()' sobreescrito
    println(rutaBackend)
    println(tallerExpreso)
    println(moduloOdoo)
}