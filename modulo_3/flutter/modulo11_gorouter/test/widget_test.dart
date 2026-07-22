import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modulo11_gorouter/main.dart';

void main() {
  testWidgets('App renders inicio screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: AppMonitoreo(paso: 1)),
    );
    await tester.pumpAndSettle();

    expect(find.text('Monitor SSH'), findsOneWidget);
    expect(find.text('Dashboard de Monitoreo'), findsOneWidget);
  });
}
