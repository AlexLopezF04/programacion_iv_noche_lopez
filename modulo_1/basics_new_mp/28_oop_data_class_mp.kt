// Data Class: Modela la entidad pura que viaja entre PostgreSQL y el Frontend
data class CursoCatalogo(
    val id: Int,
    val nombre: String,
    val precio: Double,
    val categoria: String,
    val activo: Boolean = true // Parámetro con valor por defecto
)

fun main() {
    println("=== MÓDULO DE MODELADO DE DATOS (DATA CLASSES) ===\n")

    val curso1 = CursoCatalogo(1, "Kotlin Backend Starter", 89.99, "Programación")
    val curso2 = CursoCatalogo(2, "Kotlin Backend Avanzado", 89.99, "Programación")
    val curso3 = CursoCatalogo(3, "Despliegue de Módulos Odoo", 349.99, "Sistemas")

    // 1. toString() automático y legible generado por el compilador
    println("--- 📝 1. Representación String Automática ---")
    println(curso1)  // Imprime de forma humana: CursoCatalogo(id=1, nombre=Kotlin Backend Starter, ...)

    // 2. equals() estructural por valor (Compara contenido, no posiciones de memoria)
    println("\n--- ⚖️ 2. Comparación Estructural (equals / ==) ---")
    // Dará 'false' porque sus IDs y nombres difieren, a pesar de compartir el mismo precio y categoría
    println("¿Curso 1 es idéntico a Curso 2?: ${curso1 == curso2}")   // false
    println("¿Curso 1 es idéntico a Curso 3?: ${curso1 == curso3}")   // false

    // 3. El método .copy() — Inmutabilidad defensiva con modificaciones específicas
    println("\n--- 🖨️ 3. Clonación con Modificaciones (.copy) ---")
    // Creamos una variante de oferta modificando únicamente el precio del curso original
    val cursoEnOferta = curso1.copy(precio = 59.99)
    // Desactivamos un curso temporalmente manteniendo el resto de sus propiedades intactas
    val cursoMantenimiento = curso1.copy(activo = false)

    println("Curso Original:  $curso1")
    println("Curso en Oferta: $cursoEnOferta")
    println("Curso Oculto:    $cursoMantenimiento")

    // 4. Desestructuración posicional (Destructuring Declarations)
    // Extrae los componentes internos mapeándolos automáticamente a variables individuales
    println("\n--- 🔓 4. Desestructuración de Objetos ---")
    val (id, nombre, precio) = curso1
    println("Variable extraída -> ID: $id | Curso: $nombre — \$${precio} USD")

    // 5. Desestructuración directa en estructuras cíclicas (Bucle lambda forEach)
    println("\n--- 🔄 5. Desestructuración dentro de Bucles ---")
    val listaCursos = listOf(curso1, curso3)
    
    listaCursos.forEach { (idCurso, nombreCurso, precioCurso) ->
        println("🛍️ [Catálogo ID: $idCurso] $nombreCurso | Precio Final: \$${precioCurso}")
    }
}