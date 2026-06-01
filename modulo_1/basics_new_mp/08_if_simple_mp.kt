fun main() {
    println("=== MÓDULO DE CONTROL DE FLUJO ===") 
    println("Estructura: If Simple")
    
    println("Ingrese los días de inactividad del estudiante en la plataforma:")
    
    // Captura segura: si el usuario ingresa un dato inválido o vacío, se asume 0.0 días de inactividad
    val diasInactividad = readLine()?.toDoubleOrNull() ?: 0.0
    
    // Condición 1: Alerta preventiva de abandono
    if (diasInactividad >= 7.0) {
        println("⚠️ [Alerta Sistema] Estudiante en riesgo: Se detectó 1 semana o más sin ingresar a las clases.")
    }
    
    // Condición 2: Alerta crítica de deserción
    if (diasInactividad >= 15.0) {
        println("🚨 [Alerta Crítica] Riesgo de deserción alto: Notificar inmediatamente al tutor del squad.")
    }
    
    println("Métrica registrada: $diasInactividad días de inactividad.")
}
