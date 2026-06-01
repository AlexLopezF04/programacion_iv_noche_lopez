// =========================================================================
// ENUM CLASS: Máquina de Estados del Progreso de Retos Técnicos
// Cada constante tiene propiedades personalizadas (descripción y bandera terminal)
// =========================================================================
enum class EstadoAsignacion(val descripcion: String, val esTerminal: Boolean) {
    PENDIENTE  ("Esperando entrega en el repositorio", false),
    EN_PROCESO ("Código siendo evaluado por el sistema de CI/CD", false),
    COMPLETADO ("Evaluación finalizada con éxito. Créditos aprobados", true),
    FALLIDO    ("Evaluación finalizada con errores en pruebas unitarias", true),
    CANCELADO  ("Entrega desestimada o cancelada por el desarrollador", true);

    // Método encapsulado para gobernar el flujo de la Máquina de Estados (State Machine)
    fun puedeTransicionarA(siguiente: EstadoAsignacion): Boolean = when (this) {
        PENDIENTE  -> siguiente == EN_PROCESO || siguiente == CANCELADO
        EN_PROCESO -> siguiente == COMPLETADO || siguiente == FALLIDO
        else       -> false // Los estados terminales (COMPLETADO, FALLIDO, CANCELADO) no pueden regresar
    }
}

// =========================================================================
// HILO PRINCIPAL DE EJECUCIÓN (main)
// =========================================================================
fun main() {
    println("=== MÓDULO DE GESTIÓN DE ESTADOS ACADÉMICOS (ENUMS) ===\n")

    // Instancia del estado actual extraído de la base de datos simulada
    val estadoActual = EstadoAsignacion.EN_PROCESO
    
    println("--- 🔎 1. Auditoría de Propiedades del Estado ---")
    println("Detalle técnico: ${estadoActual.descripcion}")
    println("¿El estado actual cierra el ciclo de vida? (esTerminal): ${estadoActual.esTerminal}")

    // =========================================================================
    // WHEN EXHAUSTIVO: Como 'when' se usa como expresión de asignación, Kotlin
    // obliga a mapear todos los casos del Enum. Si agregas un nuevo estado mañana,
    // el código arrojará error de compilación aquí hasta que lo manejes. ¡Cero 'else'!
    // =========================================================================
    println("\n--- 🎨 2. Mapeo Exhaustivo de Interfaz Gráfica ---")
    val badgeIcono = when (estadoActual) {
        EstadoAsignacion.PENDIENTE  -> "⏰ [PENDIENTE]"
        EstadoAsignacion.EN_PROCESO -> "⏳ [EVALUANDO]"
        EstadoAsignacion.COMPLETADO -> "✅ [APROBADO]"
        EstadoAsignacion.FALLIDO    -> "❌ [REPROBADO]"
        EstadoAsignacion.CANCELADO  -> "🚫 [ANULADO]"
    }
    println("Badge visual para la consola del estudiante: $badgeIcono")

    // --- 🔄 3. Validación de Reglas de Transición de la Máquina de Estados ---
    println("\n--- 🔄 3. Reglas de Transición de Estados ---")
    
    val intentoAprobacion = EstadoAsignacion.COMPLETADO
    println("¿Un reto 'En Proceso' puede pasar directamente a 'Completado'?: ${estadoActual.puedeTransicionarA(intentoAprobacion)}") // true
    
    val intentoReabrir = EstadoAsignacion.PENDIENTE
    val estadoFinalizado = EstadoAsignacion.COMPLETADO
    println("¿Un reto ya 'Completado' puede forzar un regreso a 'Pendiente'?: ${estadoFinalizado.puedeTransicionarA(intentoReabrir)}") // false
}