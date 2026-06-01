fun main() {
    println("=== MÓDULO DE FACTURACIÓN (CONTROL DE FLUJO) ===")
    println("Estructura: If Dos Caminos")
   
    // 1. Captura y estandarización de la respuesta del usuario
    println("¿El estudiante cuenta con Membresía Premium activa? s/n")
    // .trim() elimina espacios accidentales y .lowercase() convierte 'S' en 's'
    val esPremium = readLine()?.trim()?.lowercase() == "s"
    
    // 2. Captura del costo del taller o certificación
    println("Ingrese el costo base del taller/certificación: $")
    val costoBase = readLine()?.toDoubleOrNull() ?: 0.0
    
    // 3. Bifurcación del flujo de dos caminos (If - Else)
    if (esPremium) {
        // Camino A: Aplica descuento del 80% por ser miembro Premium
        val descuentoBeca = costoBase * 0.80
        val totalAPagar = costoBase - descuentoBeca
        
        println("🎟️ ¡Beneficio Premium Aplicado!")
        println("La membresía cubre: $descuentoBeca USD | El estudiante solo paga: $totalAPagar USD")
    } else {
        // Camino B: Estudiante regular, paga tarifa completa
        println("ℹ️ Estudiante Regular (Sin Membresía).")
        println("El estudiante cubre el valor total de: $costoBase USD")
    }
}