import 'package:flutter_test/flutter_test.dart';
import 'package:list_diff/list_diff.dart';
import 'package:mockito/mockito.dart';
import 'package:service_providers/src/data/managers/providers_manager.dart';
import 'package:service_providers/src/data/models/providers.dart';
import 'package:service_providers/src/presentation/providers/bloc/providers_bloc.dart';

import '../../../data/fixtures/providers_fixtures.dart';

class MockProvidersManager extends Mock implements ProvidersManager {}

void main() {
  const ProvidersLoadingState initialState = ProvidersLoadingState();

  ProvidersBloc bloc;
  MockProvidersManager manager;

  setUp(() {
    bloc = ProvidersBloc();
    manager = MockProvidersManager();
  });

  tearDown(() {
    bloc?.close();
  });

  test('initial state is loading', () {
    expect(
      bloc.state,
      initialState,
    );
  });

  group('Providers load event', () {
    test('successfully load providers', () {
      final expectedState = ProvidersLoadedState(
        providers: providersList,
        filteredProviders: providersList,
      );

      when(manager.load())
          .thenAnswer((realInvocation) => Future.value(providersList));
      final event = LoadProvidersEvent(manager: manager);

      expectLater(
        bloc,
        emitsInOrder([
          initialState,
          expectedState,
        ]),
      );

      bloc.add(event);
    });

    test('send error state on load error', () {
      final expectedState = ProvidersLoadingErrorState();

      when(manager.load()).thenAnswer((realInvocation) =>
          Future.error(Exception('Failed to load providers')));
      final event = LoadProvidersEvent(manager: manager);

      expectLater(
        bloc,
        emitsInOrder([
          initialState,
          expectedState,
        ]),
      );

      bloc.add(event);
    });
  });

  group('Search providers event', () {
    test('mantain state when current state is not ProviderLoadedState', () {
      final event = SearchProvidersEvent('A+');

      expectLater(
        bloc,
        emitsInOrder([
          initialState,
          emitsDone,
        ]),
      );

      bloc.add(event);
    });

    test('filter loaded events', () {
      final filteredProviders = [
        Provider(name: 'Fleury - Avenida Brasil'),
        Provider(name: 'Fleury Anália Franco II'),
        Provider(name: 'Fleury Morumbi'),
      ];
      final operations = diffSync(providersList, filteredProviders);
      final loadedState = ProvidersLoadedState(
        providers: providersList,
        filteredProviders: providersList,
      );
      final expectedState = ProvidersLoadedState(
        providers: providersList,
        oldFilteredProviders: providersList,
        filteredProviders: filteredProviders,
        operations: operations,
      );

      when(manager.load())
          .thenAnswer((realInvocation) => Future.value(providersList));
      final loadEvent = LoadProvidersEvent(manager: manager);

      final searchEvent = SearchProvidersEvent('Fleury ');

      expectLater(
        bloc,
        emitsInOrder([
          initialState,
          loadedState,
        ]),
      ).then((value) {
        expectLater(
          bloc,
          emitsInOrder([
            initialState,
            loadedState,
            expectedState,
          ]),
        );

        bloc.add(searchEvent);
      });

      bloc.add(loadEvent);
    });
  });
}
