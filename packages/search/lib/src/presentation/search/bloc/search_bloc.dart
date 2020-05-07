import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:list_diff/list_diff.dart';

import '../../../data/models/providers.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  @override
  SearchState get initialState => ProvidersLoadingState();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    try {
      yield* event.applyAsync(this);
    } catch (e) {
      yield state;
    }
  }
}
