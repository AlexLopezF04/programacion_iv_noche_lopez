fun main() {
    // === 1. OPERADORES ARITMÉTICOS (Cálculo financiero de la tienda) ===
    val subtotalCurso = 20
    val tasaImpuestoOpcional = 3
    
    println("--- Operaciones Financieras ---")
    
    // Suma: Subtotal más un recargo administrativo
    println("Suma (Total Neto): subtotalCurso + tasaImpuestoOpcional = ${subtotalCurso + tasaImpuestoOpcional} USD")
    
    // Resta: Aplicar una deducción o cupón de descuento directo
    println("Resta (Descuento): subtotalCurso - tasaImpuestoOpcional = ${subtotalCurso - tasaImpuestoOpcional} USD")
    
    // Multiplicación: Comprar múltiples licencias de un curso para un equipo de desarrollo
    println("Multiplicación (Compra Corporativa): subtotalCurso * tasaImpuestoOpcional = ${subtotalCurso * tasaImpuestoOpcional} USD")
    
    // División: Dividir el costo total de un bootcamp en cuotas mensuales fijas
    println("División (Financiamiento por cuotas): subtotalCurso / tasaImpuestoOpcional = ${subtotalCurso / tasaImpuestoOpcional} USD")
   
    // Módulo: Útil para algoritmos de paginación o para determinar si un examen tiene un número par de preguntas
    println("Módulo (Residuo lógico): subtotalCurso % tasaImpuestoOpcional = ${subtotalCurso % tasaImpuestoOpcional}")
    
    
    // === 2. OPERADORES DE ASIGNACIÓN COMPUESTA (Métricas de la cuenta del Alumno) ===
    println("\n--- Operadores de Asignación Compuesta (Historial de Puntos XP) ---")
    
    var puntosGamificacion = 10
    println("Puntos iniciales: $puntosGamificacion XP")

    puntosGamificacion += 5  // Equivalente a: puntosGamificacion = puntosGamificacion + 5
    println("puntosGamificacion += 5 | Resultado: $puntosGamificacion XP")
    
    puntosGamificacion -= 3  // Equivalente a: puntosGamificacion = puntosGamificacion - 3
    println("puntosGamificacion -= 3 | Resultado: $puntosGamificacion XP")
    
    puntosGamificacion *= 2  // Equivalente a: puntosGamificacion = puntosGamificacion * 2
    println("puntosGamificacion *= 2 | Resultado: $puntosGamificacion XP")
    
    puntosGamificacion /= 4  // Equivalente a: puntosGamificacion = puntosGamificacion / 4
    println("puntosGamificacion /= 4 | Resultado: $puntosGamificacion XP")
    
    puntosGamificacion %= 4  // Equivalente a: puntosGamificacion = puntosGamificacion % 4
    println("puntosGamificacion %= 4 | Resultado: $puntosGamificacion XP")
    
    
    // === 3. INCREMENTO Y DECREMENTO (Control del Reproductor de Video) ===
    println("\n--- Control de Progreso ---")
    var clasesCompletadas = 0
    
    // Incremento (++)
    clasesCompletadas++ // El alumno termina una clase de NestJS, el contador sube en 1
    println("clasesCompletadas++ | Clase finalizada. Total actual: $clasesCompletadas")
    
    // Decremento (--)
    clasesCompletadas-- // El instructor elimina una clase obsoleta del temario, el contador baja en 1
    println("clasesCompletadas-- | Ajuste de temario. Total actual: $clasesCompletadas")
}