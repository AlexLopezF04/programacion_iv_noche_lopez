import 'package:flutter_test/flutter_test.dart';
import 'package:modulo08_material3/main.dart';

void main() {
  testWidgets('AppCursos muestra la navegación de academia online', (WidgetTester tester) async {
    await tester.pumpWidget(const AppCursos());
    expect(find.text('Academia Online'), findsOneWidget);
    expect(find.text('Progreso de Aprendizaje'), findsOneWidget);
  });
}

