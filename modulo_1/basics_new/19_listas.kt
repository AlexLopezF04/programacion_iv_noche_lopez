fun main (){
    println("Listas")
    println("")
    val frutas = listOf("Manzana", "Banana", "Cereza", "Pera", "Piña")
    println(frutas)
    println("Size: ${frutas.size}")
    println("Mostrar el elemento indice 0: ${frutas[0]}")
    println("Mostrar el primer elemento: ${frutas.first()}")
    println("Mostrar ultimo elemento: ${frutas.last()}")
    
    println("Mostrar el elemento indice 2: ${frutas.get(2)}")
    println("Mostrar contenido segun indice ${frutas.indexOf("Banana")}")
    println("Verificicar existencia de un elemento: ${frutas.contains("Piña")}")
    println("Verificar existencia de un elemento: ${"Naranja" in frutas}")
    
    
    //Sublista
    println("Sublista: ${frutas.subList(1,4)}")
    println("Tomar primero 2 elementos: ${frutas.take(2)}")
    println("Suprimir tres primeros elementos ${frutas.drop(3)}")
    println("Tomar ultimos dos elementos: ${frutas.takeLast(2)}")
    println(frutas)
    
    println("Mutables")
    val colores = mutableListOf("Blanco", "Azul", "Amarillo","Rojo")
    println(colores)
    colores.add("Verde")
    println(colores)
    colores.add(0, "Morado")
    println(colores)
    colores.remove("Verde")
    colores[1]= "Gris"
    println(colores)
    
    
    println("Array deque")
    val numeros = ArrayDeque<Int>()
    println(numeros)
    numeros.addFirst(1)
    println(numeros)
    numeros.addFirst(3)
    println(numeros)
    numeros.addLast(2)
    println(numeros)
    numeros.removeFirst()
    println(numeros)
    numeros.removeLast()
    println(numeros)
    
}