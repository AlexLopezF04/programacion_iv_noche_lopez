fun main() {
    println("=== CAPTURA DE DATOS DE PERFIL DE ESTUDIANTE ===")
    
    // 1. Entrada de texto simple
    println("Por favor, escriba su nombre completo:")
    val nombreEstudiante = readLine()
    println("👋 ¡Bienvenido a la plataforma, $nombreEstudiante!")
    
    // 2. Entrada numérica con conversión segura
    println("\n¿Cuántas horas semanales vas a dedicar a estudiar?: ")
    
    /* readLine()?.toDoubleOrNull() ?: 0.0
       - readLine(): Lee el texto ingresado.
       - ?.toDoubleOrNull(): Intenta convertir el String a un número decimal (Double). 
                             Si el usuario escribe letras en vez de números, devuelve 'null'.
       - ?: 0.0 (Operador Elvis): Si lo de la izquierda es null, asigna el valor de la derecha (0.0).
    */
    val horasDedicadas = readLine()?.toDoubleOrNull() ?: 0.0
    println("⏱️ Has configurado una meta de: $horasDedicadas horas semanales.")
    
    // 3. Operaciones matemáticas con el tipo de dato convertido
    // Calculamos una proyección de horas de estudio recomendadas al doble del ritmo actual
    val dobleHorasRecomendadas = horasDedicadas * 2
    
    println("🚀 Si duplicas tu ritmo, estudiarías: $dobleHorasRecomendadas horas.")
    println("📈 Proyección mensual estimada: ${horasDedicadas * 4} horas de capacitación.")
}