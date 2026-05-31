fun main() {
    println("=== MÓDULO DE PROGRAMACIÓN FUNCIONAL (EXPRESIONES LAMBDA) ===")
    
    // =========================================================================
    // 1. LAMBDA CON TIPADO COMPLETO (Estructura Explícita)
    // Caso de uso: Calcular la carga horaria total sumando dos módulos de un curso.
    // =========================================================================
    println("--- 1. Lambda con Tipado Completo ---")
    val calcularCargaHorariaTotal: (Int, Int) -> Int = { horasModuloA: Int, horasModuloB: Int -> horasModuloA + horasModuloB }
    
    val totalHorasCurso = calcularCargaHorariaTotal(12, 24)
    println("Total de horas calculadas: $totalHorasCurso hrs.")
    
    // =========================================================================
    // 2. LAMBDA CON INFERENCIA DE TIPOS (Sintaxis Limpia / Idiomática)
    // Como ya definimos '(Int, Int) -> Int' a la izquierda, Kotlin infiere 
    // automáticamente los tipos de los parámetros dentro de las llaves {}.
    // =========================================================================
    println("\n--- 2. Lambda con Inferencia de Tipos ---")
    val aplicarPuntosExtras: (Int, Int) -> Int = { puntosBase, bonificacion -> puntosBase + bonificacion }
    
    val scoreFinalEstudiante = aplicarPuntosExtras(85, 10)
    println("Puntuación final con beneficio: $scoreFinalEstudiante pts.")
    
    // =========================================================================
    // 3. PARAMETRO IMPLÍCITO 'it'
    // Cuando la función lambda recibe EXACTAMENTE UN SOLO parámetro, Kotlin nos 
    // permite omitir la flecha '->' y el nombre de la variable, reemplazándolo 
    // automáticamente por la palabra clave reservada 'it'.
    // Caso de uso: Duplicar el presupuesto de créditos en la nube para un Squad.
    // =========================================================================
    println("\n--- 3. Parámetro Implícito 'it' (Un solo argumento) ---")
    val duplicarCreditosNube: (Int) -> Int = { it * 2 }
    
    val creditosAsignados = duplicarCreditosNube(50)
    println("Créditos de infraestructura asignados al Squad: $creditosAsignados USD")
}