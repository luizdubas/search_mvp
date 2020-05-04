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

  ProvidersLoadedState(this.providers);

  @override
  List<Object> get props => [providers];
}
