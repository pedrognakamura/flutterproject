import 'package:flutter_test/flutter_test.dart';

import 'package:flutterproject/Principal.dart';

void main() {
  testWidgets('App abre sem erros', (WidgetTester tester) async {
    await tester.pumpWidget(const Principal());

    expect(find.byType(Principal), findsOneWidget);
  });
}
