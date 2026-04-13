fun main() {
    println("Operadores Logicos")
    
    val esMayor = true
    val tienePermiso = false
    val estaActivo = true
    val mayorEdad = false

    println("Operador AND &&")
    println("$esMayor && $tienePermiso ${esMayor && tienePermiso}")
    println("$esMayor && $estaActivo ${esMayor && estaActivo}")
    
    println("OR Logico ||")
    println("$esMayor || $tienePermiso ${esMayor || tienePermiso}")
    println("$esMayor || $estaActivo ${esMayor || estaActivo}")
    println("$mayorEdad || $tienePermiso ${mayorEdad || tienePermiso}")
    println("$mayorEdad || $tienePermiso || $estaActivo ${mayorEdad || tienePermiso || estaActivo}")
    
    println("Not Logico !")
    println("! $esMayor ${!esMayor}")
    println("! $mayorEdad ${!mayorEdad} ")
    val texto = readLine()
    println(texto)
    
    
}