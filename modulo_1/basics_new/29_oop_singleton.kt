object Configuracion {
    val host:    String = "api.ejemplo.com"
    val puerto:  Int    = 443
    private val apiKey: String = "sk-secreto-123"   // privado — nunca expuesto

    fun baseUrl() = "https://$host:$puerto"
    fun headers() = mapOf("Authorization" to "Bearer $apiKey")
}

class Usuario1 private constructor(val id: Int, val nombre: String) {
    companion object {
        private var contadorId = 0

        // Factory function — encapsulamiento del constructor
        fun crear(nombre: String, email: String): Usuario1? {
            if (nombre.isBlank() || !email.contains("@")) return null
            return Usuario1(++contadorId, nombre.trim())
        }

        const val ROL_DEFECTO = "viewer"
    }
}

fun main() {
    println(Configuracion.baseUrl())  // https://api.ejemplo.com:443
    // Configuracion.apiKey            // ERROR — privado

    val u = Usuario1.crear("Ana", "ana@test.com")
    println(u)  // Usuario1(id=1, nombre=Ana García)
}