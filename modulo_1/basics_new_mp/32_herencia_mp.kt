// =========================================================================
// 1. CLASE FINAL POR DEFECTO (Seguridad del Sistema Core)
// Caso de uso: Una clase de utilidades críticas que nadie debe alterar ni heredar.
// =========================================================================
class EvaluadorEcuador(val region: String)
// class EvaluadorQuito : EvaluadorEcuador("Pichincha") // ERROR DE COMPILACIÓN — EvaluadorEcuador es final

// =========================================================================
// 2. SUPERCLASE ABIERTA (open class)
// Caso de uso: Estructura base para cualquier tipo de examen o entrega técnica.
// =========================================================================
open class Evaluacion(val titulo: String, val puntajeMaximo: Double) {

    // open: Las subclases TIENEN PERMISO de sobreescribir esta lógica
    open fun procesarCalificacion() = println("📝 Procesando nota base para '$titulo' sobre un máximo de $puntajeMaximo pts.")
    
    open fun generarFichaResumen() = "Asignación: $titulo"

    // Sin open: Método final heredable pero INMUTABLE. Ninguna subclase puede alterar el flujo de logs.
    fun registrarAuditoria() = println("💾 [AUDITORÍA]: Intento de evaluación registrado en logs del sistema.")
}

// =========================================================================
// 3. SUBCLASES CON POLIMORFISMO (override)
// =========================================================================

// Subclase A: Modela un examen clásico de opción múltiple
class ExamenTeorico(titulo: String) : Evaluacion(titulo, 100.0) {
    
    override fun procesarCalificacion() {
        super.procesarCalificacion() // Reutiliza el comportamiento del padre (imprime el log base)
        println("📥 [Filtro Teórico]: Respuestas enviadas al validador automático de opciones múltiples.")
    }

    override fun generarFichaResumen() = "${super.generarFichaResumen()}, tipo Cuestionario Teórico."
}

// Subclase B: Modela un reto práctico de programación (Ej: Módulo Odoo o Script Kotlin)
class LaboratorioPractico(titulo: String, val requiereContenedor: Boolean) : Evaluacion(titulo, 10.0) {
    
    override fun generarFichaResumen() = 
        "${super.generarFichaResumen()}, tipo Laboratorio Práctico ${if (requiereContenedor) "[Entorno Docker Activado]" else "[Editor Local]"}"
}

// =========================================================================
// HILO PRINCIPAL DE EJECUCIÓN (main)
// =========================================================================
fun main() {
    println("=== MÓDULO ACADÉMICO: MOTOR DE EVALUACIONES (HERENCIA) ===\n")

    // Instancia de Examen Teórico (Sufre polimorfismo en su flujo de calificación)
    val primerParcial = ExamenTeorico("Examen de Calidad de Software")
    primerParcial.procesarCalificacion()
    // Salida:
    // 📝 Procesando nota base para 'Examen de Calidad de Software' sobre un máximo de 100.0 pts.
    // 📥 [Filtro Teórico]: Respuestas enviadas al validador automático de opciones múltiples.

    println("\n--------------------------------------------------\n")

    // Instancia de Laboratorio Práctico (Con propiedad extendida e interpolación condicional)
    val retoNest = LaboratorioPractico("Proyecto Final Backend NestJS", true)
    println(retoNest.generarFichaResumen())  
    // Salida: Asignación: Proyecto Final Backend NestJS, tipo Laboratorio Práctico [Entorno Docker Activado]

    // Demostración de Herencia Pura: Ambos heredan métodos sellados sin reescribir código
    println("\n--- Ejecución de Métodos Heredados Inmutables ---")
    primerParcial.registrarAuditoria() // Método de la clase padre ejecutado desde el hijo
    retoNest.registrarAuditoria()      // Método de la clase padre ejecutado desde el hijo
}