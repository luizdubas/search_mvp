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

  List<Provider> get filteredProviders {
    if (filter == null || filter.isEmpty) {
      return providers;
    }
    return providers
        .where((element) => element.name.startsWith(filter))
        .toList();
  }

  ProvidersLoadedState(this.providers, this.filter);

  @override
  List<Object> get props => [providers, filter];
}
