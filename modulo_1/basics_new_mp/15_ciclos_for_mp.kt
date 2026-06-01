fun main() {
    // =========================================================================
    // 1. RANGO CERRADO (..) — Incluye tanto el valor inicial como el final
    // Caso de uso: Imprimir el temario ordenado de las primeras 5 lecciones de un curso
    // =========================================================================
    println("--- 📚 CICLOS FOR (Rango 1 al 5 inclusive) ---")
    for (claseNumero in 1..5) {
        println("Reproduciendo Clase N°: $claseNumero")
    }
    
    // =========================================================================
    // 2. RANGO ABIERTO (until) — Incluye el inicio pero EXCLUYE el límite superior
    // Caso de uso: Iterar sobre índices de arreglos nativos o sub-módulos del sistema
    // =========================================================================
    println("\n--- 📖 RANGOS CON UNTIL (1 al 5 exclusivo, llega al 4) ---")
    for (moduloId in 1 until 5) {
        println("Procesando Módulo de Código ID: $moduloId")
    }
    
    // =========================================================================
    // 3. RANGO DECRECIENTE (downTo) — Cuenta de manera regresiva
    // Caso de uso: Contador en reversa para el cierre automático de un examen cronometrado
    // =========================================================================
    println("\n--- ⏳ REGRESIVA CON DOWNTO (10 al 1) ---")
    for (segundoRestante in 10 downTo 1) {
        println("El examen se cerrará en: $segundoRestante segundos...")
    }
    
    // =========================================================================
    // 4. RECORRIDO DE LISTAS INMUTABLES (listOf)
    // Caso de uso: Desplegar el listado de los instructores asignados al módulo actual
    // =========================================================================
    println("\n--- 👥 Recorrido de Colecciones (Listas) ---")
    val instructoresSquad = listOf("Ana (Backend)", "Luis (Frontend)", "Juana (Databases)")
    for (instructor in instructoresSquad) {
        println("Profesor activo: $instructor")
    }
    
    // =========================================================================
    // 5. DESEMPAQUETADO DE ÍNDICE Y VALOR (withIndex)
    // Caso de uso: Renderizar un ranking de estudiantes (Leaderboard) con su posición
    // =========================================================================
    println("\n--- 🏆 Tabla de Posiciones (Índice, Valor con withIndex) ---")
    for ((index, estudiante) in instructoresSquad.withIndex()) {
        // Le sumamos 1 al índice de base cero para que sea legible al usuario final (Puesto 1, Puesto 2...)
        println("Puesto #${index + 1}: $estudiante")
    }
    
    // =========================================================================
    // 6. CONTROL CON BREAK — Interrumpe y sale del bucle de forma inmediata
    // Caso de uso: Detener la carga de comentarios si se detecta spam o un error
    // =========================================================================
    println("\n--- 🛑 Control de Ciclo: BREAK ---")
    for (intentoConexion in 1..5) {
        if (intentoConexion == 3) {
            println("⚠️ Error crítico de base de datos en intento N° 3. Rompiendo ciclo.")
            break
        }
        println("Conexión exitosa al servidor. Intento N°: $intentoConexion")
    }
    
    // =========================================================================
    // 7. CONTROL CON CONTINUE — Salta la iteración actual y pasa a la siguiente
    // Caso de uso: Omitir la impresión de un alumno si su cuenta está suspendida
    // =========================================================================
    println("\n--- ⏭️ Control de Ciclo: CONTINUE ---")
    for (evaluacionId in 1..5) {
        if (evaluacionId == 3) {
            println("⏩ Saltando evaluación ID 3 (En fase de revisión/mantenimiento).")
            continue
        }
        println("Evaluación ID $evaluacionId disponible para el estudiante.")
    }  
}