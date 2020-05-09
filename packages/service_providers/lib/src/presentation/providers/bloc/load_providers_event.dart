part of 'providers_bloc.dart';

class LoadProvidersEvent extends ProvidersEvent {
  @override
  Stream<ProvidersState> applyAsync(ProvidersBloc bloc) async* {
    try {
      if (bloc.state is ProvidersLoadingErrorState) {
        yield const ProvidersLoadingErrorState();
      }
      final loadedString = await rootBundle.loadString(
        'assets/providers.json',
      );
      final json = jsonDecode(loadedString) as List<dynamic>;
      final providers = json
          .map((value) => Provider.fromJson(value as Map<String, dynamic>))
          .toList();
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
