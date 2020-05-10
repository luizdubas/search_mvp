import 'package:flutter/material.dart';

class ProvidersLoadingPage extends StatelessWidget {
  const ProvidersLoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
