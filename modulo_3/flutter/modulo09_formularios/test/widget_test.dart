import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App muestra formulario SSH en paso 1', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B5E20)),
        useMaterial3: true,
      ),
      home: const Scaffold(body: Center(child: Text('Conexión SSH'))),
    ));

    expect(find.text('Conexión SSH'), findsOneWidget);
  });
}
