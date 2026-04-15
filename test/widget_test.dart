
import 'package:flutter_test/flutter_test.dart';
import 'package:fidelix/main.dart';

void main() {
  testWidgets('App inicia na tela de escolha de usuário', (WidgetTester tester) async {
    await tester.pumpWidget(const MeuApp());

    // verifica se aparece a tela inicial
    expect(find.text("Bem-vindo!"), findsOneWidget);
    expect(find.text("Sou Cliente"), findsOneWidget);
    expect(find.text("Sou Comerciante"), findsOneWidget);
  });

  testWidgets('Navega para login ao escolher cliente', (WidgetTester tester) async {
    await tester.pumpWidget(const MeuApp());

    // clica em "Sou Cliente"
    await tester.tap(find.text("Sou Cliente"));
    await tester.pumpAndSettle();

    // verifica se foi pra tela de login
    expect(find.text("Entrar"), findsWidgets);
  });
}
