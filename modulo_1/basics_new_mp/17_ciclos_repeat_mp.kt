fun main() {
    println("=== MÓDULO ACADÉMICO: EVALUACIÓN DE CODE REVIEWS ===")
    
    println("¿Cuántas entregas de proyectos deseas calificar para este estudiante?:")
    // Si el usuario presiona Enter o ingresa basura, por defecto evaluamos 3 entregas
    val mediciones = readLine()?.toIntOrNull() ?: 3
    
    var totalNotasAcumuladas = 0
    
    // Función nativa 'repeat': ejecuta el bloque exactamente el número de veces indicado en 'mediciones'
    repeat(mediciones) { i ->
        // 'i' actúa como el índice del ciclo, iniciando en 0. Le sumamos 1 para la visualización del usuario.
        println("📝 Ingrese la nota para la Entrega N° ${i + 1} (Escala 1 al 100):")
        val notaProyecto = readLine()?.toIntOrNull() ?: 0
        
        // Acumulamos el valor directamente en nuestra variable mutable
        totalNotasAcumuladas += notaProyecto
    }
    
    // Cálculo del promedio simple basado en las iteraciones completadas
    val promedioFinal = totalNotasAcumuladas / mediciones
    
    println("\n==================================================")
    println("📊 Promedio Académico Final: $promedioFinal / 100 pts")
    
    // 'when' embebido directamente como expresión dentro del String Template
    println("Estatus del Estudiante: ${
        when {
            promedioFinal < 70 -> "Reprobado (Debe recursar el módulo) ❌"
            promedioFinal <= 90 -> "Aprobado (Certificación Estándar) ✅"
            else -> "Aprobado con Excelencia (Insignia de Honor y Destacado) 🏆"
        }
    }")
    println("==================================================")
}