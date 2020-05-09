part of 'providers_bloc.dart';

class SearchProvidersEvent extends ProvidersEvent {
  final String filter;

  SearchProvidersEvent(this.filter);

  @override
  Stream<ProvidersState> applyAsync(ProvidersBloc bloc) async* {
    if (!(bloc.state is ProvidersLoadedState)) {
      yield bloc.state;
    }
    final currentState = bloc.state as ProvidersLoadedState;
    final filteredProviders = currentState.providers
        .where((element) => _matchStart(
              element,
              filter,
            ))
        .toList();
    final oldFilteredProviders =
        currentState.filteredProviders ?? currentState.providers;
    final operations = diffSync(
      oldFilteredProviders,
      filteredProviders,
    );
    yield ProvidersLoadedState(
      providers: currentState.providers,
      oldFilteredProviders: oldFilteredProviders,
      filteredProviders: filteredProviders,
      operations: operations,
    );
  }

  bool _matchStart(Provider element, String filter) {
    return element.name.startsWith(filter);
  }

  @override
  List<Object> get props => [];
}
