fun main() {
  println("When con bloques de codigo")
  println("Nombre Paciente:")
  val paciente = readLine()?.trim()?:""
  println("Nivel de alergia CRITICO/URGENTE/MODERADO/LEVE:")
  val nivel = readLine()?.trim()?.uppercase()?:""
  
  when (nivel){
      "CRITICO"->{
        println("ALERTA CRITICA PACIENTE. $paciente")
        println("Accion Inmediata")
        println("Registrar hora de activacion de protocolo ")
      }
        "URGENTE"->{
            println("URGENTE PACIENTE. $paciente")
            println("PRIORIZA SALA DE ESPERA")
            println("Registrar hora de activacion ")
        }
        "MODERADO"->println(" MODERADO PACIENTE. $paciente, registrar monitorear")
        "LEVE"->println("LEVE PACIENTE. $paciente, registrar en la lista normal")
        else-> println("Protocolo no reconocido")
  }
  
  println("Edad:")
  val edad = readLine()?.toIntOrNull()?:0
  val tarifa = when(edad){
      in 0..2 -> "Tarifa infantil"
      in 3..11 -> "Tarifa juvenil"
      in 12..17 -> "Adulto"
      in 18..64 -> "Mayor"
      else -> "Adulto Mayor"
      
  }
  println("$edad años -> $tarifa")


}