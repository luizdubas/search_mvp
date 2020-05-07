import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_diff/list_diff.dart';
import 'package:search/src/presentation/search/bloc/search_bloc.dart';

import '../../../data/models/providers.dart';
import '../bloc/search_bloc.dart';
import 'item/search_item.dart';

class SearchLoadedWidget extends StatelessWidget {
  SearchLoadedWidget({Key key, this.state}) : super(key: key) {
    _list = ListModel<Provider>(
      listKey: _listKey,
      initialItems: state.oldFilteredProvidersList ?? state.providers,
      removedItemBuilder: (item, context, animation) => null,
    );
  }

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final ProvidersLoadedState state;
  ListModel<Provider> _list;

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<SearchBloc>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print('>> Operations: ${state.operations.length}');
      for (var i = 0; i < state.operations.length; i++) {
        _applyOperation(state.operations[i]);
      }
      //state.operations.forEach(_applyOperation);
    });
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: TextField(
              maxLines: 1,
              onChanged: (text) => bloc.add(SearchProviderEvent(text)),
            ),
          ),
          Divider(),
          Expanded(
            child: AnimatedList(
              key: _listKey,
              itemBuilder: _buildItem,
              initialItemCount: _list.length,
            ),
          )
        ],
      ),
    );
  }

  void _applyOperation(Operation<Provider> operation) {
    var index = operation.index;
    print('>> >> Operation: ${operation.toString()}');
    if (operation.isInsertion)
      _list.insert(index, state.filteredProviders[index]);
    else
      _list.removeAt(index);
  }

  Widget _buildItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    return SearchItem(
      animation: animation,
      name: _list[index].name,
    );
  }
}

class ListModel<E> {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E> initialItems,
  })  : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items[index];
    if (removedItem != null) {
      _animatedList.removeItem(
        index,
        (BuildContext context, Animation<double> animation) =>
            removedItemBuilder(removedItem, context, animation),
      );
    }
    return _items.removeAt(index);
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}
