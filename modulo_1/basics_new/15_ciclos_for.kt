fun main() {
    println("CICLOS for")
    for(i in 1..5){
        println(i)
    }
    println("UNTIL")
    for(i in 1 until 5){
        println(i)
    }
    
    println("DOWNTO")
    for(i in 10 downTo 1){
        println(i)
    }
    
    println("Listas")
    val nombres = listOf("Ana", "Luis", "Juana")
    for(nombre in nombres){
        println(nombre)
    }
    
    println("Indice valor")
    for((index, valor)in nombres.withIndex()){
        println("$index, $valor")
    }
    
    println("break")
    for (i in 1..5){
        if(i==3){
            break
        }
        println(i)
    }
    
    println("continue")
    for (i in 1..5){
        if(i==3){
            continue
        }
        println(i)
    }
   
    
    
    
}