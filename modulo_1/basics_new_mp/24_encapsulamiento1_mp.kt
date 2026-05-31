// Usamos 'open' para permitir que otras clases hereden de CuentaEstudiante
open class CuentaEstudiante(titular: String, creditosIniciales: Double) {

    // Visibilidad Pública por defecto (Acceso total)
    val titular: String = titular

    // private: Visible ÚNICAMENTE dentro de esta clase. Nadie de fuera puede alterarlo directamente.
    private var creditos: Double = creditosIniciales

    // internal: Visible dentro del mismo módulo (mismo proyecto/package de compilación)
    // Caso de uso: Generar un ID de matrícula único para Ecuador o la región
    internal val matriculaId: String =
        "ST-${(100000..999999).random()}"

    // protected: Visible en esta clase y en cualquier subclase que herede de ella
    // open: Permite que las subclases modifiquen el comportamiento de esta función
    protected open fun calcularBonificacionReto(): Double = creditos * 0.02

    // Función pública para añadir créditos de forma controlada
    fun recargarCreditos(monto: Double) {
        // require: Validación defensiva. Si no se cumple, lanza un IllegalArgumentException
        require(monto > 0) { "El monto de créditos a recargar debe ser positivo." }
        creditos += monto
        println("📥 Créditos Recargados: +${"%.2f".format(monto)} pts | Balance Actual: ${consultarBalance()}")
    }

    // Función pública para consumir créditos al ingresar a laboratorios de desarrollo (ej: Azure/Odoo Sandbox)
    fun consumirCreditos(monto: Double): Boolean {
        require(monto > 0) { "El monto de créditos a consumir debe ser positivo." }
        if (monto > creditos) {
            println("❌ Operación Rechazada: Créditos insuficientes para iniciar el laboratorio.")
            return false
        }
        creditos -= monto
        println("💻 Laboratorio Iniciado: -${"%.2f".format(monto)} pts | Balance Actual: ${consultarBalance()}")
        return true
    }

    // Expresión de expresión única para consultar la variable privada formateada
    fun consultarBalance(): String = "${"%.2f".format(creditos)} XP"
}

// =========================================================================
// SUBCLASE: Aplica Herencia (:) y aprovecha 'protected' + 'override'
// =========================================================================
class CuentaEstudiantePremium(titular: String, creditosIniciales: Double)
    : CuentaEstudiante(titular, creditosIniciales) {

    // override: Sobreescribe la lógica de la clase padre
    override fun calcularBonificacionReto(): Double {
        // super: Llama al método de la clase padre y le aplica un multiplicador de beneficio Premium (1.5x)
        return super.calcularBonificacionReto() * 1.5
    }

    // Ejecuta la bonificación inyectándola a través del método público heredado
    fun aplicarBonoPorCompletarProyecto() {
        val bonoPremium = calcularBonificacionReto()
        println("🏆 ¡Proyecto Final Aprobado con Éxito!")
        recargarCreditos(bonoPremium)
    }
}

// =========================================================================
// HILO PRINCIPAL DE EJECUCIÓN (main)
// =========================================================================
fun main() {
    println("=== MÓDULO DE CONTROL ACADÉMICO (POO & ENCAPSULAMIENTO) ===\n")

    // Instancia de la clase base
    val estudianteRegular = CuentaEstudiante("Ana García", 1000.0)

    estudianteRegular.recargarCreditos(500.0)
    estudianteRegular.consumirCreditos(200.0)
    estudianteRegular.consumirCreditos(2000.0) // Intento de sobregiro de créditos

    println("\nDatos del Perfil Regular:")
    println("Estudiante: ${estudianteRegular.titular}")
    println("Matrícula ID (Internal): ${estudianteRegular.matriculaId}")
    println("Balance de Créditos: ${estudianteRegular.consultarBalance()}")

    println("\n---- 💎 Transición a Cuenta Estudiante Premium ----\n")

    // Instancia de la subclase
    val estudiantePremium = CuentaEstudiantePremium("Juan Pérez", 2000.0)
    
    // Aplica la lógica modificada por el polimorfismo
    estudiantePremium.aplicarBonoPorCompletarProyecto()
    
    println("\nDatos del Perfil Premium:")
    println("Estudiante: ${estudiantePremium.titular}")
    println("Matrícula ID (Internal): ${estudiantePremium.matriculaId}")
    println("Balance de Créditos Final: ${estudiantePremium.consultarBalance()}")
}