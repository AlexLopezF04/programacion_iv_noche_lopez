fun main() {
    // === 1. COMPARACIONES NUMÉRICAS (Reglas Académicas y de Cupones) ===
    val calificacionEstudiante = 10.0
    val notaMinimaAprobatoria = 7.0
    
    // Igualdad (==) y Desigualdad (!=)
    println("¿La calificación es exactamente igual a la mínima?: calificacionEstudiante == notaMinimaAprobatoria -> ${calificacionEstudiante == notaMinimaAprobatoria}")
    println("¿La calificación es diferente a la nota mínima?: calificacionEstudiante != notaMinimaAprobatoria -> ${calificacionEstudiante != notaMinimaAprobatoria}")
    
    // Mayor que (>) y Menor que (<)
    println("¿El estudiante superó la nota mínima?: calificacionEstudiante > notaMinimaAprobatoria -> ${calificacionEstudiante > notaMinimaAprobatoria}")
    println("¿El estudiante obtuvo una nota menor a la mínima?: calificacionEstudiante < notaMinimaAprobatoria -> ${calificacionEstudiante < notaMinimaAprobatoria}")
    
    // Mayor o igual (>=) y Menor o igual (<=)
    println("¿El estudiante aprobó el módulo?: calificacionEstudiante >= notaMinimaAprobatoria -> ${calificacionEstudiante >= notaMinimaAprobatoria}")
    println("¿La calificación está en el rango inferior?: calificacionEstudiante <= notaMinimaAprobatoria -> ${calificacionEstudiante <= notaMinimaAprobatoria}")
    
    
    // === 2. COMPARACIÓN DE CADENAS E IGUALDAD EN KOTLIN (Estructural vs Referencial) ===
    // Simulamos el ingreso de un cupón de descuento por el usuario y el cupón guardado en el backend.
    val cuponIngresado = "KOTLIN15"
    val cuponValido = "KOTLIN15"
    
    println("\n--- Validación de Cadenas e Igualdad en Memoria ---")
    
    // Igualdad Referencial (===): Verifica si AMBAS variables apuntan exactamente al mismo objeto en la memoria (dirección física).
    // Nota: Da true aquí porque Kotlin optimiza los Strings idénticos apuntando al "String Pool".
    println("Igualdad Referencial (Mismo objeto en memoria): cuponIngresado === cuponValido -> ${cuponIngresado === cuponValido}")
    
    // Igualdad Estructural (==): Verifica si el CONTENIDO o valor de los objetos es el mismo, sin importar dónde estén guardados.
    // En Kotlin, usar '==' es el equivalente directo y elegante a usar '.equals()' en Java.
    println("Igualdad Estructural (Mismo contenido de texto): cuponIngresado == cuponValido -> ${cuponIngresado == cuponValido}")
    
    // Método .equals(): Hace exactamente lo mismo que '=='. En Kotlin se prefiere '==' por legibilidad.
    println("Uso explícito de .equals(): cuponIngresado.equals(cuponValido) -> ${cuponIngresado.equals(cuponValido)}")
}