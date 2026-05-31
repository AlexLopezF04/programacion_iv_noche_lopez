fun main() {
    println("=== MÓDULO DE CONVERSIÓN DE DATOS ACADÉMICOS ===") 
    
    // 1. Datos base: El backend registra la duración de una lección en minutos (Entero)
    val duracionMinutos: Int = 12
    
    // Conversión Explícita Obligatoria de Números
    val duracionHorasDecimal: Double = duracionMinutos.toDouble() / 60.0 // Convierte a Double para métricas exactas
    val idAuditoriaLong: Long = duracionMinutos.toLong()                 // Convierte a Long para llaves primarias
    val metadataTexto: String = duracionMinutos.toString()               // Convierte a String para concatenar en el cliente
    
    println("Conversión a Double (Horas): $duracionHorasDecimal")
    println("Conversión a Long (ID Sistema): $idAuditoriaLong")
    println("Conversión a String (Etiqueta): $metadataTexto")
    
    
    // 2. Conversión de Cadenas de Texto (Strings) a Tipos Numéricos
    // Caso de uso: Datos crudos recuperados de campos de entrada en un formulario web de administración
    println("\n--- Procesamiento de Formulario Web (String a Numérico) ---")
    
    val totalEstudiantesInscritos = "1234".toInt()
    val precioCursoEspecializado = "3.1415".toDouble() // Un precio o factor de descuento estructurado
    
    println("Total Alumnos (Int parseado): $totalEstudiantesInscritos")
    println("Precio Curso (Double parseado): $precioCursoEspecializado USD")
    
    
    // 3. Conversión segura contra errores de tipeo (Manejo de Excepciones Implícito)
    // Si un administrador ingresa texto inválido en el campo de precio por error
    val idCursoInvalido = "abcd".toIntOrNull()
    
    println("\nIntento de conversión con texto corrupto ('abcd'):")
    println("Resultado obtenido: $idCursoInvalido") // Imprime 'null' de forma segura en vez de romper la app
    
    if (idCursoInvalido == null) {
        println("⚠️ [Alerta] El formato de ID ingresado no es un número válido. Operación cancelada.")
    }
}