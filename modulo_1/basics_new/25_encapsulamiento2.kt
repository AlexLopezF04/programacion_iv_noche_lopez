class CuentaBancaria1(titular: String, saldoInicial: Double) {

    val titular: String = titular

    private var saldo: Double = saldoInicial

    internal val numeroCuenta: String =
        "ES${(100000..999999).random()}"

    private fun calcularInteres(): Double = saldo * 0.02

    private fun formatear(valor: Double): String =
        "$${"%.2f".format(valor)}"

    fun depositar(monto: Double) {
        require(monto > 0) { "El monto debe ser positivo" }
        saldo += monto
        println("Depositado: ${formatear(monto)} | Nuevo saldo: ${consultarSaldo()}")
    }

    fun retirar(monto: Double): Boolean {
        require(monto > 0) { "El monto debe ser positivo" }
        if (monto > saldo) {
            println("Fondos insuficientes")
            return false
        }
        saldo -= monto
        println("Retirado: ${formatear(monto)} | Nuevo saldo: ${consultarSaldo()}")
        return true
    }

    fun consultarSaldo(): String = formatear(saldo)
}

class Temperatura(celsius: Double) {

    var celsius: Double = celsius
        set(value) {
            require(value >= -273.15) { "Temperatura bajo el cero absoluto" }
            field = value
        }

    val fahrenheit: Double
        get() = celsius * 9.0 / 5.0 + 32.0

    val kelvin: Double
        get() = celsius + 273.15

    val descripcion: String
        get() = when {
            celsius < 0  -> "Bajo cero"
            celsius < 15 -> "Frío"
            celsius < 25 -> "Templado"
            celsius < 35 -> "Caluroso"
            else         -> "Muy caluroso"
        }
}

fun main() {
    // ---- Cuenta bancaria ----
    val cuenta = CuentaBancaria("Ana García", 1000.0)

    cuenta.depositar(500.0)
    cuenta.retirar(200.0)
    cuenta.retirar(2000.0)

    println("Titular: ${cuenta.titular}")
    println("Saldo final: ${cuenta.consultarSaldo()}")

    println("---------------")

    // ---- Temperatura ----
    val temp = Temperatura(20.0)
    println("${temp.celsius}°C = ${temp.fahrenheit}°F = ${temp.kelvin}K")
    println("Descripción: ${temp.descripcion}")

    temp.celsius = -5.0
    println("${temp.celsius}°C → ${temp.descripcion}")
}