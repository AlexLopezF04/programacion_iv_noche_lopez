import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:modulo12_api/main.dart';

void main() {
  testWidgets('AppHttp builds menu', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: AppHttp()));
    expect(find.text('Módulo 12 — API REST'), findsOneWidget);
  });
}
