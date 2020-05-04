import 'package:flutter/material.dart';

import 'item/search_item.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                      SearchItem(name: 'Test'),
                  initialItemCount: 40,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
