fun main() {
    println("=== MÓDULO DE PROCESAMIENTO FUNCIONAL DE COLECCIONES ===")
    
    // Lista base de datos simulada: IDs de lecciones completadas por un alumno
    val leccionesIds = listOf(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
    println("Colección de IDs base: $leccionesIds")
    
    // =========================================================================
    // 1. TRANSFORMACIÓN CON .map
    // =========================================================================
    println("\n--- Operaciones de Transformación (.map) ---")
    
    // Caso A: Proyección matemática (ej: calcular un factor de escala de peso académico)
    val pesosCuadraticos = leccionesIds.map { it * it }
    println("Pesos transformados (Cuadrados): $pesosCuadraticos")
    
    // Caso B: Mapeo de tipos (Transformar una lista de Int a una lista de String)
    // Caso de uso: Formatear códigos de barras o slugs de URL para el frontend
    val slugsLecciones = leccionesIds.map { "LECCION-ID-$it" }
    println("Slugs formateados para URLs: $slugsLecciones")
    
    // =========================================================================
    // 2. SEGMENTACIÓN CON .filter & .filterNot
    // =========================================================================
    println("\n--- Operaciones de Filtrado Criterial (.filter) ---")
    
    // Caso A: Filtrar números pares (ej: identificar lecciones que corresponden a Talleres Prácticos)
    val leccionesTalleres = leccionesIds.filter { it % 2 == 0 }
    println("Filtrado (Solo Talleres Prácticos - Pares): $leccionesTalleres")
    
    // Caso B: Filtrar mayores a un umbral (ej: segmentar lecciones avanzadas del bloque final)
    val leccionesAvanzadas = leccionesIds.filter { it > 5 }
    println("Filtrado (Solo Contenido Avanzado > 5): $leccionesAvanzadas")
    
    // Caso C: Combinación lógica de condiciones (Operador AND &&)
    // Caso de uso: Filtrar talleres prácticos que además pertenecen exclusivamente al bloque avanzado
    val talleresAvanzados = leccionesIds.filter { it % 2 == 0 && it > 5 }
    println("Filtrado Compuesto (Talleres Prácticos AND Avanzados): $talleresAvanzados")
    
    // Caso D: Inversión del filtro con .filterNot
    // Conserva únicamente los elementos donde la condición da FALSE (lo opuesto a .filter)
    // Caso de uso: Aislar las lecciones teóricas (números impares)
    val leccionesTeoricas = leccionesIds.filterNot { it % 2 == 0 }
    println("Filtrado Inverso (Solo Lecciones Teóricas - Impares): $leccionesTeoricas")
} 