fun main() {
    println("If con condiciones anidadas")
    println("El paciente tiene antecedentes cardiacos? s/n")

    val tieneAntecedente = readLine()?.trim()?.lowercase()=="s"
    println("Frecuencia cardica lpm")
    
    val frecuencia = readLine()?.toIntOrNull()?:0
    if (tieneAntecedente){
        println("Paciente con antecedentes cardiacos")
        if (frecuencia > 100){
            println("Taquicardia")
        } else {
            println("Frecuencia dentro del rango")
        }
    } else {
        println("Paciente sin antecedentes cardiacos")
        if (frecuencia < 60 || frecuencia > 100){
            println("Frecuencia fuera de lo normal")
        } else {
            println("Frecucencia cardiaca normal")
        }
    }
}


