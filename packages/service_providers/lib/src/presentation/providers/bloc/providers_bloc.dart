import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:list_diff/list_diff.dart';
import 'package:service_providers/src/data/managers/providers_manager.dart';

import '../../../data/models/providers.dart';

part 'providers_event.dart';
part 'load_providers_event.dart';
part 'search_providers_event.dart';
part 'providers_state.dart';

class ProvidersBloc extends Bloc<ProvidersEvent, ProvidersState> {
  @override
  ProvidersState get initialState => ProvidersLoadingState();

  @override
  Stream<ProvidersState> mapEventToState(
    ProvidersEvent event,
  ) async* {
    try {
      yield* event.applyAsync(this);
    } catch (e) {
      yield ProvidersLoadingErrorState();
    }
  }
}
