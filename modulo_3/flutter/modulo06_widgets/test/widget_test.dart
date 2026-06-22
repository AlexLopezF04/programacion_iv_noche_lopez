import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:modulo06_widgets/main.dart';

void main() {
  testWidgets('App renders Saludo widget with paso 1', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Center(child: Saludo())),
    ));

    expect(find.text('Hola Flutter'), findsOneWidget);
  });
}
