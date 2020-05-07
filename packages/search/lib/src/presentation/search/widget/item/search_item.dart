import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({
    Key key,
    @required this.animation,
    @required this.name,
  }) : super(key: key);

  final String name;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizeTransition(
          axis: Axis.vertical,
          sizeFactor: animation,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      name,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
