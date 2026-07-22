import 'package:flutter_test/flutter_test.dart';
import 'package:modulo08_material3/main.dart';

void main() {
  testWidgets('AppMonitoreo muestra el servidor en paso 1', (WidgetTester tester) async {
    await tester.pumpWidget(const AppMonitoreo());
    expect(find.text('Servidor web-01'), findsOneWidget);
    expect(find.text('Conectar SSH'), findsOneWidget);
  });
}
