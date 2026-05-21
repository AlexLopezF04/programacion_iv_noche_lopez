fun main() {
    println("Condicional When")
primer-corte
    println("Código de especialidad? (1-7)")
    println("1 -> Medicina general")
    println("2 -> Pediatria")
    println("3 -> Cardiologia")
    println("4 -> Ginecologia")
    println("5 -> Traumatologia")
    println("6 -> Neurologia")
    println("7 -> Dermatologia")

    val codigo = readLine()?.toIntOrNull()?: 0
    val especialidad = when(codigo) {
        1 -> "Medicina general"
        2 -> "Pediatria"
        3 -> "Cardiologia"
        4 -> "Ginecologia"
        5 -> "Traumatologia"
        6 -> "Neurologia"
        7 -> "Dermatologia"
        else -> "Especialidad no registrada"
    }

    println("Especialidad: $especialidad")
=======
    println("Codigo de especialidad? (1-7)")
    println("")

    val codigo = readLine()?. toIntOrNull()?: 0
    val = especialidad = when(codigo){
        1 -> ""
    }


main
}