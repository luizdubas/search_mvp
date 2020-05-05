import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_bloc.dart';
import 'search_loaded_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = SearchBloc();
    bloc.add(LoadProvidersEvent());
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        body: SafeArea(child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is ProvidersLoadedState) {
              return SearchLoadedWidget(providers: state.providers);
            }
            if (state is ProvidersLoadingErrorState) {
              return Container(
                color: Colors.red,
                child: Text('Error!!'),
              );
            }
            return Container(
              child: Text('Loading...'),
            );
          },
        )),
      ),
    );
  }
}
