import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutterproject/Principal.dart';
import 'package:flutterproject/Receita.dart';

void main() {
  testWidgets('App abre sem erros', (WidgetTester tester) async {
    await tester.pumpWidget(const Principal());

    expect(find.byType(Principal), findsOneWidget);
  });

  group('normalizarConsulta', () {
    test('remove espaços nas pontas e colapsa espaços internos', () {
      expect(normalizarConsulta('  bolo   de \t cenoura  '), 'bolo de cenoura');
    });

    test('só espaços ou nulo resultam em vazio', () {
      expect(normalizarConsulta('    '), '');
      expect(normalizarConsulta(null), '');
    });
  });

  group('Pesquisa de receita', () {
    Future<void> abrir(WidgetTester tester) =>
        tester.pumpWidget(const Principal());

    testWidgets('campo rotulado e botão Pesquisar existem', (tester) async {
      await abrir(tester);

      expect(find.text('Nome da receita'), findsOneWidget);
      expect(find.text('Pesquisar'), findsOneWidget);
    });

    testWidgets('consulta vazia é recusada com mensagem e sem pesquisa',
        (tester) async {
      await abrir(tester);

      await tester.tap(find.text('Pesquisar'));
      await tester.pump();

      expect(find.textContaining('Digite o nome da receita'), findsOneWidget);
      expect(find.textContaining('Pesquisando por'), findsNothing);
    });

    testWidgets('consulta só com espaços é recusada', (tester) async {
      await abrir(tester);

      await tester.enterText(find.byType(TextFormField), '     ');
      await tester.tap(find.text('Pesquisar'));
      await tester.pump();

      expect(find.textContaining('Digite o nome da receita'), findsOneWidget);
      expect(find.textContaining('Pesquisando por'), findsNothing);
    });

    testWidgets('consulta válida mostra o termo normalizado', (tester) async {
      await abrir(tester);

      await tester.enterText(find.byType(TextFormField), '  bolo   de cenoura ');
      await tester.tap(find.text('Pesquisar'));
      await tester.pump();

      expect(find.text('Pesquisando por: "bolo de cenoura"'), findsOneWidget);
      expect(find.textContaining('Digite o nome da receita'), findsNothing);
    });

    testWidgets('corrige entrada inválida e repete a pesquisa', (tester) async {
      await abrir(tester);

      await tester.tap(find.text('Pesquisar'));
      await tester.pump();
      expect(find.textContaining('Digite o nome da receita'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'pudim');
      await tester.pump();
      expect(find.textContaining('Digite o nome da receita'), findsNothing);

      await tester.tap(find.text('Pesquisar'));
      await tester.pump();
      expect(find.text('Pesquisando por: "pudim"'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'torta');
      await tester.tap(find.text('Pesquisar'));
      await tester.pump();
      expect(find.text('Pesquisando por: "torta"'), findsOneWidget);
      expect(find.text('Pesquisando por: "pudim"'), findsNothing);
    });

    testWidgets('nova consulta inválida descarta o feedback anterior',
        (tester) async {
      await abrir(tester);

      await tester.enterText(find.byType(TextFormField), 'pudim');
      await tester.tap(find.text('Pesquisar'));
      await tester.pump();
      expect(find.textContaining('Pesquisando por'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), '   ');
      await tester.tap(find.text('Pesquisar'));
      await tester.pump();

      expect(find.textContaining('Pesquisando por'), findsNothing);
      expect(find.textContaining('Digite o nome da receita'), findsOneWidget);
    });

    testWidgets('enviar pelo teclado também pesquisa', (tester) async {
      await abrir(tester);

      await tester.enterText(find.byType(TextFormField), 'feijoada');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      expect(find.text('Pesquisando por: "feijoada"'), findsOneWidget);
    });
  });
}
