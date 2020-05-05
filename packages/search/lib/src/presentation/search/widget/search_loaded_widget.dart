import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/src/presentation/search/bloc/search_bloc.dart';

import '../../../data/models/providers.dart';
import '../bloc/search_bloc.dart';
import 'item/search_item.dart';

class SearchLoadedWidget extends StatelessWidget {
  SearchLoadedWidget({Key key, this.providers}) : super(key: key);

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Provider> providers;
  ListModel<Provider> get _list {
    return ListModel<Provider>(
      listKey: _listKey,
      initialItems: providers,
      removedItemBuilder: _buildRemovedItem,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<SearchBloc>();
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

  Widget _buildRemovedItem(
    Provider item,
    BuildContext context,
    Animation<double> animation,
  ) {
    return SearchItem(
      animation: animation,
      name: item.name,
    );
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
