fun main() {
    println("=== MÓDULO DE VERIFICACIÓN DE REQUISITOS (CONDICIONES ANIDADAS) ===")
    println("¿El estudiante está inscrito en la modalidad de Bootcamp/Carrera? s/n")

    val esEstudianteBootcamp = readLine()?.trim()?.lowercase() == "s"
    println("Ingrese el número de módulos completados por el alumno:")
    
    val modulosCompletados = readLine()?.toIntOrNull() ?: 0
    
    // Condición Principal (Nivel 1)
    if (esEstudianteBootcamp) {
        println("\n📋 Estado: Evaluando perfil de estudiante de Bootcamp Técnico.")
        
        // Condición Anidada (Nivel 2)
        if (modulosCompletados > 5) {
            println("✅ ELEGIBLE: Puede iniciar el desarrollo de su Proyecto de Fin de Carrera.")
        } else {
            println("❌ REQUISITO INSUFICIENTE: Debe completar más de 5 módulos en el Bootcamp.")
        }
        
    } else {
        // Camino alterno de la Condición Principal
        println("\n📋 Estado: Evaluando perfil de estudiante de Cursos Libres/Regulares.")
        
        // Condición Anidada con Operador Lógico (Nivel 2)
        if (modulosCompletados < 2 || modulosCompletados > 10) {
            println("⚠️ REVISIÓN: El volumen de cursos completados está fuera de la métrica estándar para créditos.")
        } else {
            println("✅ HISTORIAL NORMAL: Progreso de cursos libres dentro del rango regular.")
        }
    }
}