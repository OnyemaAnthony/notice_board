import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../models/user_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel user = (BlocProvider.of<AuthenticationBloc>(context).state.props[0] as UserModel);
    return Scaffold(
      floatingActionButton:user.isPublisher != null && user.isPublisher!?  FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){

        },
      ): Container(),
      appBar: AppBar(
        title:const Text('Notice Board'),
        centerTitle: true,
      ),
    );
  }
}
