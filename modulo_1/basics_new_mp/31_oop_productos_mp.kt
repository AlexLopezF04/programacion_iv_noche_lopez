// =========================================================================
// ENTIDADES DE DATOS (Modelos Inmutables)
// =========================================================================
data class AreaConocimiento(val id: Int, val nombre: String)

data class Curso(
    val id: Int,
    val nombre: String,
    val precioBase: Double,
    val cuposDisponibles: Int,
    val area: AreaConocimiento,
    val activo: Boolean = true
) {
    // ABSTRACCIÓN: El cliente consulta si puede matricularse sin conocer las reglas internas de inventario
    val matriculable: Boolean get() = activo && cuposDisponibles > 0
    
    // Propiedad calculada: Aplica la tasa impositiva estándar de Ecuador (IVA 15%)
    val precioConIva: Double get() = precioBase * 1.15

    // ENCAPSULAMIENTO POR INMUTABILIDAD: Devuelve una copia limpia con cambios puntuales
    fun aplicarBecaDescuento(porcentaje: Double): Curso {
        require(porcentaje in 0.0..100.0) { "El porcentaje de beca debe estar estrictamente entre 0 y 100" }
        return copy(precioBase = precioBase * (1 - porcentaje / 100))
    }
}

// =========================================================================
// SERVICIO DE CONTROL (Patrón Singleton con Estado Encapsulado)
// =========================================================================
object SistemaGestionAcademica {
    
    // ENCAPSULAMIENTO: Listas mutables estrictamente privadas para proteger la persistencia en memoria
    private val areasEstudio = mutableListOf(
        AreaConocimiento(1, "Desarrollo Backend"),
        AreaConocimiento(2, "Arquitectura de Software"),
        AreaConocimiento(3, "Bases de Datos y Persistencia")
    )
    
    private val cursosRegistrados = mutableListOf<Curso>()
    private var autoincrementId = 1

    // Factory Method: Valida la existencia de la relación antes de instanciar la entidad
    fun registrarCurso(nombre: String, precio: Double, cupos: Int, areaId: Int): Curso? {
        val areaAsociada = areasEstudio.find { it.id == areaId } ?: return null
        val nuevoCurso = Curso(autoincrementId++, nombre, precio, cupos, areaAsociada)
        cursosRegistrados.add(nuevoCurso)
        return nuevoCurso
    }

    // ABSTRACCIÓN: Interfaz pública limpia de solo lectura (.toList() rompe la referencia mutable externa)
    fun listarCatalogoCompleto(): List<Curso> = cursosRegistrados.toList()
    
    fun listarCursosMatriculables(): List<Curso> = cursosRegistrados.filter { it.matriculable }
    
    fun filtrarPorArea(areaId: Int): List<Curso> = cursosRegistrados.filter { it.area.id == areaId }
    
    fun buscarPorTexto(query: String): List<Curso> =
        cursosRegistrados.filter { it.nombre.contains(query, ignoreCase = true) }
}

// =========================================================================
// HILO PRINCIPAL DE EJECUCIÓN (main)
// =========================================================================
fun main() {
    println("=== 🚀 SISTEMA CORE DE GESTIÓN ACADÉMICA INTERNA ===\n")

    // Inyección de datos al Singleton
    SistemaGestionAcademica.registrarCurso("NestJS & Clean Architecture", 89.99, 20, 1)
    SistemaGestionAcademica.registrarCurso("Kotlin & Spring Boot Avanzado", 99.99, 15, 1)
    SistemaGestionAcademica.registrarCurso("Modelado de Datos con PostgreSQL", 49.99, 0, 3) // Sin cupos
    SistemaGestionAcademica.registrarCurso("Polyglot Persistence (Mongo + Postgres)", 120.00, 8, 3)
    SistemaGestionAcademica.registrarCurso("Diseño de Sistemas Distribuidos en Azure", 149.99, 5, 2)

    // Reporte A: Listar catálogo completo procesando propiedades calculadas
    println("--- 📋 Catálogo Académico Global (Precios con IVA Ecuador) ---")
    SistemaGestionAcademica.listarCatalogoCompleto().forEach { curso ->
        val indicadorEstado = if (curso.matriculable) "🟢 [DISPONIBLE]" else "🔴 [CUPOS AGOTADOS]"
        println("$indicadorEstado ${curso.nombre} | Precio: \$${"%.2f".format(curso.precioConIva)} USD (Área: ${curso.area.nombre})")
    }

    // Reporte B: Filtrado y Transformación funcional combinando .filter y .map
    println("\n--- 🎓 Promoción Especial Squads: Cursos Habilitados con 15% de Beca ---")
    SistemaGestionAcademica.listarCursosMatriculables()
        .map { cursoDisponible -> cursoDisponible.aplicarBecaDescuento(15.0) }
        .forEach { cursoConBeca -> 
            println(" ✨ Beca Aplicada ➡️ ${cursoConBeca.nombre} | Tarifa Preferencial: \$${"%.2f".format(cursoConBeca.precioBase)} USD") 
        }
}