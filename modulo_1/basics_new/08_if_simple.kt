fun main() {
    println("Control de flujo") 
    println("If Simple")
    println("Temperatura corporal del paciente en grados centing.")
    val temperatura = readLine()?.toDoubleOrNull()?:35.5
    if(temperatura >= 38){
        println("Fiebre detectada")
    }
    if(temperatura >= 40){
        println("Fiebre alta")
    }
    println("Temperatura registrada: $temperatura")
}