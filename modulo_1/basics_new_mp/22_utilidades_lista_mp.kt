fun main() {
    println("Utilidades de Listas")
    val numeros = listOf(1,2,3,4,5,6,7,8,9,10)
    println(numeros)
    val cuadrados = numeros.map{it*it}
    println(cuadrados)
    val numerosTexto = numeros.map{"Num$it"}
    println(numerosTexto)
    
    println("Filter")
    val pares = numeros.filter{it % 2==0}
    println(pares)
    val mayores5 = numeros.filter{it > 5}
    println(mayores5)
    val paresYMayores5 = numeros.filter{it % 2==0 && it > 5}
    println(paresYMayores5)
    val impares = numeros.filterNot{it % 2==0}
    println(impares)   
}

