import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication/authentication_bloc.dart';
import '../models/user_model.dart';
import '../utilities.dart';

class PublishersRequestScreen extends StatefulWidget {
  const PublishersRequestScreen({Key? key}) : super(key: key);

  @override
  _PublishersRequestScreenState createState() => _PublishersRequestScreenState();
}

class _PublishersRequestScreenState extends State<PublishersRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context) {
          BlocProvider.of<AuthenticationBloc>(context).add(FetchPublishersRequestEvent());
          return Scaffold(
            appBar: AppBar(
              title: const Text('Publishers Request'),
            ),
            body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if(state is AuthenticationLoadingState){
                  return Utilities.showCircularLoader('Fetching Notices Requests...');
                }else if(state is UserLoadedState){
                  return buildUserList(state.users);
                }
                return Container();
              },
            ),
          );
        }
    );
  }
  Widget buildUserList(List<UserModel> users){
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context,index){
        UserModel user = users[index];
        return ListTile(
          title: Text(user.firstName!),
        );
      },
    );
  }
}
