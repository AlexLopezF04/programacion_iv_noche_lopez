// =========================================================================
// 1. CLASE ENCAPSULADA CON HELPERS PRIVADOS
// Caso de uso: Control de balance y transacciones de tokens académicos
// =========================================================================
class CuentaEstudianteToken(titular: String, balanceInicial: Double) {

    val titular: String = titular

    private var balance: Double = balanceInicial

    internal val cuentaId: String = "ST-EC-${(100000..999999).random()}"

    // Función helper privada: Centraliza el formateo. Si cambia la moneda o el diseño, se edita solo aquí.
    private fun formatearMetrica(valor: Double): String = "${"%.2f".format(valor)} XP"

    fun depositarTokens(monto: Double) {
        require(monto > 0) { "El monto de tokens a depositar debe ser positivo" }
        balance += monto
        println("📥 Tokens Acreditados: ${formatearMetrica(monto)} | Nuevo Balance: ${consultarTokens()}")
    }

    fun consumirTokens(monto: Double): Boolean {
        require(monto > 0) { "El monto de tokens a consumir debe ser positivo" }
        if (monto > balance) {
            println("❌ Operación Rechazada: Tokens insuficientes para procesar la solicitud.")
            return false
        }
        balance -= monto
        println("💻 Tokens Consumidos: ${formatearMetrica(monto)} | Nuevo Balance: ${consultarTokens()}")
        return true
    }

    fun consultarTokens(): String = formatearMetrica(balance)
}

// =========================================================================
// 2. CLASE CON GETTERS Y SETTERS PERSONALIZADOS (Backing Field)
// Caso de uso: Gestión de puntuación y rendimiento del alumno
// =========================================================================
class RecordAcademico(scoreBase: Double) {

    // Propiedad con SET personalizado
    var score: Double = scoreBase
        set(value) {
            // Validación defensiva: Evita estados imposibles en el sistema escolar
            require(value in 0.0..100.0) { "El score debe estar estrictamente en el rango de 0 a 100" }
            // 'field' es la palabra clave que hace referencia directa a la variable de memoria oculta
            field = value
        }

    // Propiedad calculada con GET personalizado (Equivalencia en escala americana)
    val equivalenciaLetra: String
        get() = when {
            score >= 90.0 -> "A"
            score >= 80.0 -> "B"
            score >= 70.0 -> "C"
            else          -> "F"
        }

    // Propiedad calculada con GET personalizado (Puntaje normalizado de 0.0 a 1.0)
    val factorNormalizado: Double
        get() = score / 100.0

    // Propiedad calculada con GET personalizado (Evaluador del estatus del estudiante)
    val descriptorEstatus: String
        get() = when {
            score < 60.0 -> "Rendimiento Crítico (Requiere tutorías de emergencia)"
            score < 70.0 -> "En Revisión (Bajo el umbral mínimo de aprobación)"
            score < 85.0 -> "Estudiante Regular (Progreso estable)"
            score < 95.0 -> "Estudiante Destacado (Candidato a monitorías)"
            else         -> "Estudiante de Excelencia (Insignia de Honor)"
        }
}

// =========================================================================
// HILO PRINCIPAL DE EJECUCIÓN (main)
// =========================================================================
fun main() {
    // ---- Flujo Cuenta Estudiante ----
    println("=== MÓDULO DE TOKENS ACADÉMICOS ===")
    val cuenta = CuentaEstudianteToken("Alexander Lopez", 1000.0)

    cuenta.depositarTokens(500.0)
    cuenta.consumirTokens(200.0)
    cuenta.consumirTokens(2000.0) // Intento de sobreconsumo

    println("Titular: ${cuenta.titular}")
    println("Identificador de cuenta (Internal): ${cuenta.cuentaId}")
    println("Balance final: ${cuenta.consultarTokens()}")

    println("\n--------------------------------------------------\n")

    // ---- Flujo Récord Académico (Getters & Setters) ----
    println("=== MÓDULO DE EVALUACIÓN DINÁMICA ===")
    val record = RecordAcademico(88.5)
    
    // Al acceder a las propiedades, Kotlin ejecuta transparentemente los métodos get() personalizados
    println("Nota: ${record.score} pts | Letra asignada: ${record.equivalenciaLetra} | Factor: ${record.factorNormalizado}")
    println("Estado Académico: ${record.descriptorEstatus}")

    println("\n--- Actualización de calificaciones en tiempo real ---")
    // Al asignar un valor, Kotlin ejecuta el método set() personalizado con su validación interna
    record.score = 55.0 
    println("Nueva Nota: ${record.score} pts ➡️ Diagnóstico: ${record.descriptorEstatus}")
    
    // Descomentar la siguiente línea provocará que el programa falle de forma segura gracias al 'require'
    // record.score = -10.0
} 
