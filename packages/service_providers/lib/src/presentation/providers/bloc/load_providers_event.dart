part of 'providers_bloc.dart';

class LoadProvidersEvent extends ProvidersEvent {
  final ProvidersManager manager;

  LoadProvidersEvent({this.manager = const ProvidersManager()});

  @override
  Stream<ProvidersState> applyAsync(ProvidersBloc bloc) async* {
    try {
      if (bloc.state is ProvidersLoadingErrorState) {
        yield const ProvidersLoadingErrorState();
      }
      final providers = await manager.load();
      yield ProvidersLoadedState(
        providers: providers,
        filteredProviders: providers,
      );
    } catch (e) {
      yield const ProvidersLoadingErrorState();
    }
  }

  @override
  List<Object> get props => [];
}
