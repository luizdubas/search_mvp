part of 'providers_bloc.dart';

abstract class ProvidersEvent extends Equatable {
  const ProvidersEvent();

  Stream<ProvidersState> applyAsync(ProvidersBloc bloc);
}
