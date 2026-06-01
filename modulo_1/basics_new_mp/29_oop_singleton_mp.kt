// =========================================================================
// 1. DECLARACIÓN 'object' (Patrón Singleton Nativo)
// Caso de uso: Configuración global y credenciales seguras de la API Core
// =========================================================================
object EntornoConfiguracion {
    val host: String = "api.cursos-online.dev"
    val puerto: Int = 443
    
    // Al ser privado, este Token queda blindado dentro de este objeto, protegiendo credenciales de producción
    private val apiSecretKey: String = "sk-live-ecuador-2026-secure-token"

    fun obtenerBaseUrl() = "https://$host:$puerto"
    
    fun generarHeadersAutenticacion() = mapOf(
        "Authorization" to "Bearer $apiSecretKey",
        "Accept" to "application/json"
    )
}

// =========================================================================
// 2. CLASE CON CONSTRUCTOR PRIVADO Y 'companion object'
// Caso de uso: Control estricto de instanciación con Factory Pattern
// =========================================================================
class RegistroEstudiante private constructor(val id: Int, val nombre: String) {

    // El companion object agrupa los miembros que pertenecen a la clase y no a las instancias
    companion object {
        // Variable estática privada para llevar el conteo secuencial y autoincremental de IDs
        private var contadorId = 0

        // Constantes en tiempo de compilación (Equivalente al public static final de Java)
        const val ROL_ESTUDIANTE_DEFECTO = "STUDENT_VIEWER"

        // FACTORY FUNCTION — Encapsula y controla la construcción del objeto
        fun crear(nombreCrudo: String, email: String): RegistroEstudiante? {
            // Regla de validación de negocio: Si los datos no cumplen los criterios mínimos, rechazamos la creación
            if (nombreCrudo.isBlank() || !email.contains("@")) {
                println("⚠️ [Alerta Factory]: Datos inválidos. Cancelando instanciación de usuario.")
                return null
            }
            
            // Incrementamos el contador global e instanciamos de forma segura la clase privada
            return RegistroEstudiante(++contadorId, nombreCrudo.trim())
        }
    }

    // Estructuramos un método para visualizar el contenido del objeto de forma limpia en consola
    fun obtenerFichaResumen() = "Perfil ID: #$id | Estudiante: $nombre | Rol Asignado: $ROL_ESTUDIANTE_DEFECTO"
}

// =========================================================================
// HILO PRINCIPAL DE EJECUCIÓN (main)
// =========================================================================
fun main() {
    println("=== MÓDULO DE SERVICIOS GLOBALES Y FACTORÍAS (SINGLETON) ===\n")

    // --- Prueba de Objeto Singleton ---
    println("--- 🛰️ 1. Configuración de Red del Servidor ---")
    // Acceso directo sin necesidad de instanciar con la palabra clave 'new'
    println("Endpoint Central: ${EntornoConfiguracion.obtenerBaseUrl()}")
    println("Carga de Cabeceras: ${EntornoConfiguracion.generarHeadersAutenticacion()}")
    
    // EntornoConfiguracion.apiSecretKey // ERROR DE COMPILACIÓN — Protegido por el encapsulamiento privado

    // --- Prueba de Companion Object (Factory Pattern) ---
    println("\n--- 🏭 2. Creación de Perfiles Mediante Factory Method ---")
    
    // Intento A: Datos correctos
    val estudiante1 = RegistroEstudiante.crear("   Alexander Lopez   ", "alexander@kotlin.dev")
    
    // Usamos el operador de llamada segura ?. ya que el Factory puede retornar un objeto nulo (RegistroEstudiante?)
    println("Resultado Instancia 1: ${estudiante1?.obtenerFichaResumen()}")

    // Intento B: Datos inválidos para forzar el control del Factory
    val estudiante2 = RegistroEstudiante.crear("", "correo_invalido.com")
    println("Resultado Instancia 2: $estudiante2") // Imprime null de forma segura, evitando que colapse el backend
    
    // Acceso directo a constantes globales de la clase sin instanciar
    println("Rol por defecto del sistema académico: ${RegistroEstudiante.ROL_ESTUDIANTE_DEFECTO}")
}