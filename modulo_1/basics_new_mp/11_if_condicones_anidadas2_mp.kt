fun main() {
    println("=== MÓDULO DE BECAS Y LOGICA CONDICIONAL ANIDADA AVANZADA ===")
    println("¿El usuario es un estudiante graduado de cursos anteriores? s/n")
    
    // Corrección sintáctica aplicada: operador seguro antes de .lowercase()
    val esGraduadoAntiguo = readLine()?.trim()?.lowercase() == "s"
    
    println("Ingrese el presupuesto estimado que dispone para este nuevo Bootcamp (USD): ")
    val presupuestoInput = readLine()?.toIntOrNull() ?: 0
    
    // Condición Principal (Nivel 1)
    if (esGraduadoAntiguo) {
        println("\n🎓 Perfil verificado: Alumno Alumni (Aplica a tasas preferenciales).")
        
        // Estructura Anidada Compleja (Nivel 2: if -> else if -> else)
        if (presupuestoInput < 50) {
            println("🎁 BENEFICIO: Califica para Beca Completa de Inclusión por presupuesto limitado.")
            
        } else if (presupuestoInput > 100) {
            println("🚀 BENEFICIO: Califica para el programa de Mentoría Premium con acceso prioritario.")
            
        } else {
            println("✅ BENEFICIO: Califica para Descuento Estándar del 30% por Fidelidad.")
        }
        
    } else {
        // Camino alterno de la Condición Principal (Usuario Nuevo)
        println("\n👋 Perfil verificado: Estudiante Nuevo en la plataforma.")
        
        // Estructura Anidada con Operador Lógico OR (||)
        if (presupuestoInput < 60 || presupuestoInput > 100) {
            println("ℹ️ NOTA: Tu presupuesto está fuera de la campaña de preventa regular para nuevos ingresos.")
        } else {
            println("✅ NOTA: Tu presupuesto se ajusta perfectamente al precio de la campaña promocional vigente.")
        }
    }
}