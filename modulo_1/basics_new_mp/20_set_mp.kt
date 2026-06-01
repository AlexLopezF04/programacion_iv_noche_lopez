fun main() {
    // =========================================================================
    // 1. SET INMUTABLE (setOf) - Colección de Elementos Únicos
    // Caso de uso: Almacenar los IDs de categorías vinculadas a un perfil
    // =========================================================================
    println("=== 📐 1. MANEJO DE CONJUNTOS INMUTABLES (SÓLO LECTURA) ===")
    
    // Al declarar duplicados (como el 1, 2, 3, 4), Kotlin los ignora automáticamente en el resultado final
    val idsCategoriasFidelizadas = setOf(1, 2, 3, 4, 6, 5, 3, 4, 2, 1, 1, 3)
    println("Conjunto real (Duplicados filtrados automáticamente): $idsCategoriasFidelizadas")
    
    // =========================================================================
    // 2. OPERACIONES ALGEBRAICAS DE CONJUNTOS (Funciones Infijas)
    // Caso de uso: Cruzar las tecnologías dominadas por dos miembros de un Squad
    // =========================================================================
    println("\n--- Operaciones de Conjuntos Académicos ---")
    val stackEstudianteA = setOf(2, 4, 6, 8)       // Ej: Códigos de cursos aprobados por Estudiante A
    val stackEstudianteB = setOf(1, 3, 5, 7, 9)    // Ej: Códigos de cursos aprobados por Estudiante B
    
    println("Stack Estudiante A: $stackEstudianteA")
    println("Stack Estudiante B: $stackEstudianteB")
    
    // Unión: Combina ambos conjuntos eliminando cualquier coincidencia repetida
    println("Unión (Todo el conocimiento del Squad): ${stackEstudianteB union stackEstudianteA}")
    
    // Intersección: Devuelve únicamente los elementos que ESTÁN EN AMBOS conjuntos
    println("Intersección (Cursos en común): ${stackEstudianteB intersect stackEstudianteA}")
    
    // Substracción (Diferencia): Remueve del primer conjunto todo lo que coincida con el segundo
    println("Substracción (Lo que sabe B que A aún no ha cursado): ${stackEstudianteB subtract stackEstudianteA}")
    
    // Verificación de inmutabilidad (Los conjuntos iniciales permanecieron intactos)
    println("Verificación - Stack A sigue igual: $stackEstudianteA")
    println("Verificación - Stack B sigue igual: $stackEstudianteB")
    
    
    // =========================================================================
    // 3. SET MUTABLE (mutableSetOf) - Escritura y Modificación en caliente
    // Caso de uso: Listar las tecnologías del core del proyecto de fin de carrera
    // =========================================================================
    println("\n=== 🛠️ 3. MANEJO DE CONJUNTOS MUTABLES (DINÁMICOS) ===")
    
    val lenguajesProyecto = mutableSetOf("kotlin", "java", "reactnative")
    println("Core inicial del proyecto: $lenguajesProyecto")
    
    // Intento de inserción de duplicado
    lenguajesProyecto.add("kotlin") 
    println("Intento de agregar 'kotlin' otra vez (Se ignora silenciosamente): $lenguajesProyecto")
    
    // Inserción de un nuevo elemento único
    lenguajesProyecto.add("javascript")
    println("Elemento nuevo agregado ('javascript'): $lenguajesProyecto")
    
    // Eliminación de un elemento
    lenguajesProyecto.remove("java")
    println("Elemento removido ('java'): $lenguajesProyecto")
    
    // Verificación de existencia rápida usando el operador 'in'
    println("\n--- Auditoría de Stack en el Proyecto ---")
    println("¿El proyecto incluye Kotlin de forma activa?: ${"kotlin" in lenguajesProyecto}")
    println("¿El proyecto sigue dependiendo de Java tradicional?: ${"java" in lenguajesProyecto}")
}