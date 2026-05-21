fun main() {
    println("When con condiciones")
    println("Edad del paciente")
    val edad = readLine()?.toIntOrNull()?: 0

    println("¿Tiene seguro? (s/n)")
    val tieneSeguro = readLine()?.trim()?.lowercase() == "s"

    val nivelSeguro = if (tieneSeguro) {
        println("Nivel del paciente con seguro (BASICO, INTERMEDIO, AVANZADO)")
        readLine()?.trim()?.uppercase()?: ""
    } else {
        ""
    }

    val copago = when {
        !tieneSeguro && edad < 18 -> 0.0
        !tieneSeguro && edad <= 65 -> 15.0
        !tieneSeguro && edad > 65 -> 45.0
        nivelSeguro == "BASICO" -> 20.0
        nivelSeguro == "INTERMEDIO" -> 10.0
        nivelSeguro == "AVANZADO" -> 0.0
        else -> 30.0
    }

    println("Copago aplicado es: ${"%.2f".format(copago)}")
}