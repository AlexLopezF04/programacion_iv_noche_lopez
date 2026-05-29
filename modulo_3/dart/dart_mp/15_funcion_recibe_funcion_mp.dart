// === FUNCIÓN DE ALTO ORDEN ===
// Recibe una lista de duraciones (en minutos) de los cursos y una función de criterio.
// Tipo del parámetro función: bool Function(int)
List<int> filtrarDuracionCursos(List<int> listaMinutos, bool Function(int) criterio) {
  // Aplicamos internamente el criterio funcional dinámico
  return listaMinutos.where(criterio).toList();
}

// Criterio A: Cursos tipo "Mini-Curso" o cápsulas rápidas (menos de 60 minutos)
bool esCursoExpress(int minutos) => minutos < 60;

// Criterio B: Cursos masivos o "Masterclasses" de larga duración (más de 180 minutos)
bool esMasterclass(int minutos) => minutos > 180;

void main() {
  // Lista con la duración en minutos de diferentes cursos del catálogo
  final catalogoDuraciones = [45, 120, 240, 30, 210, 85, 90, 315];

  print('=== FILTROS DEL CATÁLOGO DE CURSOS ===');

  // 1. Filtrar usando el criterio de Cursos Express
  final cursosCortos = filtrarDuracionCursos(catalogoDuraciones, esCursoExpress);
  print('Cursos rápidos (Express): $cursosCortos min');  
  // Resultado: [45, 30]

  // 2. Filtrar usando el criterio de Masterclasses
  final cursosLargos = filtrarDuracionCursos(catalogoDuraciones, esMasterclass);
  print('Cursos extensos (Masterclasses): $cursosLargos min'); 
  // Resultado: [240, 210, 315]

  // 3. Lambda en línea como argumento (Filtro personalizado instantáneo)
  // El usuario interactúa con la interfaz y busca cursos que duren exactamente un múltiplo de 30 minutos
  final cursosBloqueExacto = filtrarDuracionCursos(catalogoDuraciones, (minutos) => minutos % 30 == 0);
  print('Cursos con bloques exactos de 30 min: $cursosBloqueExacto min'); 
  // Resultado: [120, 240, 30, 90]
}