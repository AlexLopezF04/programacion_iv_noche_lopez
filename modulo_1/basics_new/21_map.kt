fun main() {
    println("Map")
    println("Inmutables")
    val capitales = mapOf(
        "España" to "Madrid",
        "Francia" to "Paris",
        "Alemania" to "Berlin",
        "Italia" to "Roma"
    )
    println(capitales["España"])
    println(capitales["Portugal"])
    println(capitales.getOrDefault("España", "Desconocido"))
    println(capitales.getOrDefault("Portugal", "Desconocido"))
    println(capitales.keys)
    println(capitales.values)
    println(capitales.entries)
    println(capitales)
    for((pais, capital) in capitales){
        println("pais: $pais - capital: $capital")
    }
    for(capital in capitales){
        println("capital: $capital")
    }
    
    println("Mutables")
    val inventario = mutableMapOf(
        "Laptops" to 10,
        "Impresoras" to 4,
        "Teclados" to 12,
        "Mouse" to 8
    )
    inventario["Monitores"] = 5
    println(inventario)
    inventario["Laptops"] = 20
    println(inventario)
    inventario.remove("Mouse")
    println(inventario)
    inventario.getOrPut("Proyector"){15}
    println(inventario)
    inventario.getOrPut("Teclados"){15}
    println(inventario)
}

