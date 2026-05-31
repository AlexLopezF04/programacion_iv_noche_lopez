fun main() {
    // =========================================================================
    // 1. MAPAS INMUTABLES (mapOf) - Estructuras de Solo Lectura
    // Caso de uso: Mapeo de códigos de error de la API de Cursos a mensajes en español
    // =========================================================================
    println("=== 🗺️ 1. MANEJO DE MAPAS INMUTABLES (SÓLO LECTURA) ===")
    
    val respuestasServidor = mapOf(
        "AUTH_001" to "Sesión del estudiante expirada. Inicie sesión nuevamente.",
        "DB_002" to "Error de persistencia: No se pudo conectar a PostgreSQL.",
        "GATEWAY_003" to "Tiempo de espera agotado al conectar con el microservicio.",
        "PAY_004" to "Transacción rechazada: Fondos insuficientes para la matrícula."
    )
    
    // Acceso por clave directa (Retorna un tipo anulable String? si la clave no existe)
    println("Error AUTH_001: ${respuestasServidor["AUTH_001"]}")
    println("Error INEXISTENTE: ${respuestasServidor["SQUAD_999"]}") // Imprime null de forma segura
    
    // Uso de getOrDefault para evitar nulos y proporcionar un valor de respaldo (Fallback)
    println("Mensaje seguro (Existente): ${respuestasServidor.getOrDefault("AUTH_001", "Error desconocido en la plataforma")}")
    println("Mensaje seguro (Inexistente): ${respuestasServidor.getOrDefault("SQUAD_999", "Error desconocido en la plataforma")}")
    
    // Inspección de las colecciones internas del mapa
    println("\n--- Vistas de la Estructura ---")
    println("Listado de Claves Únicas (Keys): ${respuestasServidor.keys}")
    println("Listado de Valores (Values): ${respuestasServidor.values}")
    println("Parejas de Entradas (Entries): ${respuestasServidor.entries}")
    println("Mapa completo crudo: $respuestasServidor")
    
    // Iteración eficiente desestructurando clave y valor
    println("\n--- Recorrido del Diccionario de Errores ---")
    for ((codigo, mensaje) in respuestasServidor) {
        println("Código Técnico: $codigo ➡️ Detalle: $mensaje")
    }
    
    // Corrección lúdica: En tu código original iterabas sobre 'capitales' de forma directa 
    // sin desestructurar. En Kotlin, eso devuelve objetos de tipo Map.Entry
    for (entrada in respuestasServidor) {
        println("Entrada cruda procesada en logs: $entrada")
    }
    
    // =========================================================================
    // 2. MAPAS MUTABLES (mutableMapOf) - Modificación dinámica en tiempo de ejecución
    // Caso de uso: Inventario y asignación de licencias de software en los laboratorios
    // =========================================================================
    println("\n=== 🛠️ 2. MANEJO DE MAPAS MUTABLES (INVENTARIO DINÁMICO) ===")
    
    val inventarioLicencias = mutableMapOf(
        "Licencias JetBrains" to 10,
        "Cuentas AWS Cloud" to 4,
        "Licencias Odoo Enterprise" to 12,
        "Contenedores Docker Dev" to 8
    )
    println("Inventario Inicial: $inventarioLicencias")
    
    // Inserción de un nuevo par Clave-Valor
    inventarioLicencias["Licencias GitKraken"] = 5
    println("Elemento nuevo agregado (GitKraken): $inventarioLicencias")
    
    // Actualización del valor de una clave existente
    inventarioLicencias["Licencias JetBrains"] = 20
    println("Stock de JetBrains actualizado a 20: $inventarioLicencias")
    
    // Remoción de un par clave-valor mediante su clave
    inventarioLicencias.remove("Contenedores Docker Dev")
    println("Contenedores Docker devueltos/removidos: $inventarioLicencias")
    
    // Función Avanzada 'getOrPut': Si la clave existe, devuelve su valor actual. 
    // Si NO existe, añade la clave con el valor del bloque lambda {} y lo retorna.
    println("\n--- Operaciones Atómicas con getOrPut ---")
    
    // Caso A: No existe "Suscripciones Azure", por lo tanto la crea con un stock de 15
    inventarioLicencias.getOrPut("Suscripciones Azure") { 15 }
    println("Después de buscar Azure (No existía, se creó con 15): $inventarioLicencias")
    
    // Caso B: "Licencias Odoo Enterprise" SÍ existe (vale 12). Se ignora el 15 de reemplazo.
    inventarioLicencias.getOrPut("Licencias Odoo Enterprise") { 15 }
    println("Después de buscar Odoo (Sí existía, conservó sus 12): $inventarioLicencias")
} 