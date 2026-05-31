fun main() {
    // 1. Val (Inmutable): No se puede reasignar una vez inicializado. Aporta seguridad al código.
    val estudianteNombre = "Alexander Lopez"
    val estudianteEdad: Int = 26

    // 2. Var (Mutable): Puede cambiar su valor a lo largo del ciclo de vida del software.
    // Ideal para contadores de progreso o visualizaciones.
    var totalClasesVistas = 0
    totalClasesVistas = totalClasesVistas + 1
    
    println("🎓 El estudiante $estudianteNombre tiene $estudianteEdad años y ha visto $totalClasesVistas clase(s).")
    
    // === 3. TIPOS DE DATOS NUMÉRICOS ENTEROS ===
    // Kotlin permite usar guiones bajos (_) para mejorar la lectura de números grandes.
    val limiteInscripcionesPorDia: Byte = 127
    val totalCursosEnCatalogo: Short = 32_767
    val idCursoPostgres: Int = 12
    val visitasGlobalesServidor: Long = 2_222_222_333_222_333L // Se añade 'L' para indicar tipo Long
    
    println("Límite diario: $limiteInscripcionesPorDia")
    println("Catálogo disponible: $totalCursosEnCatalogo")
    println("ID del curso actual: $idCursoPostgres")
    println("Métrica de tráfico: $visitasGlobalesServidor")
    
    // === 4. NÚMEROS DECIMALES ===
    // Por defecto, un decimal es Double. Si queremos Float, debemos forzar la 'f' al final.
    val calificacionMinimaAprobacion: Float = 7.0f
    val precioMembresiaAnual: Double = 149.99359265
    
    val tieneAccesoPremium: Boolean = true
    
    // === 5. CARACTERES Y CADENAS ===
    val letraIdentificadorMódulo: Char = 'A' // Comillas simples para caracteres únicos
    val plataformaNombre: String = "Kotlin Academy" // Comillas dobles para cadenas de texto
    
    // Inferencia de tipos: Kotlin deduce automáticamente que es un String sin escribirlo explícitamente
    val lenguajeDestacadoInferido = "Kotlin para Backend"
    println("El tipo de dato inferido de la variable es: ${lenguajeDestacadoInferido::class.simpleName}")
    
    // === 6. UTILIDADES DE STRING Y EXPRESIONES ===
    val cursoNombre = "nestjs profesional"
    val categoriaNombre = "desarrollo de software"
    
    // Transformación usando métodos integrados (.uppercase())
    val cursoMayuscula = cursoNombre.uppercase()
    val categoriaMayuscula = categoriaNombre.uppercase()
    
    // Imprimiendo variables previamente transformadas
    println("📚 Curso: $cursoMayuscula | Categoría: $categoriaMayuscula")
    
    // Imprimiendo expresiones directamente evaluadas dentro del String Template usando ${ }
    println("🚀 Lanzamiento: ${cursoNombre.uppercase()} en el área de ${categoriaNombre.uppercase()}")
    
    /*
      ===============================================
      Comentario de varias líneas:
      Este bloque simula la base de la declaración de variables
      y tipos primitivos esenciales para el manejo de metadata
      en la base de datos de los Cursos Online.
      ===============================================
     */
    
    // Comentario de una sola línea: Fin del archivo 2 de fundamentos.
}