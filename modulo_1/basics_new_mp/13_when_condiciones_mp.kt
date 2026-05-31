fun main() {
    println("=== MÓDULO DE TARIFAS Y MATRICULACIÓN AVANZADA ===")
    
    println("Ingrese la edad del estudiante:")
    val edadEstudiante = readLine()?.toIntOrNull() ?: 0

    println("¿El estudiante cuenta con alguna Membresía activa? (s/n)")
    val tieneMembresia = readLine()?.trim()?.lowercase() == "s"

    // Bloque condicional para capturar el nivel de membresía si aplica
    val nivelMembresia = if (tieneMembresia) {
        println("Ingrese el nivel de su membresía (ESTÁNDAR, PREMIUM, PRO):")
        readLine()?.trim()?.uppercase() ?: ""
    } else {
        ""
    }

    // === WHEN SIN ARGUMENTOS: Evaluador de múltiples condiciones lógicas ===
    val costoInscripcionTaller = when {
        // Reglas para estudiantes sin membresía según su rango de edad
        !tieneMembresia && edadEstudiante < 18 -> 0.0      // Beca de Inclusión para menores de edad
        !tieneMembresia && edadEstudiante <= 65 -> 15.0    // Tarifa base reducida para estudiantes regulares
        !tieneMembresia && edadEstudiante > 65 -> 45.0     // Tarifa completa de talleres corporativos de por vida
        
        // Reglas basadas puramente en la categoría de suscripción activa
        nivelMembresia == "ESTÁNDAR" -> 20.0
        nivelMembresia == "PREMIUM" -> 10.0
        nivelMembresia == "PRO" -> 0.0                    // Acceso totalmente gratis e ilimitado para usuarios PRO
        
        // Caso por defecto en caso de datos inconsistentes
        else -> 30.0
    }

    // Impresión con formato de dos decimales para manejo financiero (moneda)
    println("\n💵 El valor final a pagar por la matrícula es: \$${"%.2f".format(costoInscripcionTaller)} USD")
}