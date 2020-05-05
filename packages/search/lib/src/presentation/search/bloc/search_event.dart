part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  Stream<SearchState> applyAsync(SearchBloc bloc);
}

class LoadProvidersEvent extends SearchEvent {
  @override
  Stream<SearchState> applyAsync(SearchBloc bloc) async* {
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
      yield ProvidersLoadedState(providers, null);
    } catch (e) {
      yield const ProvidersLoadingErrorState();
    }
  }

  @override
  List<Object> get props => [];
}
