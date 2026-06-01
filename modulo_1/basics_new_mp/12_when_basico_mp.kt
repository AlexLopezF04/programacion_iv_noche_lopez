fun main() {
    println("=== MÓDULO DE CATÁLOGO (CONDICIONAL WHEN) ===")
    println("Seleccione el código del área tecnológica que desea explorar (1-7):")
    println("1 -> Desarrollo Backend")
    println("2 -> Desarrollo Frontend")
    println("3 -> Bases de Datos y Persistencia")
    println("4 -> Gestión de Proyectos e Ingeniería de Software")
    println("5 -> Seguridad Informática y Criptografía")
    println("6 -> Arquitectura de Software")
    println("7 -> Administración de Sistemas y Linux")
    println("")

    // Captura segura del código ingresado por el usuario
    val codigoArea = readLine()?.toIntOrNull() ?: 0
    
    // En Kotlin, 'when' funciona como una expresión que puede retornar un valor de forma directa
    val areaSeleccionada = when (codigoArea) {
        1 -> "Desarrollo Backend (NestJS, Spring Boot, Django)"
        2 -> "Desarrollo Frontend (React, Angular, Mobile con Dart/Kotlin)"
        3 -> "Bases de Datos y Persistencia (PostgreSQL, MongoDB, Polyglot)"
        4 -> "Gestión de Proyectos e Ingeniería de Software (Metodologías Ágiles)"
        5 -> "Seguridad Informática y Criptografía (Auditoría de Controles, GVM)"
        6 -> "Arquitectura de Software (Patrones de Diseño, Clean Architecture)"
        7 -> "Administración de Sistemas y Linux (Ubuntu Server, Azure VMs)"
        else -> "Categoría o Área no registrada en la plataforma"
    }

    println("\n🎯 Filtro académico aplicado:")
    println("Código procesado: $codigoArea")
    println("Área asignada: $areaSeleccionada")
}
