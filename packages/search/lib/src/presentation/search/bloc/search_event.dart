part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  Stream<SearchState> applyAsync(SearchBloc bloc);
}
