import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/providers_bloc.dart';
import '../screen/providers_screen.dart';

class ProvidersRoute {
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = ProvidersBloc();
        bloc.add(LoadProvidersEvent());
        return bloc;
      },
      child: ProvidersScreen(),
    );
  }
}
