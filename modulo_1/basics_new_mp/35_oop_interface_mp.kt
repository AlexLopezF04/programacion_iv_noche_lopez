// =========================================================================
// INTERFACES: Contratos de Habilidades (Capabilities)
// =========================================================================

interface Exportable {
    val idUnico: String
    
    fun exportarAFormatoPlano(): String
    
    // Propiedad calculada con implementación por defecto (Default Getter)
    val versionEsquema: Int get() = 1 
}

interface Inspeccionable {
    // Lista inmutable que cada clase concreta definirá cómo llenar
    val registroErrores: List<String>
    
    // Lógica por defecto basada en el estado de la propiedad abstracta
    val esEstructuraValida: Boolean get() = registroErrores.isEmpty()

    fun ejecutarValidacion(): Boolean
    
    // Método por defecto con cuerpo lógico incorporado (Default Method)
    fun desplegarDiagnostico() {
        if (esEstructuraValida) {
            println("✅ Diagnóstico Core: Parámetros íntegros. Objeto listo para persistencia.")
        } else {
            println("⚠️ Diagnóstico Core: Se detectaron fallos estructurales:")
            registroErrores.forEach { error -> println("   ❌ $error") }
        }
    }
}

// =========================================================================
// DATA CLASS CON HERENCIA MÚLTIPLE (Polimorfismo por Composición)
// =========================================================================
data class InscripcionCurso(
    override val idUnico: String,
    val estudianteId: String,
    val codigoMóduloOdoo: String,
    val inversionXP: Double
) : Exportable, Inspeccionable {

    // 1. Cumplimiento del contrato 'Exportable' (Formateo CSV/Plano para logs)
    override fun exportarAFormatoPlano() = 
        "$idUnico|$estudianteId|$codigoMóduloOdoo|${"%.2f".format(inversionXP)}"

    // 2. Cumplimiento del contrato 'Inspeccionable' usando buildList (DSL de Kotlin)
    override val registroErrores: List<String>
        get() = buildList {
            if (estudianteId.isBlank()) add("El identificador del estudiante no puede estar vacío.")
            if (codigoMóduloOdoo.isBlank()) add("La referencia del módulo Odoo de Pichincha es obligatoria.")
            if (inversionXP < 0) add("La inversión de créditos académicos (XP) no puede ser un valor negativo.")
        }

    override fun ejecutarValidacion(): Boolean = esEstructuraValida
}

// =========================================================================
// HILO PRINCIPAL DE EJECUCIÓN (main)
// =========================================================================
fun main() {
    println("=== MÓDULO DE ADMISIÓN: HERENCIA MÚLTIPLE POR CONTRATOS ===\n")

    // Instancia A: Caso ideal (Datos correctos)
    val inscripcionOk = InscripcionCurso("INS-001", "AlexLopezF04", "ODOO-18-EPS", 45.0)
    
    // Instancia B: Caso crítico (Forzando múltiples fallas para validar robustez)
    val inscripcionCorrupta = InscripcionCurso("INS-002", "", "", -15.5)

    // =========================================================================
    // POLIMORFISMO POR INTERFAZ EN FUNCIONES LOCALES
    // =========================================================================
    
    // Esta función solo exige que el objeto sea Exportable
    fun procesarCapaSerializacion(entidad: Exportable) {
        println("📡 [Streaming Engine] -> Enviando payload plano: ${entidad.exportarAFormatoPlano()}")
    }

    // Esta función solo exige que el objeto sea Inspeccionable
    fun procesarCapaValidacion(entidad: Inspeccionable) {
        println("🛡️ [Security Gateway] -> Evaluando reglas de dominio...")
        println("¿Estructura aprobada?: ${entidad.esEstructuraValida}")
        entidad.desplegarDiagnostico() // Invoca el método con comportamiento por defecto
    }

    // --- Flujo de Procesamiento para Inscripción Exitosa ---
    println("--- 📂 Procesando Registro 1 (Exitoso) ---")
    procesarCapaSerializacion(inscripcionOk)
    procesarCapaValidacion(inscripcionOk)

    println("\n--------------------------------------------------\n")

    // --- Flujo de Procesamiento para Inscripción Corrupta ---
    println("--- 📂 Procesando Registro 2 (Rechazado) ---")
    procesarCapaSerializacion(inscripcionCorrupta)
    procesarCapaValidacion(inscripcionCorrupta)
}