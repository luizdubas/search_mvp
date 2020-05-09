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
  final List<Provider> oldFilteredProviders;
  final List<Provider> filteredProviders;
  final List<Operation<Provider>> operations;

  ProvidersLoadedState({
    this.providers,
    this.oldFilteredProviders,
    this.filteredProviders,
    this.operations,
  });

  @override
  List<Object> get props => [
        providers,
        oldFilteredProviders,
        filteredProviders,
      ];
}
