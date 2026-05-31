// Constructor Primario: Captura los argumentos requeridos para el registro
class PerfilEstudiante(val nombreCompleto: String, val correoElectronico: String) {

    // Propiedades internas inmutables que se calcularán durante la inicialización
    val nombreProcesado: String
    val dominioInstitucional: String

    // === BLOQUE INIT: Garantía de Integridad y Encapsulamiento ===
    init {
        // Validaciones defensivas en caliente (Fail-Fast)
        require(nombreCompleto.isNotBlank()) { "Error de registro: El nombre del estudiante no puede estar vacío." }
        require(correoElectronico.contains("@")) { "Error de registro: El formato del correo electrónico '$correoElectronico' es inválido." }

        // Procesamiento y transformación segura de los datos validados
        nombreProcesado = nombreCompleto.trim().lowercase()
        dominioInstitucional = correoElectronico.substringAfter("@").trim().lowercase()
        
        println("⚙️ Sistema Core: Objeto 'PerfilEstudiante' inicializado y validado con éxito.")
    }
}

// =========================================================================
// HILO PRINCIPAL DE EJECUCIÓN (main)
// =========================================================================
fun main() {
    println("=== MÓDULO DE AUTENTICACIÓN Y GESTIÓN DE USUARIOS ===\n")

    // Instanciación exitosa pasándole datos crudos que necesitan limpieza
    val estudianteActivo = PerfilEstudiante("   Alexander Lopez   ", "alexander@ecuador.dev")
    
    println("\n--- Datos normalizados en el perfil ---")
    println("Nombre formateado para BD: '${estudianteActivo.nombreProcesado}'")  // alexander lopez
    println("Dominio corporativo/universitario: '${estudianteActivo.dominioInstitucional}'") // ecuador.dev

    println("\n--- Prueba de Robustez del Sistema ---")
    // Descomentar cualquiera de estas líneas disparará un IllegalArgumentException de forma segura,
    // impidiendo que el backend procese objetos con datos corruptos.
    // val estudianteInvalido1 = PerfilEstudiante("", "alex@correo.com")
    // val estudianteInvalido2 = PerfilEstudiante("Pachar", "correo_sin_arroba.com")
}