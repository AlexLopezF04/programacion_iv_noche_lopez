// =========================================================================
// INTERFACES CON COMPORTAMIENTOS POR DEFECTO IDÉNTICOS
// =========================================================================

interface NotificadorBaseDatos {
    // Método con implementación por defecto
    fun registrarEvento() {
        println("💾 [PERSISTENCIA]: Escribiendo registro de auditoría en la tabla PostgreSQL...")
    }
}

interface NotificadorLogsSistema {
    // Firma idéntica con diferente comportamiento de bajo nivel
    fun registrarEvento() {
        println("📝 [SYSTEM LOGS]: Inyectando traza de advertencia en el archivo 'stdout.log' de Azure...")
    }
}

// =========================================================================
// CLASE CONCRETA: Resuelve la ambigüedad explícitamente (Resolución de Conflictos)
// =========================================================================
class AdministradorAuditoria : NotificadorBaseDatos, NotificadorLogsSistema {

    // El compilador obliga a aplicar 'override' porque hay una colisión de firmas por defecto
    override fun registrarEvento() {
        // 1. Invocación calificada: Rompemos la ambigüedad indicando el tipo entre <>
        super<NotificadorBaseDatos>.registrarEvento()
        
        // 2. Invocación calificada: Ejecutamos el segundo contrato complementario
        super<NotificadorLogsSistema>.registrarEvento()
        
        // 3. Añadimos lógica particular del servicio unificado
        println("🚀 [AUDITORÍA CORE]: Evento replicado de forma síncrona en todos los canales.")
    }
}

// =========================================================================
// HILO PRINCIPAL DE EJECUCIÓN (main)
// =========================================================================
fun main() {
    println("=== MÓDULO DE INFRAESTRUCTURA: RESOLUCIÓN DE AMBIGÜEDAD ===\n")

    val servicioAuditoria = AdministradorAuditoria()
    
    // Al ejecutar el método, se dispara el flujo gobernado y ordenado por la clase concreta
    servicioAuditoria.registrarEvento()
}