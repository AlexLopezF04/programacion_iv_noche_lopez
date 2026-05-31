fun main() {
    println("=== MÓDULO DE GAMIFICACIÓN (CONTROL DE FLUJO MULTIPLE) ===")
    println("Estructura: If / Else If como Expresión de Retorno")
    
    println("Ingrese los puntos de experiencia (XP) obtenidos por el estudiante:")
    val puntosXP = readLine()?.toIntOrNull() ?: 0
    
    // En Kotlin, el 'if-else' actúa como expresión. El último valor de cada bloque es lo que se retorna.
    val rangoEstudiante = if (puntosXP < 100) {
        "Novato (Nivel Bronce 🥉)"
    } else if (puntosXP <= 499) {
        "Aprendiz (Nivel Plata 🥈)"
    } else if (puntosXP <= 999) {
        "Desarrollador Junior (Nivel Oro 🥇)"
    } else if (puntosXP <= 1999) {
        "Líder de Squad (Nivel Platino 💎)"
    } else {
        "Arquitecto de Software Legendario (Nivel Diamante 👑)"
    }
    
    println("\n🎯 Resultado del Análisis:")
    println("Puntos acumulados: $puntosXP XP")
    println("Clasificación de Perfil: $rangoEstudiante")
}
