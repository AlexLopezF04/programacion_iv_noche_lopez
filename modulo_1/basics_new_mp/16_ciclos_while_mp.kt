fun main() {
    println("=== MÓDULO DE CICLOS INDETERMINADOS (WHILE & DO-WHILE) ===")
    
    // =========================================================================
    // 1. WHILE BÁSICO (Evalúa primero, ejecuta después)
    // Caso de uso: Descarga secuencial de videos de un módulo académico
    // =========================================================================
    println("\n--- ⏳ Ciclo While Estándar ---")
    var videoContador = 1
    while (videoContador <= 5) {
        println("Descargando video de lección N°: $videoContador/5")
        videoContador++
    }
    
    // =========================================================================
    // 2. DO-WHILE BÁSICO (Ejecuta al menos UNA VEZ, evalúa al final)
    // Caso de uso: Intentar sincronizar el progreso del alumno con la base de datos
    // =========================================================================
    println("\n--- 🔄 Ciclo Do-While ---")
    var intentoDeSincronizacion = 1
    do {
        println("Sincronizando progreso con el servidor... Intento N°: $intentoDeSincronizacion")
        intentoDeSincronizacion++
    } while (intentoDeSincronizacion <= 5)
    
    // =========================================================================
    // 3. ENTRADA DINÁMICA CON BREAK Y CONTINUE
    // Caso de uso: Procesamiento de IDs de lecciones con reglas restrictivas
    // =========================================================================
    println("\n--- ⏭️ Saltos de Flujo (Break & Continue) ---")
    var idLeccion = 1
    while (idLeccion <= 10) {
        idLeccion++
        
        // Conservamos tu lógica exacta: si es 3, salta la iteración
        if (idLeccion == 3) {
            println("⏩ [Omitido] Saltando lección ID 3 (Video temporalmente en mantenimiento).")
            continue
        }
        
        // Si llega a 7, rompe el ciclo completo de inmediato
        if (idLeccion == 7) {
            println("🛑 [Detenido] Límite de carga diaria alcanzado en ID 7. Deteniendo descargas.")
            break
        }
        
        println("Procesando metadatos de lección con ID: $idLeccion")
    }
    
    // =========================================================================
    // 4. BUCLE INFINITO CONTROLADO (while true)
    // Caso de uso: Consola interactiva del administrador para gestionar cupones
    // =========================================================================
    println("\n--- 🖥️ Consola Administrativa Interactiva ---")
    var comandoUsuario: String
    
    while (true) {
        println("Ingrese un comando para la plataforma (Escribe 'salir' para finalizar):")
        
        // Captura segura de la entrada del teclado
        comandoUsuario = readLine() ?: ""
        
        if (comandoUsuario.trim().lowercase() == "salir") {
            println("🚪 Cerrando sesión administrativa de forma segura. ¡Hasta luego!")
            break
        }
        
        println("⚙️ Ejecutando comando en el backend: '$comandoUsuario'...")
    }
}