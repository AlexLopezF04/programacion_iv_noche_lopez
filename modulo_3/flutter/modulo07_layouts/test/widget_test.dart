import 'package:flutter_test/flutter_test.dart';

import 'package:modulo07_layouts/main.dart' as app;

void main() {
  testWidgets('App renders paso 1 by default', (WidgetTester tester) async {
    app.main();
    await tester.pump();
    expect(find.text('Servidor web-01'), findsOneWidget);
  });
}
