fun main() {
    println("=== MÓDULO DE FUNCIONES Y LOGICA ACADÉMICA ===")
    
    // 1. Llamada a función básica sin retorno (Unit)
    saludar()
    
    // 2. Llamada a función con parámetros de entrada
    saludarConParametros("Alexander")
    
    val duracionCurso1 = 10
    val duracionCurso2 = 20
    
    // 3. Llamada a función estándar con tipo de retorno explícito
    println("Suma total de horas: $duracionCurso1 + $duracionCurso2 = ${sumar(duracionCurso1, duracionCurso2)} horas.")
    
    // 4. Llamada a función simplificada de expresión única
    println("Diferencia de tiempo: $duracionCurso2 - $duracionCurso1 = ${restar(duracionCurso2, duracionCurso1)} horas.")
    
    // 5. Llamada a función contenedora que ejecuta una función interna (Local)
    procesarEstadisticasInternas()
    
    // 6. Llamada a una expresión Lambda almacenada en una variable
    println("Proyección de carga horaria (Multiplicar clases * semanas): $duracionCurso1 * $duracionCurso2 = ${multiplicar(duracionCurso1, duracionCurso2)}")
}

// === A. FUNCIÓN BÁSICA (Retorna 'Unit' implícitamente, equivalente al void de Java) ===
fun saludar() {
    println("📢 Notificación del Servidor: ¡Sistema de Cursos Online Activo!")
}

// === B. FUNCIÓN CON PARÁMETROS (Tipados de forma obligatoria) ===
fun saludarConParametros(nombre: String) {
    println("👋 Bienvenido de vuelta a tu ruta de aprendizaje, $nombre.")
}

// === C. FUNCIÓN ESTÁNDAR CON RETORNO EXPLÍCITO (: Int) ===
fun sumar(numero1: Int, numero2: Int): Int {
    return numero1 + numero2
}

// === D. FUNCIÓN SIMPLIFICADA (Single-Expression Function) ===
// Kotlin infiere automáticamente el tipo de retorno omitiendo las llaves '{ }' y el 'return'.
fun restar(numero1: Int, numero2: Int) = numero1 - numero2

// === E. FUNCIÓN ANIDADA O LOCAL (Local Function) ===
// Útil para encapsular lógica helper que solo tiene sentido dentro de este proceso específico.
fun procesarEstadisticasInternas() {
    // Función interna simplificada
    fun calcularCuadradoAsignaciones(x: Int) = x * x
    
    println("\n--- Procesando Métricas Internas del Squad ---")
    println("Factor de escala de rendimiento para 5 retos técnicos: ${calcularCuadradoAsignaciones(5)}")
}

// === F. EXPRESIÓN LAMBDA COMO VARIABLE (Función de primera clase) ===
// En Kotlin las funciones son "ciudadanos de primera clase", lo que significa que pueden 
// guardarse en variables y pasarse como argumentos.
val multiplicar = { a: Int, b: Int -> a * b }