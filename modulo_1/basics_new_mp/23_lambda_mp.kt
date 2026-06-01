fun main() {
    println("=== MÓDULO DE FACTURACIÓN: REGLAS LAMBDA EN CALIENTE ===")
    
    // =========================================================================
    // 1. LAMBDA CON TIPADO COMPLETO (Estructura Explícita)
    // Caso de uso: Sumar el costo de dos cursos independientes en el carrito.
    // =========================================================================
    println("--- 1. Cálculo de Consolidado Estándar ---")
    // Corrección del error de tipeo aplicado aquí en la variable combinada
    val calcularTotalCarrito: (Int, Int) -> Int = { costoCurso1: Int, costoCurso2: Int -> costoCurso1 + costoCurso2 }
    
    val totalFacturado = calcularTotalCarrito(45, 60)
    println("Total combinado de los dos cursos: \$${totalFacturado} USD")
    
    // =========================================================================
    // 2. LAMBDA CON INFERENCIA DE TIPOS (Sintaxis Idiomática)
    // Caso de uso: Aplicar un cargo de gestión fijo sobre la tarifa base.
    // =========================================================================
    println("\n--- 2. Cálculo con Inferencia de Tipos ---")
    val aplicarCargoServicio: (Int, Int) -> Int = { tarifaBase, cargoFijo -> tarifaBase + cargoFijo }
    
    val costoConSeguro = aplicarCargoServicio(100, 15)
    println("Costo final incluyendo cargos administrativos: \$${costoConSeguro} USD")

    // =========================================================================
    // 3. PARÁMETRO IMPLÍCITO 'it' (Un solo argumento)
    // Caso de uso: Duplicar los días de acceso al servidor de pruebas para un Squad.
    // =========================================================================
    println("\n--- 3. Extensión de Accesos (Parámetro implícito 'it') ---")
    val duplicarDiasAcceso: (Int) -> Int = { it * 2 }
    
    val diasTotalesConcedidos = duplicarDiasAcceso(30)
    println("Días totales otorgados en el entorno Sandbox: $diasTotalesConcedidos días.")
}