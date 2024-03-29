import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/providers_bloc.dart';
import 'pages/providers_error_page.dart';
import 'pages/providers_loaded_page.dart';
import 'pages/providers_loading_page.dart';

class ProvidersScreen extends StatelessWidget {
  const ProvidersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: BlocBuilder<ProvidersBloc, ProvidersState>(
        builder: (context, state) {
          if (state is ProvidersLoadedState) {
            return ProvidersLoadedPage(state: state);
          }
          if (state is ProvidersLoadingErrorState) {
            return ProvidersErrorPage();
          }
          return ProvidersLoadingPage();
        },
      )),
    );
  }
}
