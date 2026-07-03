import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:modulo10_riverpod/screens/pantalla_dashboard.dart';

void main() {
  testWidgets('PantallaDashboard muestra NavigationBar',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: PantallaDashboard()),
      ),
    );

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Servidores'), findsWidgets);
    expect(find.text('Métricas'), findsOneWidget);
  });
}
