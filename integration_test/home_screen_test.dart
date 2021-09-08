import 'package:ebc_app/main.dart';
import 'package:ebc_app/repository/ebc_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("Home screen", () {
    testWidgets("First start", (WidgetTester tester) async {
      runApp(MyApp(ebcRepository: LocalEbcRepository()));
      await tester.pumpAndSettle();

      expect(find.text("GENESIS"), findsOneWidget);
    });

    testWidgets("Add 3 elements", (WidgetTester tester) async {
      final repo = LocalEbcRepository();
      for (int x = 0; x < 3; x++) repo.add("$x");
      runApp(MyApp(ebcRepository: repo));
      await tester.pumpAndSettle();

      expect(find.text("4"), findsOneWidget);
      ;
    });

    testWidgets("Create block", (WidgetTester tester) async {
      final repo = LocalEbcRepository();
      runApp(MyApp(ebcRepository: repo));
      await tester.pumpAndSettle();

      final addFinder = find.byKey(Key("add"));
      await tester.tap(addFinder);
      await tester.pumpAndSettle();

      expect(find.byKey(Key("add-alert")), findsOneWidget);

      final inputFinder = find.byKey(Key("input"));
      await tester.enterText(inputFinder, "https://google.com");

      await tester.tap(find.text("Insert"));
      await tester.pumpAndSettle();

      expect(find.text("https://google.com"), findsOneWidget);
    });

    testWidgets("Detail screen", (WidgetTester tester) async {
      final repo = LocalEbcRepository();
      for (int x = 0; x < 3; x++) repo.add("$x");
      runApp(MyApp(ebcRepository: repo));
      await tester.pumpAndSettle();

      await tester.tap(find.text("4"));
      await tester.pumpAndSettle();

      expect(find.text("2"), findsOneWidget);
    });

  });
}
