fun main() {
    println("Control de flujo")
    println("If Dos Caminos")
   
    println("Tiene Seguro Medico? s/n")
    val tieneSeguro = readLine()?.trim()?.lowercase() == "s"
    
    println("Costo base de la consulta? $")
    val costoBase = readLine()?.toDoubleOrNull()?: 0.0
    if(tieneSeguro){
      val cobertura = costoBase * 0.80
      println("Seguro cubre $cobertura Cliente cubre ${costoBase-cobertura}")
    }else{
      println("Cliente cubre $costoBase")
    }
}