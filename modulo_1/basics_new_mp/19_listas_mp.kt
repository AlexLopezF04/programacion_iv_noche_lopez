fun main() {
    // =========================================================================
    // 1. LISTAS INMUTABLES (listOf) - Solo Lectura
    // Caso de uso: Listar las tecnologías fijas de la ruta de Backend
    // =========================================================================
    println("=== 📚 1. MANEJO DE LISTAS INMUTABLES (SÓLO LECTURA) ===")
    
    val tecnologiasBackend = listOf("Kotlin", "Spring Boot", "PostgreSQL", "NestJS", "MongoDB")
    println("Lista completa: $tecnologiasBackend")
    println("Cantidad de tecnologías: ${tecnologiasBackend.size}")
    
    // Métodos de acceso posicional
    println("Elemento en el índice 0: ${tecnologiasBackend[0]}")
    println("Primer lenguaje de la ruta: ${tecnologiasBackend.first()}")
    println("Última tecnología de la ruta: ${tecnologiasBackend.last()}")
    println("Elemento en el índice 2 (usando .get): ${tecnologiasBackend.get(2)}")
    
    // Búsqueda y verificación de elementos
    println("Índice donde se encuentra 'Spring Boot': ${tecnologiasBackend.indexOf("Spring Boot")}")
    println("¿La ruta contiene 'MongoDB'?: ${tecnologiasBackend.contains("MongoDB")}")
    println("¿'Docker' forma parte de esta lista actual?: ${"Docker" in tecnologiasBackend}")
    
    // Operaciones de segmentación (Crean nuevas sublistas sin alterar la original)
    println("\n--- Operaciones de Segmentación de Datos ---")
    println("Sublista (Índices del 1 al 3 inclusive): ${tecnologiasBackend.subList(1, 4)}")
    println("Tomar las primeras 2 tecnologías: ${tecnologiasBackend.take(2)}")
    println("Suprimir u omitir las 3 primeras: ${tecnologiasBackend.drop(3)}")
    println("Tomar las últimas 2 tecnologías: ${tecnologiasBackend.takeLast(2)}")
    println("Verificación de integridad (Lista original intacta): $tecnologiasBackend")
    
    
    // =========================================================================
    // 2. LISTAS MUTABLES (mutableListOf) - Lectura y Escritura en caliente
    // Caso de uso: Gestión dinámica de los estudiantes asignados a un Squad
    // =========================================================================
    println("\n=== 👥 2. MANEJO DE LISTAS MUTABLES (DINÁMICAS) ===")
    
    val squadEstudiantes = mutableListOf("Alexander", "BaconJ", "Pachar", "Michael")
    println("Squad inicial: $squadEstudiantes")
    
    // Inserciones y modificaciones
    squadEstudiantes.add("Ana") // Agrega al final por defecto
    println("Estudiante agregado al final: $squadEstudiantes")
    
    squadEstudiantes.add(0, "Luis") // Inserta en una posición específica desplazando el resto
    println("Estudiante insertado en el índice 0: $squadEstudiantes")
    
    // Remociones y actualizaciones
    squadEstudiantes.remove("Ana") // Elimina por coincidencia de objeto/valor
    squadEstudiantes[1] = "Carlos"  // Reemplaza el elemento del índice 1 ('Alexander') por 'Carlos'
    println("Squad final modificado: $squadEstudiantes")
    
    
    // =========================================================================
    // 3. COLA DE DOBLE EXTREMO (ArrayDeque) - Inserciones/Remociones eficientes en extremos
    // Caso de uso: Cola de tickets de soporte técnico o mentorías prioritarias
    // =========================================================================
    println("\n=== ⏳ 3. ESTRUCTURA ARRAYDEQUE (COLA DE DOBLE EXTREMO) ===")
    
    val colaTicketsSoporte = ArrayDeque<Int>()
    println("Estado inicial de la cola: $colaTicketsSoporte")
    
    // Agregar elementos por ambos extremos
    colaTicketsSoporte.addFirst(101) // Ticket prioritario entra al inicio
    println("Ticket insertado al inicio: $colaTicketsSoporte")
    
    colaTicketsSoporte.addFirst(102) // Otro ticket de alta prioridad toma la cabecera
    println("Ticket nuevo insertado al inicio: $colaTicketsSoporte")
    
    colaTicketsSoporte.addLast(201)  // Ticket regular entra por el final de la fila
    println("Ticket regular insertado al final: $colaTicketsSoporte")
    
    // Remover o despachar elementos desde ambos extremos
    colaTicketsSoporte.removeFirst() // Se atiende y remueve al primero de la fila (102)
    println("Primer ticket despachado: $colaTicketsSoporte")
    
    colaTicketsSoporte.removeLast()  // Se cancela o remueve el último ticket de la fila (201)
    println("Último ticket removido: $colaTicketsSoporte")
}