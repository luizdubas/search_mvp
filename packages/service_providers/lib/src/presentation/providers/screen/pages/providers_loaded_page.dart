import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_diff/list_diff.dart';

import '../../../../data/models/providers.dart';
import '../../bloc/providers_bloc.dart';
import 'item/provider_item.dart';

class ProvidersLoadedPage extends StatelessWidget {
  ProvidersLoadedPage({Key key, this.state}) : super(key: key) {
    _list = ListModel<Provider>(
      listKey: _listKey,
      initialItems: state.oldFilteredProviders ?? state.providers,
      removedItemBuilder: (item, context, animation) => Container(),
    );
  }

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final ProvidersLoadedState state;
  ListModel<Provider> _list;

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<ProvidersBloc>();
    if (state.operations != null)
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        for (var i = 0; i < state.operations.length; i++)
          _applyOperation(state.operations[i]);
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
              onChanged: (text) => bloc.add(SearchProvidersEvent(text)),
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
    return ProviderItem(
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
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(
        index,
        (BuildContext context, Animation<double> animation) =>
            removedItemBuilder(removedItem, context, animation),
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}
