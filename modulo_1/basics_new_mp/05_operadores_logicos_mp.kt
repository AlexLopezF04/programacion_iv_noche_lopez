fun main() {
    println("=== SISTEMA DE REGLAS LOGICAS Y ACCESO ===")
    
    // Variables de estado del estudiante para las pruebas
    val completoLecturas = true
    val aproboExamenFinal = false
    val esUsuarioAdmin = true
    val tieneMembresiaExpirada = false

    // === 1. OPERADOR AND (&&) — Ambas condiciones DEBEN ser verdaderas ===
    println("\n--- Operador Lógico AND (&&) ---")
    // Caso A: Intento de emisión de certificado estándar
    println("¿Completó lecturas y aprobó examen?: $completoLecturas && $aproboExamenFinal -> ${completoLecturas && aproboExamenFinal}")
    
    // Caso B: Verificar si el usuario cumple las dos condiciones de un alumno destacado
    val esEstudianteDestacado = completoLecturas && !tieneMembresiaExpirada
    println("¿Es estudiante destacado (Lecturas completas Y membresía vigente)?: $completoLecturas && ${!tieneMembresiaExpirada} -> $esEstudianteDestacado")
    
    
    // === 2. OPERADOR OR (||) — Al menos UNA condición debe ser verdadera ===
    println("\n--- Operador Lógico OR (||) ---")
    // Caso A: Permitir visualización de contenido si es admin O si aprobó el examen
    println("¿Tiene acceso al panel de edición (Es Admin O aprobó examen)?: $esUsuarioAdmin || $aproboExamenFinal -> ${esUsuarioAdmin || aproboExamenFinal}")
    
    // Caso B: Evaluar múltiples condiciones encadenadas para bloquear una cuenta
    println("¿Se debe restringir el paso?: $tieneMembresiaExpirada || $aproboExamenFinal || $esUsuarioAdmin -> ${tieneMembresiaExpirada || aproboExamenFinal || esUsuarioAdmin}")
    
    
    // === 3. OPERADOR NOT (!) — Invierte el valor booleano actual ===
    println("\n--- Operador Lógico NOT (!) ---")
    println("Invertir estado de 'completoLecturas': ! $completoLecturas -> ${!completoLecturas}")
    println("Invertir estado de 'tieneMembresiaExpirada' (¿Membresía activa?): ! $tieneMembresiaExpirada -> ${!tieneMembresiaExpirada}")
    
    
    // === 4. CAPTURA DE DATOS DESDE LA CONSOLA (readLine) ===
    println("\n--- Interacción con el Usuario ---")
    print("Por favor, ingresa el código del cupón de descuento: ")
    
    // readLine() lee la línea de texto ingresada en la consola antes de presionar Enter.
    // Usamos el operador '?' porque readLine() puede retornar null si la consola se cierra.
    val cuponIngresado = readLine()
    
    println("🎟️ Procesando cupón recibido: $cuponIngresado")
}