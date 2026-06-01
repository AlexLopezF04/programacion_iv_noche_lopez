class Usuario {
  final String id;
  final String email;
  final String rol;
  final bool   tieneAccesoPremium;

  // 1. Constructor principal con parámetros nombrados
  Usuario({
    required this.id,
    required this.email,
    required this.rol,
    this.tieneAccesoPremium = false,
  });

  // 2. Constructor nombrado — Perfil rápido con configuración predefinida (Invitado de prueba)
  // Usa la lista de inicialización (:) para asignar valores fijos antes de que se cree la instancia
  Usuario.invitado()
      : id                 = 'USR-GUEST',
        email              = 'invitado@edutesh.com',
        rol                = 'ESTUDIANTE',
        tieneAccesoPremium = false;

  // 3. Constructor nombrado — Inicializa instructores fijos en producción
  Usuario.instructor({required this.id, required this.email})
      : rol                = 'INSTRUCTOR',
        tieneAccesoPremium = true;

  // 4. Constructor Factory — Lógica de creación e inicialización más compleja
  // Es ideal para procesar payloads/mapas de autenticación externa o tokens
  factory Usuario.desdePerfilSocial(String datosPerfilRaw) {
    // Simulamos el parseo o análisis de una cadena estructurada (ej. "nombre@correo.com|vip")
    final partes = datosPerfilRaw.split('|');
    final correoExtraido = partes[0];
    final esVip = partes.length > 1 && partes[1] == 'vip';

    // Un constructor factory tiene la obligación de retornar una instancia válida
    // de la clase mediante la invocación de alguno de los otros constructores.
    return Usuario(
      id: 'USR-${correoExtraido.hashCode}',
      email: correoExtraido,
      rol: 'ESTUDIANTE',
      tieneAccesoPremium: esVip,
    );
  }

  @override
  String toString() =>
      '[$rol] Email: $email | Premium: ${tieneAccesoPremium ? "SÍ" : "NO"}';
}

void main() {
  // Instanciación del constructor principal
  final u1 = Usuario(id: 'USR-001', email: 'alex@lopez.com', rol: 'ADMIN', tieneAccesoPremium: true);
  
  // Instanciación del constructor nombrado estático (.invitado)
  final u2 = Usuario.invitado();
  
  // Instanciación del constructor nombrado parametrizado (.instructor)
  final u3 = Usuario.instructor(id: 'INS-505', email: 'pachar@edutesh.com');
  
  // Instanciación del constructor Factory (.desdePerfilSocial) procesando un String formateado
  final u4 = Usuario.desdePerfilSocial('baconj@edutesh.com|vip');

  print(u1);  // [ADMIN] Email: alex@lopez.com | Premium: SÍ
  print(u2);  // [ESTUDIANTE] Email: invitado@edutesh.com | Premium: NO
  print(u3);  // [INSTRUCTOR] Email: pachar@edutesh.com | Premium: SÍ
  print(u4);  // [ESTUDIANTE] Email: baconj@edutesh.com | Premium: SÍ
}