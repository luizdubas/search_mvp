import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:service_providers/src/data/managers/providers_manager.dart';
import 'package:service_providers/src/presentation/providers/bloc/providers_bloc.dart';
import 'package:service_providers/src/presentation/providers/screen/pages/providers_error_page.dart';
import 'package:service_providers/src/presentation/providers/screen/pages/providers_loaded_page.dart';
import 'package:service_providers/src/presentation/providers/screen/pages/providers_loading_page.dart';
import 'package:service_providers/src/presentation/providers/screen/providers_screen.dart';

import '../../../data/fixtures/providers_fixtures.dart';

class MockProvidersManager extends Mock implements ProvidersManager {}

class TestApp extends StatelessWidget {
  const TestApp({Key key, this.manager, this.child, this.bloc})
      : super(key: key);

  final ProvidersBloc bloc;
  final ProvidersManager manager;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Provider(
        create: (_) => manager,
        child: BlocProvider(
          create: (_) => bloc,
          child: child,
        ),
      ),
    );
  }
}

void main() {
  final manager = MockProvidersManager();

  testWidgets('Can load and filter providers', (WidgetTester tester) async {
    final bloc = ProvidersBloc();

    await tester.pumpWidget(
      TestApp(
        manager: manager,
        child: ProvidersScreen(),
        bloc: bloc,
      ),
    );

    // Starts on loading screen
    expect(find.byType(ProvidersLoadingPage), findsOneWidget);

    when(manager.load()).thenAnswer((_) => Future.value(providersList));

    bloc.add(LoadProvidersEvent(manager: manager));
    await tester.pump();

    // Should load page
    expect(find.byType(ProvidersLoadedPage), findsOneWidget);
    expect(find.text('A+ Morumbi'), findsOneWidget);
    expect(find.text('Fleury - Avenida Brasil'), findsOneWidget);
    expect(find.text('Fleury Anália Franco II'), findsOneWidget);
    expect(find.text('Fleury Morumbi'), findsOneWidget);
    expect(find.text('a+ Angélica'), findsOneWidget);
    expect(find.text('a+ Brigadeiro'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'A+');
    await tester.pumpAndSettle();

    expect(find.text('A+ Morumbi'), findsOneWidget);
    expect(find.text('Fleury - Avenida Brasil'), findsNothing);
    expect(find.text('Fleury Anália Franco II'), findsNothing);
    expect(find.text('Fleury Morumbi'), findsNothing);
    expect(find.text('a+ Angélica'), findsNothing);
    expect(find.text('a+ Brigadeiro'), findsNothing);

    await tester.enterText(find.byType(TextField), 'Fleury -');
    await tester.pumpAndSettle();

    expect(find.text('A+ Morumbi'), findsNothing);
    expect(find.text('Fleury - Avenida Brasil'), findsOneWidget);
    expect(find.text('Fleury Anália Franco II'), findsNothing);
    expect(find.text('Fleury Morumbi'), findsNothing);
    expect(find.text('a+ Angélica'), findsNothing);
    expect(find.text('a+ Brigadeiro'), findsNothing);

    await tester.enterText(find.byType(TextField), 'a+');
    await tester.pumpAndSettle();

    expect(find.text('A+ Morumbi'), findsNothing);
    expect(find.text('Fleury - Avenida Brasil'), findsNothing);
    expect(find.text('Fleury Anália Franco II'), findsNothing);
    expect(find.text('Fleury Morumbi'), findsNothing);
    expect(find.text('a+ Angélica'), findsOneWidget);
    expect(find.text('a+ Brigadeiro'), findsOneWidget);

    bloc.close();
  });

  testWidgets('Can load providers after an error', (WidgetTester tester) async {
    final bloc = ProvidersBloc();

    await tester.pumpWidget(
      TestApp(
        manager: manager,
        child: ProvidersScreen(),
        bloc: bloc,
      ),
    );

    // Starts on loading screen
    expect(find.byType(ProvidersLoadingPage), findsOneWidget);

    when(manager.load()).thenAnswer((_) => Future.error(Exception('')));

    bloc.add(LoadProvidersEvent(manager: manager));
    await tester.pump();

    expect(find.byType(ProvidersErrorPage), findsOneWidget);
    expect(find.text('Houve um erro ao carregar os dados!'), findsOneWidget);

    when(manager.load()).thenAnswer((_) => Future.value(providersList));
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    // Should load page
    expect(find.byType(ProvidersLoadedPage), findsOneWidget);
    expect(find.text('A+ Morumbi'), findsOneWidget);
    expect(find.text('Fleury - Avenida Brasil'), findsOneWidget);
    expect(find.text('Fleury Anália Franco II'), findsOneWidget);
    expect(find.text('Fleury Morumbi'), findsOneWidget);
    expect(find.text('a+ Angélica'), findsOneWidget);
    expect(find.text('a+ Brigadeiro'), findsOneWidget);

    bloc.close();
  });
}
