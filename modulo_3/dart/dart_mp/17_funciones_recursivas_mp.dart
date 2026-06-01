// === 1. FACTORIAL — CASO BASE Y CASO RECURSIVO ===
// Caso de uso: Algoritmo para calcular combinaciones de rutas de aprendizaje sugeridas 
// o permutaciones de ordenamiento de un set de preguntas en un examen aleatorio.
int calcularPermutacionesExamen(int cantidadPreguntas) {
  if (cantidadPreguntas <= 1) return 1;       // Caso base: detiene la recursión
  return cantidadPreguntas * calcularPermutacionesExamen(cantidadPreguntas - 1); // Llamada recursiva
}


// === 2. FIBONACCI — ÁRBOL DE LLAMADAS ===
// Caso de uso: Algoritmo para calcular la escala exponencial de puntos de experiencia (XP) 
// o insignias que requiere un alumno para subir de nivel de usuario.
int calcularEscalaPuntosNivel(int nivel) {
  if (nivel <= 1) return nivel; // Caso base
  return calcularEscalaPuntosNivel(nivel - 1) + calcularEscalaPuntosNivel(nivel - 2); // Llamada recursiva doble
}


// === 3. NAVEGACIÓN RECURSIVA EN ÁRBOL (Temario del Curso) ===
// Recorre el mapa del curso sin importar cuántos subniveles, secciones o carpetas de contenido 
// haya creado el instructor, y cuenta el total de lecciones de video finales disponibles.
int contarLeccionesTotales(Map<String, dynamic> estructuraContenido) {
  int totalLecciones = 0;
  
  for (final nodo in estructuraContenido.entries) {
    if (nodo.value is Map) {
      // Si el valor es otro Map, significa que es una Subsección o un Módulo anidado.
      // Hacemos la llamada recursiva para entrar a profundizar en ese subnivel.
      totalLecciones += contarLeccionesTotales(nodo.value as Map<String, dynamic>);
    } else {
      // Si no es un Map, llegamos al elemento final de la jerarquía (la lección ejecutable).
      totalLecciones++; 
    }
  }
  return totalLecciones;
}

void main() {
  // Ejecución de algoritmos base recursivos
  print('=== ALGORITMOS DE CONTROL Y PREMIACIÓN ===');
  print('Combinaciones posibles para ordenar un test de 6 preguntas: ${calcularPermutacionesExamen(6)}'); // 720
  print('Puntos base requeridos para alcanzar el Nivel 10: ${calcularEscalaPuntosNivel(10)} XP'); // 55

  // Estructura de un Curso con Secciones, Módulos y Clases anidadas (Árbol de Datos)
  final jerarquiaCursoFlutter = {
    'Sección 1: Introducción': {
      'Módulo de Configuración': {
        'instalacion_windows.mp4': true, 
        'instalacion_mac.mp4': true
      },
      'Módulo de Fundamentos': {
        'primer_hola_mundo.mp4': true
      },
      'Módulo de Sintaxis': {
        'variables_tipos.mp4': true, 
        'operadores_logicos.mp4': true
      },
    },
    'Sección 2: Widgets Esenciales': {
      'Módulo UI': {
        'uso_del_container.mp4': true
      }
    },
    'introduccion_al_instructor.mp4': true, // Clase suelta al inicio del curso
    'guia_rapida_atajos_pdf.pdf': true,     // Recurso de descarga suelto
  };

  print('\n=== CONTADOR AUTOMÁTICO DE CONTENIDO ===');
  print('Total de recursos/lecciones indexados en el curso: ${contarLeccionesTotales(jerarquiaCursoFlutter)}'); // 9
}