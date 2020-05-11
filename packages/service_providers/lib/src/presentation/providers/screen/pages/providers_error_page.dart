import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:service_providers/src/data/managers/providers_manager.dart';
import '../../bloc/providers_bloc.dart';

class ProvidersErrorPage extends StatelessWidget {
  const ProvidersErrorPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<ProvidersBloc>();
    final manager = Provider.of<ProvidersManager>(context);
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.warning,
                color: Colors.red,
                size: 60.0,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Houve um erro ao carregar os dados!',
                  style: TextStyle(fontSize: 26),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.rotate_left),
                  iconSize: 52.0,
                  onPressed: () =>
                      bloc.add(LoadProvidersEvent(manager: manager)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
