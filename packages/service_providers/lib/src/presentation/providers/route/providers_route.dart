import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../data/managers/providers_manager.dart';
import '../bloc/providers_bloc.dart';
import '../screen/providers_screen.dart';

class ProvidersRoute {
  Widget build(BuildContext context) {
    final manager = ProvidersManager();
    return Provider(
      create: (_) => manager,
      child: BlocProvider(
        create: (context) {
          final bloc = ProvidersBloc();
          bloc.add(LoadProvidersEvent(manager: manager));
          return bloc;
        },
        child: ProvidersScreen(),
      ),
    );
  }
}
