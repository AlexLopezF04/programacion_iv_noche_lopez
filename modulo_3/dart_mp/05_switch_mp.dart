void main() {
  String categoria = 'programacion';

  switch (categoria) {
    case 'programacion':
      print('Programación');
    case 'diseno':
      print('Diseño');
    case 'datos':
      print('Ciencia de Datos');
    case 'marketing':
      print('Marketing Digital');
    case 'negocios':
      print('Negocios');
    default:
      print('Categoría desconocida');
  }

  categoria = 'datos';

  String descripcion = switch (categoria) {
    'programacion' => 'Cursos de código y desarrollo',
    'diseno'       => 'Cursos de UI/UX y gráfico',
    'datos'        => 'Cursos de análisis y ML',
    'marketing'    => 'Cursos de redes y publicidad',
    'negocios'     => 'Cursos de emprendimiento',
    _              => 'Categoría no encontrada',
  };

  print(descripcion);
}
