import 'package:flutter/material.dart';

import '../../../data/models/providers.dart';
import 'item/search_item.dart';

class SearchLoadedWidget extends StatelessWidget {
  const SearchLoadedWidget({Key key, this.providers}) : super(key: key);

  final List<Provider> providers;

  @override
  Widget build(BuildContext context) {
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
            ),
          ),
          Divider(),
          Expanded(
            child: AnimatedList(
              itemBuilder: (context, index, animation) =>
                  SearchItem(name: providers[index].name),
              initialItemCount: providers.length,
            ),
          )
        ],
      ),
    );
  }
}
