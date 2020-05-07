part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class ProvidersLoadingState extends SearchState {
  const ProvidersLoadingState();

  @override
  List<Object> get props => [];
}

class ProvidersLoadingErrorState extends SearchState {
  const ProvidersLoadingErrorState();

  @override
  List<Object> get props => [];
}

class ProvidersLoadedState extends SearchState {
  final List<Provider> providers;
  final String filter;
  final List<Provider> oldFilteredProvidersList;
  final List<Provider> filteredProviders;
  final List<Operation<Provider>> operations;

  ProvidersLoadedState({
    this.providers,
    this.filter,
    this.oldFilteredProvidersList,
    this.filteredProviders,
  }) : operations =
            oldFilteredProvidersList != null && filteredProviders != null
                ? diffSync(
                    oldFilteredProvidersList,
                    filteredProviders,
                  )
                : [];

  ProvidersLoadedState.filter(ProvidersLoadedState oldState, String filter)
      : this(
          providers: oldState.providers,
          filter: filter,
          oldFilteredProvidersList: oldState.filteredProviders,
          filteredProviders: filter != null && filter.isNotEmpty
              ? oldState.providers
                  .where((element) => element.name.startsWith(filter))
                  .toList()
              : oldState.providers,
        );

  @override
  List<Object> get props => [providers, filter];
}
