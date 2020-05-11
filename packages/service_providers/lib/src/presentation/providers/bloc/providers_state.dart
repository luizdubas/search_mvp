part of 'providers_bloc.dart';

abstract class ProvidersState extends Equatable {
  const ProvidersState();
}

class ProvidersLoadingState extends ProvidersState {
  const ProvidersLoadingState();

  @override
  List<Object> get props => [];
}

class ProvidersLoadingErrorState extends ProvidersState {
  const ProvidersLoadingErrorState();

  @override
  List<Object> get props => [];
}

class ProvidersLoadedState extends ProvidersState {
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
        operations,
      ];
}
